Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 31319 invoked by uid 107); 22 Feb 2010 19:27:14 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 22 Feb 2010 14:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753763Ab0BVT0w (ORCPT <rfc822;peff@peff.net>);
	Mon, 22 Feb 2010 14:26:52 -0500
Received: from u15218177.onlinehome-server.com ([82.165.184.25]:55604 "EHLO
	olra.theworths.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab0BVT0v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 14:26:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id CF8D0431FBF;
	Mon, 22 Feb 2010 11:26:50 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xnG95oqJAY9E; Mon, 22 Feb 2010 11:26:49 -0800 (PST)
Received: from yoom.home.cworth.org (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id B4514431FAE;
	Mon, 22 Feb 2010 11:26:49 -0800 (PST)
Received: by yoom.home.cworth.org (Postfix, from userid 1000)
	id E458925427B; Mon, 22 Feb 2010 11:26:48 -0800 (PST)
From:	Carl Worth <cworth@cworth.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michal Sojka <sojkam1@fel.cvut.cz>,
	Pierre Habouzit <madcoder@debian.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	notmuch@notmuchmail.org, git@vger.kernel.org
Subject: Re: [PATCH] test-lib.sh: Add explicit license detail, with change
 from GPLv2 to GPLv2+.
In-Reply-To: <7vaav3bnr5.fsf@alter.siamese.dyndns.org>
References: <87ljf8pvxx.fsf@yoom.home.cworth.org>
	<87hbpwpoko.fsf@yoom.home.cworth.org>
	<5641883d1002060727ia4e6c16lf800a92fc8735430@mail.gmail.com>
	<201002081614.24284.sojkam1@fel.cvut.cz>
	<871vgr78lr.fsf@yoom.home.cworth.org>
	<87iqa2y0gz.fsf@steelpick.localdomain>
	<87r5oqe7mi.fsf@yoom.home.cworth.org>
	<871vgmki4f.fsf@steelpick.localdomain>
	<7vaav8hpfo.fsf@alter.siamese.dyndns.org>
	<87tytdiqob.fsf@steelpick.localdomain>
	<alpine.DEB.1.00.1002191138280.20986@pacific.mpi-cbg.de>
	<873a0xhwxs.fsf@yoom.home.cworth.org>
	<alpine.DEB.1.00.1002192204050.20986@pacific.mpi-cbg.de>
	<87eikfhec1.fsf@yoom.home.cworth.org>
	<7vaav3bnr5.fsf@alter.siamese.dyndns.org>
Date:	Mon, 22 Feb 2010 11:26:48 -0800
Message-ID: <87y6ilf4w7.fsf@yoom.home.cworth.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

From=208693995fde71e8b028318e1e83bdbb6ae759335a Mon Sep 17 00:00:00 2001
From: Carl Worth <cworth@cworth.org>
Date: Sat, 20 Feb 2010 11:41:24 -0800
Subject: [PATCH] test-lib.sh: Add explicit license detail, with change from=
 GPLv2 to GPLv2+.

This file has had no explicit license information noted in it, but
has clearly been created and modified according to the terms of GPLv2
as with the rest of the git code base.

The purpose of relicensing is to allow other GPLv3+ projects (in
particular, the notmuch project: http://notmuchmail.org) to use this
same test-suite structure and to contribute changes back as well.

The relicensing was agreed to by Junio C Hamano here:

http://thread.gmane.org/gmane.mail.notmuch.general/1389/focus=3D140156

and in follow-up messages by Sverre Rabbelier, Johannes Schindelin,
Pierre Habouzit, and Johannes Sixt.

Signed-off-by: Carl Worth <cworth@cworth.org>
Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
=2D--

> Message-ID alone is not a good way to help people locate the request.
> Please at least mention what mailing list the message was sent to; better
> yet, do so like this:

Done as requested.

But while we're on the subject, let me at least make a case for
communication by way of Message-ID. The URL above is good for as long as
gmane continues to live, but that may not be as long as the git project
(and its mailing-list archives) are interesting.

Meanwhile, a message ID lives forever and can be used in multiple
contexts. For example, gmane does already support message-ID-based URLs:

http://mid.gmane.org/7vaav3bnr5.fsf@alter.siamese.dyndns.org

That interface happens to only display the single message, (requiring
clicking on the subject to see the thread), but one can imagine gmane
getting a similar interface to display the thread directly from the
message ID.

Meanwhile, people using systems like notmuch can also use the message ID
directly to view the thread, with something like:

    notmuch show id:7vaav3bnr5.fsf@alter.siamese.dyndns.org

So I'm very much in favor of using message IDs more regularly, (and just
expecting that users and their tools will be more accepting of them).

But for now, you've hopefully got your commit message the way you want
it. :-)

 t/test-lib.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index afd3053..004470f 100644
=2D-- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -2,6 +2,18 @@
 #
 # Copyright (c) 2005 Junio C Hamano
 #
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation, either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see http://www.gnu.org/licenses/ .
=20
 # if --tee was passed, write the output not only to the terminal, but
 # additionally to the file test-results/$BASENAME.out, too.
=2D-=20
1.6.5.7


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iD8DBQFLgtp46JDdNq8qSWgRAiWJAJ9rogmNhcIsqUf8yOTNCuJBH8PeLACgl3l4
WjQ+KxwJqWnLdVG6H0aZH38=
=mBnb
-----END PGP SIGNATURE-----
--=-=-=--
