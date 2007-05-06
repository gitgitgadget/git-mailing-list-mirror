From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: How to set git commit timestamp
Date: Sun, 06 May 2007 19:26:54 +0200
Message-ID: <463E0FDE.3000504@lsrfire.ath.cx>
References: <Pine.LNX.4.64.0705061759210.8165@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Guido Ostkamp <git@ostkamp.fastmail.fm>
X-From: git-owner@vger.kernel.org Sun May 06 19:27:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkkVu-000847-5I
	for gcvg-git@gmane.org; Sun, 06 May 2007 19:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257AbXEFR1J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 6 May 2007 13:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754375AbXEFR1J
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 13:27:09 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:53855
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754257AbXEFR1I (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 13:27:08 -0400
Received: from [10.0.1.201] (p508E49A0.dip.t-dialin.net [80.142.73.160])
	by neapel230.server4you.de (Postfix) with ESMTP id 198DB16005;
	Sun,  6 May 2007 19:27:05 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <Pine.LNX.4.64.0705061759210.8165@bianca.dialin.t-online.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46349>

Guido Ostkamp schrieb:
> Hello,
>=20
> does somebody know a method to specify a timestamp for a 'git commit'=
?
>=20
> I am writing a tool to convert from another SCM to git and need to
> replay all checkins. I know how to set the log message and the author=
,
> but there appears to be no command option for the timestamp (Mercuria=
l
> for example, has a 'hg commit -d date <file>' syntax for this).

You can use the environment variable GIT_COMMITTER_DATE to force a
specific commit date.  Please see the man page of git-commit-tree for
(some) more info.

Ren=E9
