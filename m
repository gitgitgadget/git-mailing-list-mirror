From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [RFC PATCH] hooks: add some defaults to support sane workflow to pre-commit
Date: Fri, 20 Feb 2009 21:49:22 +0100
Message-ID: <C95EAEB9-D520-497F-BA42-0CDCC1348340@wincent.com>
References: <499EF2B6.7060103@hvoigt.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Heiko Voigt <git-list@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Feb 20 21:51:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LacKq-00038C-Ax
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 21:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261AbZBTUtb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Feb 2009 15:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753393AbZBTUtb
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 15:49:31 -0500
Received: from wincent1.inetu.net ([209.235.192.161]:57300 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbZBTUta convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2009 15:49:30 -0500
Received: from cuzco.lan (101.pool85-53-4.dynamic.orange.es [85.53.4.101])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n1KKnNMi016936
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 20 Feb 2009 15:49:26 -0500
In-Reply-To: <499EF2B6.7060103@hvoigt.net>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110889>

El 20/2/2009, a las 19:13, Heiko Voigt escribi=F3:

> As far as I know all "sane" workflows involve topic branches, so
> normally a developer will never commit directly on master but use =20
> topic
> branch instead and merge them into master once finished.

(Shudder... by that definition there must be a lot of insane people =20
out there!)

I think what constitutes a "sane" workflow depends very much on the =20
project in question, the number of developers, the collaboration model =
=20
etc.

I imagine there are plenty of developers (particularly those working =20
alone on small or private projects) for whom working directly on =20
"master" makes a lot of sense; after all, one of the great things =20
about distributed SCM is that what people do in their own private =20
repos is really up to them.

And what about "topics" that are really just a single commit? A one =20
line spelling fix, for example. Should that be done on a topic branch =20
and merged in too?

Horses for courses. In my own projects I work on master for some =20
things, and on topic branches for others, and I feel very sane.

Cheers,
Wincent
