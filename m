Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CD661FAAD
	for <e@80x24.org>; Wed,  1 Feb 2017 12:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752075AbdBAMBU (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 07:01:20 -0500
Received: from mout.gmx.net ([212.227.15.15]:49654 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751950AbdBAMBT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 07:01:19 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lg0wl-1c6Tg829yV-00pZd0; Wed, 01
 Feb 2017 13:01:07 +0100
Date:   Wed, 1 Feb 2017 13:01:06 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 2/4] connect: rename tortoiseplink and putty variables
In-Reply-To: <cover.1485950225.git.johannes.schindelin@gmx.de>
Message-ID: <8d4852942119d378a4a625e97704cab88e769d8f.1485950225.git.johannes.schindelin@gmx.de>
References: <cover.1485442231.git.johannes.schindelin@gmx.de> <cover.1485950225.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:w/hpXxfb88KAZR3MgAXtSfNJuSe59GpEpskWDnb8R+kNW2fSVCt
 1FIPoWJ0k1AeV1xsDpnN1H9GFX1n69R6p7p8zfYEr/E09whG/xTv3mIOfxdacBccXASKBCG
 5FOaEv6nDpE6dSWz0qgOv5CheWZg9bqBmpxfLyPxYAwGdqVOPeGwW5uDWuViWctmgyz2/Nh
 gGVSkwW4spzhyGXNffK+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HsBq8DYsL1Q=:Y9kaf2UpzPomZcRMIA4Pem
 oTu3TuDhYWYVoHWp+MPoSQ74XYJduYkQK4EBOtRXCoXR2Fj7Ay8nBxO/Ki+BBRI92gP7Z9uAy
 KgkxpdwA4HStz9hZszGWvLPVqt7uK0+cCdepAx49XRrOPANzGwg5RV+vSk5TJGZgo7qy5Dzkp
 Zj1Wz0sJiQzZFfJY8VIIfjkyjjqpRtm5QhDsgDfhJE9issLzi2ojyuuAXlg7/ijsueGQ3s/si
 QYCCUrx9AAjCeo864S4iBTxqIMRp0I1QWItVmtzGoAgMP3eUzE1M8JlEKv+ykC/MhothDEc0i
 s9dfZ7NPfAzgfPZ/96lYlZUYGcniGaEYAizKuotQIfJEi9xfHkL5IB/V/Bgqkfb3GOLGIwOFo
 CD7aatkS3KjXEfZoA+OXUHlNeriE7RRY0Gk+/R4sUqQr7XOjTJitV6HZO/h8tW0LZXQzXxPdq
 kpvlrnjO0znKGfV6tdINrtm/8Pu5IcKLzChjdEmPSvWfJX43+8Iz4MfUDzhem878yBM6UwqDU
 4mQPCOCmyVkoHKWCcc8BAzy9Q+wewxO7G+UibxKUUTvMf3xeGWDImS7CwE0Yqmx0+EEYzowiN
 wKNbjlU/Ud5kiJT0Pdu+Oc9Rszl4bHWZTGAL4cMdFw6zVqhZTqfSCnUdofx2VRpdzj4n8Q9+B
 oErupELTIaxx3qZKUR7PXTsauu4REyYN0SEcef09i6Jd5kRR+IBchJjqKUKBBrN6l9FbTaJg8
 VrJU4wBUGu2pY+BQOqPGyOzlfDfPbRiVRvBG9+UvoJCB2ZlGrHdatDdzthj7uFDkG+ROHETna
 sf/sibtM1WG2rTbidUKPEgQzlYW3g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

One of these two may have originally been named after "what exact
SSH implementation do we have" so that we can tweak the command line
options, but these days "putty=1" no longer means "We are using the
plink SSH implementation that comes with PuTTY".  It is set when we
guess that either PuTTY plink or Tortoiseplink is in use.

Rename them after what effect is desired.  The current "putty"
option is about using "-P <port>" when OpenSSH would use "-p <port>",
so rename it to port_option whose value is either 'p' or 'P".  The
other one is about passing an extra command line option "-batch",
so rename it needs_batch.

[jes: wrapped overly-long line]

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 connect.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/connect.c b/connect.c
index c81f77001b..9f750eacb6 100644
--- a/connect.c
+++ b/connect.c
@@ -769,7 +769,8 @@ struct child_process *git_connect(int fd[2], const char *url,
 		conn->in = conn->out = -1;
 		if (protocol == PROTO_SSH) {
 			const char *ssh;
-			int putty = 0, tortoiseplink = 0;
+			int needs_batch = 0;
+			int port_option = 'p';
 			char *ssh_host = hostandport;
 			const char *port = NULL;
 			char *ssh_argv0 = NULL;
@@ -819,12 +820,14 @@ struct child_process *git_connect(int fd[2], const char *url,
 			if (ssh_argv0) {
 				const char *base = basename(ssh_argv0);
 
-				tortoiseplink = !strcasecmp(base, "tortoiseplink") ||
-					!strcasecmp(base, "tortoiseplink.exe");
-				putty = tortoiseplink ||
-					!strcasecmp(base, "plink") ||
-					!strcasecmp(base, "plink.exe");
-
+				if (!strcasecmp(base, "tortoiseplink") ||
+				    !strcasecmp(base, "tortoiseplink.exe")) {
+					port_option = 'P';
+					needs_batch = 1;
+				} else if (!strcasecmp(base, "plink") ||
+					   !strcasecmp(base, "plink.exe")) {
+					port_option = 'P';
+				}
 				free(ssh_argv0);
 			}
 
@@ -833,11 +836,11 @@ struct child_process *git_connect(int fd[2], const char *url,
 				argv_array_push(&conn->args, "-4");
 			else if (flags & CONNECT_IPV6)
 				argv_array_push(&conn->args, "-6");
-			if (tortoiseplink)
+			if (needs_batch)
 				argv_array_push(&conn->args, "-batch");
 			if (port) {
-				/* P is for PuTTY, p is for OpenSSH */
-				argv_array_push(&conn->args, putty ? "-P" : "-p");
+				argv_array_pushf(&conn->args,
+						 "-%c", port_option);
 				argv_array_push(&conn->args, port);
 			}
 			argv_array_push(&conn->args, ssh_host);
-- 
2.11.1.windows.prerelease.2.9.g3014b57


