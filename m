From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Garbage in .git directories???
Date: Sun, 18 Sep 2005 10:10:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509181009160.26803@g5.osdl.org>
References: <200509172141.31591.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 19:11:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH2gp-0007S3-7J
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 19:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVIRRKk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 18 Sep 2005 13:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbVIRRKk
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 13:10:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5020 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932118AbVIRRKj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2005 13:10:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8IHAbBo005241
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Sep 2005 10:10:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8IHAZvl022056;
	Sun, 18 Sep 2005 10:10:36 -0700
To: Dmitry Torokhov <dtor_core@ameritech.net>
In-Reply-To: <200509172141.31591.dtor_core@ameritech.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8788>



On Sat, 17 Sep 2005, Dmitry Torokhov wrote:
>=20
> git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux-2.6.git work
>=20
> and it seems there is some garbage in .git directory:
>
> drwxrwxr-x    2 dtor dtor 4096 Sep 17 21:17 V?Cl?=ED=AE=9F?E ???#V?C?=
?=C5=BFl??E#V?C??;H
>                                             ^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^=20
> The similar garbage(?) shows when I clone git's repository.
>=20
> Is this expected?

Absolutely not. And I don't see it when I try. What filesystem are you=20
running this on? Looks like something did a "mkdir()" with an=20
uninitialized pointer, but I don't see how that would happen.

		Linus
