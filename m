From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 2/2] .mailmap: mark bouncing email addresses
Date: Fri,  9 Aug 2013 20:18:25 +0200
Message-ID: <1376072305-15255-3-git-send-email-stefanbeller@googlemail.com>
References: <1376072305-15255-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 09 20:18:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7rGm-00071X-UI
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 20:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967938Ab3HISSa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Aug 2013 14:18:30 -0400
Received: from mail-ea0-f178.google.com ([209.85.215.178]:53000 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758623Ab3HISS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 14:18:28 -0400
Received: by mail-ea0-f178.google.com with SMTP id a15so2241495eae.9
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 11:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7frrklSflCs+ahUb8kKzkHhiDMMKZgrPRbVAjrFVN08=;
        b=q8haIClTIw6OmKNc1UJPg1RuR96/KfL0NuFqqyVBUNwI7YWIeQrHVM607xw86tTXbP
         tbC9XRK9p5/u16gumiRckkXkufpm4eRbE35M1cXtP2kvo1qxgFBMJn+nuKnQarScsT8Q
         Wvk+Y25HNxarP99wKkQmEKazdv3T/pk8yu/JdyBs5rQhFSnrGOmPGOXBZv9y7wdW/gaf
         D/xehYydg69S8oINq5WB0gSFilo8r8Fqf0Yf5VJxyeCxpSyq5S+UTwRODfLPTRtx3nOc
         bJp265L1u78d00O7hdD7NP/Zo66+ybJ/ZId8LjEEKdh5wWbjcAX76QUc5OpQozjTxA6X
         J84w==
X-Received: by 10.15.111.13 with SMTP id ci13mr1827660eeb.136.1376072306840;
        Fri, 09 Aug 2013 11:18:26 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id j2sm30826709eep.6.2013.08.09.11.18.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 11:18:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc2
In-Reply-To: <1376072305-15255-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232007>

We cannot be sure whether these are the same person,
hence we will not map their different mail addresses
to one person. However this commit documents, some
bouncing mail addresses, so these need not be tried
again, when somebody continues the .mailmap cleanup.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 .mailmap | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/.mailmap b/.mailmap
index 840abf7..3b235b5 100644
--- a/.mailmap
+++ b/.mailmap
@@ -18,6 +18,10 @@ Alexey Shumkin <alex.crezoff@gmail.com> <Alex.Crezof=
f@gmail.com>
 Anders Kaseorg <andersk@MIT.EDU> <andersk@ksplice.com>
 Anders Kaseorg <andersk@MIT.EDU> <andersk@mit.edu>
 Aneesh Kumar K.V <aneesh.kumar@gmail.com>
+# The 2 following authors are probably the same person,
+# but both emails bounce.
+Amos Waterland <apw@rossby.metr.ou.edu>
+Amos Waterland <apw@us.ibm.com>
 Ben Walton <bdwalton@gmail.com> <bwalton@artsci.utoronto.ca>
 Bernt Hansen <bernt@norang.ca> <bernt@alumni.uwaterloo.ca>
 Brandon Casey <drafnel@gmail.com> <casey@nrlssc.navy.mil>
@@ -34,6 +38,10 @@ Dan Johnson <computerdruid@gmail.com>
 Dana L. How <danahow@gmail.com> <how@deathvalley.cswitch.com>
 Dana L. How <danahow@gmail.com> Dana How
 Daniel Barkalow <barkalow@iabervon.org>
+# The 2 following authors are probably the same person,
+# but both emails bounce.
+Daniel Trstenjak <daniel.trstenjak@online.de>
+Daniel Trstenjak <trsten@science-computing.de>
 David Brown <git@davidb.org> <davidb@quicinc.com>
 David D. Kilzer <ddkilzer@kilzer.net>
 David K=C3=A5gedal <davidk@lysator.liu.se>
@@ -68,11 +76,19 @@ J. Bruce Fields <bfields@citi.umich.edu> <bfields@p=
ig.linuxdev.us.dell.com>
 J. Bruce Fields <bfields@citi.umich.edu> <bfields@puzzle.fieldses.org>
 Jakub Nar=C4=99bski <jnareb@gmail.com>
 James Y Knight <jknight@itasoftware.com> <foom@fuhm.net>
+# The 2 following authors are probably the same person,
+# but both emails bounce.
+Jason McMullan <jason.mcmullan@timesys.com>
+Jason McMullan <mcmullan@netapp.com>
 Jason Riedy <ejr@eecs.berkeley.edu> <ejr@EECS.Berkeley.EDU>
 Jason Riedy <ejr@eecs.berkeley.edu> <ejr@cs.berkeley.edu>
 Jay Soffian <jaysoffian@gmail.com> <jaysoffian+git@gmail.com>
 Jeff King <peff@peff.net> <peff@github.com>
 Jeff Muizelaar <jmuizelaar@mozilla.com> <jeff@infidigm.net>
+# The 2 following authors are probably the same person,
+# but both emails bounce.
+Jens Axboe <axboe@suse.de>
+Jens Axboe <jens.axboe@oracle.com>
 Jim Meyering <jim@meyering.net> <meyering@redhat.com>
 Joachim Berdal Haga <cjhaga@fys.uio.no>
 Johannes Schindelin <Johannes.Schindelin@gmx.de> <johannes.schindelin@=
gmx.de>
@@ -144,6 +160,8 @@ Michele Ballabio <barra_cuda@katamail.com>
 Miklos Vajna <vmiklos@frugalware.org> <vmiklos@suse.cz>
 Namhyung Kim <namhyung@gmail.com> <namhyung.kim@lge.com>
 Namhyung Kim <namhyung@gmail.com> <namhyung@kernel.org>
+# The 2 following authors are probably the same person,
+# but both emails bounce.
 Nanako Shiraishi <nanako3@bluebottle.com>
 Nanako Shiraishi <nanako3@lavabit.com>
 Nelson Elhage <nelhage@mit.edu> <nelhage@MIT.EDU>
@@ -177,6 +195,10 @@ Robert Fitzsimons <robfitz@273k.net>
 Robert Shearman <robertshearman@gmail.com> <rob@codeweavers.com>
 Robert Zeh <robert.a.zeh@gmail.com>
 Robin Rosenberg <robin.rosenberg@dewire.com> <robin.rosenberg.lists@de=
wire.com>
+# The 2 following authors are probably the same person,
+# but both emails bounce.
+Rutger Nijlunsing <rutger@nospam.com>
+Rutger Nijlunsing <git@tux.tmfweb.nl>
 Ryan Anderson <ryan@michonline.com> <rda@google.com>
 Salikh Zakirov <salikh.zakirov@gmail.com> <Salikh.Zakirov@Intel.com>
 Sam Vilain <sam@vilain.net> <sam.vilain@catalyst.net.nz>
--=20
1.8.4.rc2
