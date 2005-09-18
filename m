From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Garbage in .git directories???
Date: Sun, 18 Sep 2005 12:54:13 -0500
Message-ID: <200509181254.14646.dtor_core@ameritech.net>
References: <200509172141.31591.dtor_core@ameritech.net> <Pine.LNX.4.58.0509181009160.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 19:55:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH3Mu-00087C-Cq
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 19:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbVIRRyV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 18 Sep 2005 13:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVIRRyV
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 13:54:21 -0400
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:27573 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932142AbVIRRyV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2005 13:54:21 -0400
Received: (qmail 95624 invoked from network); 18 Sep 2005 17:54:16 -0000
Received: from unknown (HELO mail.corenet.homeip.net) (dtor?core@ameritech.net@69.208.153.209 with login)
  by smtp113.sbc.mail.re2.yahoo.com with SMTP; 18 Sep 2005 17:54:16 -0000
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8.2
In-Reply-To: <Pine.LNX.4.58.0509181009160.26803@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8798>

On Sunday 18 September 2005 12:10, Linus Torvalds wrote:
>=20
> On Sat, 17 Sep 2005, Dmitry Torokhov wrote:
> >=20
> > git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvald=
s/linux-2.6.git work
> >=20
> > and it seems there is some garbage in .git directory:
> >
> > drwxrwxr-x    2 dtor dtor 4096 Sep 17 21:17 V?Cl?=ED=AE=9F?E ???#V?=
C??=C5=BFl??E#V?C??;H
> >                                             ^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^=20
> > The similar garbage(?) shows when I clone git's repository.
> >=20
> > Is this expected?
>=20
> Absolutely not. And I don't see it when I try. What filesystem are yo=
u=20
> running this on? Looks like something did a "mkdir()" with an=20
> uninitialized pointer, but I don't see how that would happen.
>=20
> 		Linus
>=20

It is ext3 on 2.6.12-rc6.

--=20
Dmitry
