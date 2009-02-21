From: Heiko Voigt <git-list@hvoigt.net>
Subject: Re: [RFC PATCH] hooks: add some defaults to support sane workflow
 to pre-commit
Date: Sat, 21 Feb 2009 11:56:02 +0100
Message-ID: <499FDDC2.90502@hvoigt.net>
References: <499EF2B6.7060103@hvoigt.net> <C95EAEB9-D520-497F-BA42-0CDCC1348340@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 11:57:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LapYB-0005I2-4U
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 11:57:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbZBUK4K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Feb 2009 05:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbZBUK4I
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 05:56:08 -0500
Received: from darksea.de ([83.133.111.250]:58437 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750963AbZBUK4H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 05:56:07 -0500
Received: (qmail 5610 invoked from network); 21 Feb 2009 11:55:55 +0100
Received: from unknown (HELO macbook.lan) (127.0.0.1)
  by localhost with SMTP; 21 Feb 2009 11:55:55 +0100
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
In-Reply-To: <C95EAEB9-D520-497F-BA42-0CDCC1348340@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110937>

Wincent Colaiuta schrieb:
> El 20/2/2009, a las 19:13, Heiko Voigt escribi=F3:
>=20
>> As far as I know all "sane" workflows involve topic branches, so
>> normally a developer will never commit directly on master but use to=
pic
>> branch instead and merge them into master once finished.
>=20
> (Shudder... by that definition there must be a lot of insane people o=
ut
> there!)
>=20
> I think what constitutes a "sane" workflow depends very much on the
> project in question, the number of developers, the collaboration mode=
l etc.

You are right I was thinking to specific. My goal with this RFC is to
add some default behaviour to git in terms of workflows and prevent som=
e
common pitfalls.=20

This leads me to a completely different solution to the same problem.
How about teaching git to inherit its hooks from the parental project
(e.g. the one it was cloned from)? That way we are not limited to
one default behaviour but many that would match the one from the
upstream project.

The simplest implementation would just copy the hooks directory when
cloning and leave customizations to the user. This should probably be
disabled by default and enabled with a config option on the server side=
=2E

What do you think about that?

cheers Heiko
