From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Garbage in .git directories???
Date: Mon, 19 Sep 2005 19:09:21 -0500
Message-ID: <200509191909.22026.dtor_core@ameritech.net>
References: <200509172141.31591.dtor_core@ameritech.net> <200509182333.58227.dtor_core@ameritech.net> <Pine.LNX.4.58.0509190747210.9106@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 02:37:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHW7b-0003ma-E5
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 02:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbVITAfz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 19 Sep 2005 20:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbVITAfz
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 20:35:55 -0400
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:1444 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964804AbVITAfy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 20:35:54 -0400
Received: (qmail 33389 invoked from network); 20 Sep 2005 00:35:53 -0000
Received: from unknown (HELO mail.corenet.homeip.net) (dtor?core@ameritech.net@69.219.239.52 with login)
  by smtp104.sbc.mail.re2.yahoo.com with SMTP; 20 Sep 2005 00:35:53 -0000
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8.2
In-Reply-To: <Pine.LNX.4.58.0509190747210.9106@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8937>

On Monday 19 September 2005 09:51, Linus Torvalds wrote:
>=20
> On Sun, 18 Sep 2005, Dmitry Torokhov wrote:
> >=20
> > Couple more points - just using rsync to get the data (without usin=
g git)
> > does not not produce that wierd directory, only got clone does.
>=20
> Does a plain "git-init-db" in a newly created empty directory do the =
same? =20
> There was a bug (a long time ago)  that created garbage instead of th=
e
> template files, I think.
>

Yes, plain git-init-db produces the garbage.

[dtor@anvil tst]$ git-init-db
defaulting to local storage area
[dtor@anvil tst]$ ls -l .git/
total 32
drwxrwxr-x    2 dtor dtor 4096 Sep 19 19:08 branches
-rw-rw-r--    1 dtor dtor   58 Sep 19 19:08 description
lrwxrwxrwx    1 dtor dtor   17 Sep 19 19:08 HEAD -> refs/heads/master
drwxrwxr-x    2 dtor dtor 4096 Sep 19 19:08 hooks
drwxrwxr-x    2 dtor dtor 4096 Sep 19 19:08 info
drwxrwxr-x  260 dtor dtor 4096 Sep 19 19:08 objects
drwxrwxr-x    4 dtor dtor 4096 Sep 19 19:08 refs
drwxrwxr-x    2 dtor dtor 4096 Sep 19 19:08 remotes
drwxrwxr-x    2 dtor dtor 4096 Sep 19 19:08 V?Cl???E ???#V?C??=D5=BFl??=
E#V?C??;H
[dtor@anvil tst]$ git --version
git version 0.99.7

(Actually this is last night's pull).


--=20
Dmitry
