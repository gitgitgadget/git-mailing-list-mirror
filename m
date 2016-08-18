Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D933F1F6C1
	for <e@80x24.org>; Thu, 18 Aug 2016 13:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947056AbcHRNDg (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 09:03:36 -0400
Received: from mout.gmx.net ([212.227.17.22]:57707 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932129AbcHRNDe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 09:03:34 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MS5jy-1blwFw0YvK-00TFCU; Thu, 18 Aug 2016 14:46:14
 +0200
Date:	Thu, 18 Aug 2016 14:46:13 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] cat-file: fix a grammo in the man page
In-Reply-To: <cover.1471524357.git.johannes.schindelin@gmx.de>
Message-ID: <561560a6144f775fdde3fa51f4acc54867797027.1471524357.git.johannes.schindelin@gmx.de>
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:OS6ug9IbQl+vgPi7KUZPA+asG3rks4kaey/hqe5gzUGt1QArwTq
 na2vjQsf91zJUeGLEExfrfp6Ieh+9HqL6FsLEZHG5HAtglAMH62XqdtEkSiP78nrkXzXiKa
 CCEDwbAYfyhUA+n8suo2cV5sxS9SjJyGs8ZJAU3Pao0kCq07wd3AwVC+lAAJBgTSVRLRuOW
 vclXC1i9j81qSVuI08ZzA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Rhr7ajFqiNw=:ObBoivpv9qgq1ooIcSHCtj
 gybI74KVZRUoamlE/OF3ZyjKbACOT9giuxnPSSDe96dhEiH00mNAb+L7mP/fhZ5yAuKLRgEqB
 ip3v/eru7UmlaBwEaCNFHO9KKdx5zToTYQlVTdgiMf78k8HjjtUTxwyZkJuGE5+J20ExXsK4N
 p3onjS4lyX2ySvR5oOTy6d7OMMggi2NEj6wQmW7DEiPk1kBiIEw53rXnrYY3m5CxM3C8VnwYu
 cHGpPfqXWlsTqEk5tzV4Wwb8TR16G5UkqwrLiZm1gp8jwPDs1sJ2PPVyzMpfmEk0Tu1QKnIWm
 hp+k8fZ5I/UR3gXGINimXXrp2w1uJ7s8GSiGR2YGyKWZjKO69FvrauyUw6ScnIRoub/auQbTb
 gb4JfUpPCYS3czBeIIuHIFNDlpAPsK/fbbvRgzvCNmo2VFiKm7prsDpCDXL7QCsRgKh/cbKMr
 qnTodIPVjJui3F75ofuQ/p/z8kjZtImgRTyA8jowCYXsrskgomaoLwVz+vt/AOSNyVzQWiKKp
 XKGa3giHyXVp/9KztqP4sR70dj1bAjV9X4dcT5ID6+xK0SEnUMrSWgnmAtLiOsGQe2Nd1VHXI
 3qPX25l4/+jFLV4FN+zwL1RBtS0BWF1GiGoQ1O/ERudVUvw4usuBIQKo0ciJRh6O3oE85tcR5
 ZHJ22/n6unCXdpQRSIFj3tbghxk7C7I6zYD1PSiLRKt4fz0STzjncBpI+mFPaQMfQlSovUwib
 B9hiM5fv4wCcCECE0bP9FwSjpUo93XHzsnMLJMGPI5QRUroVNRd/sNLCqlYdhdswLiYZ6VsJQ
 HSgvdRS
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

"... has be ..." -> "... has to be ..."

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-cat-file.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 18d03d8..071029b 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -54,8 +54,9 @@ OPTIONS
 
 --textconv::
 	Show the content as transformed by a textconv filter. In this case,
-	<object> has be of the form <tree-ish>:<path>, or :<path> in order
-	to apply the filter to the content recorded in the index at <path>.
+	<object> has to be of the form <tree-ish>:<path>, or :<path> in
+	order to apply the filter to the content recorded in the index at
+	<path>.
 
 --batch::
 --batch=<format>::
-- 
2.9.2.691.g78954f3


