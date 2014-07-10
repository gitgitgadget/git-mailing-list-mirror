From: Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH] .mailmap: Map different names with the same email address together
Date: Thu, 10 Jul 2014 14:48:26 +0200
Message-ID: <1404996506-7723-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: jl@opera.com, ksaitoh560@gmail.com, vnwildman@gmail.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 10 14:48:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5DmA-0004je-0I
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 14:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbaGJMsd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jul 2014 08:48:33 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:50162 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436AbaGJMsc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 08:48:32 -0400
Received: by mail-wi0-f182.google.com with SMTP id d1so2177721wiv.3
        for <git@vger.kernel.org>; Thu, 10 Jul 2014 05:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=TUycRKATHBeXudfbQRRmXQACa2jt9BdE6ipRmfQu13c=;
        b=pPkut8+vcUBy+vLUY74ZcraDX87rVrKOWhEq0LGrjMWgBz0wm/Kc0bFPIu/FbR4ySo
         eKR0OeYb18Y8x3X+STXz4lAZpphN7eddMu68xiIh1oZikzoRFXxKHRffrTv35cl6tc6n
         QRho/28MgOtq+qACvifzLHdBX2P2zeIHe72tQ6RXyS5DtphCc/5t3UVuaGk5I2h9x8UJ
         4LjaRtyqU/LNnJrdljZ32VbUDWevlEHPJR1MFtqMQORGyc514mC8SXIXkV9D16fPZoKW
         UB+nE3UCBcu2MuFVDn3FkiustVnnw4dC5mWMw318IfoDWeoPrABpJ8pB0NWrOEuqpUOn
         tyjw==
X-Received: by 10.194.158.226 with SMTP id wx2mr20237175wjb.107.1404996511608;
        Thu, 10 Jul 2014 05:48:31 -0700 (PDT)
Received: from localhost (eduroamerw-244-124.uni-paderborn.de. [131.234.244.124])
        by mx.google.com with ESMTPSA id fw4sm31474869wib.19.2014.07.10.05.48.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 10 Jul 2014 05:48:30 -0700 (PDT)
X-Google-Original-From: Stefan Beller <stefanbeller@googlemail.com>
X-Mailer: git-send-email 2.0.1.472.g6f92e5f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253186>

Pretty much one year ago
(94b410bba864, Jul 12 2013, .mailmap: Map email addresses to names)
I cleaned up the output of `git shortlog -sne` of git.git by writing a
=2Emailmap file fot the git.git project.
Now I find some time again for another review.
During the year Jens, Kazuki and Tr=E1=BA=A7n contributed to git.git us=
ing
different names, but the same email address.

Would you mind to acknowledge this change to the mailmap file?

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 .mailmap | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.mailmap b/.mailmap
index 11057cb..2edbeb5 100644
--- a/.mailmap
+++ b/.mailmap
@@ -85,6 +85,7 @@ Jeff King <peff@peff.net> <peff@github.com>
 Jeff Muizelaar <jmuizelaar@mozilla.com> <jeff@infidigm.net>
 Jens Axboe <axboe@kernel.dk> <axboe@suse.de>
 Jens Axboe <axboe@kernel.dk> <jens.axboe@oracle.com>
+Jens Lindstr=C3=B6m <jl@opera.com> Jens Lindstrom <jl@opera.com>
 Jim Meyering <jim@meyering.net> <meyering@redhat.com>
 Joachim Berdal Haga <cjhaga@fys.uio.no>
 Johannes Schindelin <Johannes.Schindelin@gmx.de> <johannes.schindelin@=
gmx.de>
@@ -113,6 +114,7 @@ Karsten Blees <blees@dcon.de> <karsten.blees@dcon.d=
e>
 Karsten Blees <blees@dcon.de> <karsten.blees@gmail.com>
 Kay Sievers <kay.sievers@vrfy.org> <kay.sievers@suse.de>
 Kay Sievers <kay.sievers@vrfy.org> <kay@mam.(none)>
+Kazuki Saitoh <ksaitoh560@gmail.com> kazuki saitoh <ksaitoh560@gmail.c=
om>
 Keith Cascio <keith@CS.UCLA.EDU> <keith@cs.ucla.edu>
 Kent Engstrom <kent@lysator.liu.se>
 Kevin Leung <kevinlsk@gmail.com>
@@ -229,6 +231,7 @@ Tommi Virtanen <tv@debian.org> <tv@inoi.fi>
 Tommy Thorn <tommy-git@thorn.ws> <tt1729@yahoo.com>
 Tony Luck <tony.luck@intel.com>
 Tor Arne Vestb=C3=B8 <torarnv@gmail.com> <tavestbo@trolltech.com>
+Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vnwildman@gmail.com> Tran Ngoc Qu=
an <vnwildman@gmail.com>
 Trent Piepho <tpiepho@gmail.com> <tpiepho@freescale.com>
 Trent Piepho <tpiepho@gmail.com> <xyzzy@speakeasy.org>
 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> <Uwe.Kleine-Koe=
nig@digi.com>
--=20
2.0.1.472.g6f92e5f
