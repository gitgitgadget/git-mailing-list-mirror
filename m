Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BBAC2018E
	for <e@80x24.org>; Wed, 24 Aug 2016 12:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755148AbcHXMYn (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 08:24:43 -0400
Received: from mout.gmx.net ([212.227.15.19]:56919 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753461AbcHXMX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 08:23:58 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MS5xC-1bjnXO2IXq-00TBfo; Wed, 24 Aug 2016 14:23:36
 +0200
Date:   Wed, 24 Aug 2016 14:23:36 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 1/4] cat-file: fix a grammo in the man page
In-Reply-To: <cover.1472041389.git.johannes.schindelin@gmx.de>
Message-ID: <e913d0e680bc1b976f53bc36960444529cf379eb.1472041389.git.johannes.schindelin@gmx.de>
References: <cover.1471524357.git.johannes.schindelin@gmx.de> <cover.1472041389.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0jsrEaFaujagxczrBMAZ/+tmVK/QzRG/8pAu1CD6rUSSOAMAXyT
 TZ45wG3dKk4VEUCGJ30hxdpD2BOFi/26qikxWxIVrYqKxMgaIWbq2rl9qYJgIURc6tId6ZW
 ey5z4LlwJW7X7c0ML+u14UTH1sJ/5xsTy+NzMR4OLnXZGSXqQrFIZd6yHWwGP4dnPGZlfv9
 qovKs3PS5qxOlp1ph1q7Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LPnGJEqUsPk=:XMF/eUmKJn6jNzkLjUWRlu
 FFLf1RosBURTdPbLXMTmZ7FAFgmqTw3gpawwDVEcYCYmpBEOCO+kgzvDxo765OESCoRN6nlIN
 zo7U/hLiZSHBOH/QNvu/9fa2gdmSGTufd5xWKd/EjlPkutS62RnTJlHS4RaJOCFdgPLcSZI9x
 9WCt4lABuMu/WgxARbCR9tc3SmtqZcKYTT9uKD1DWsqtep6HLxISXZR70WNWSnrgQ9uYcd9km
 QJBEqVuIj5HoW2Lb3z84yDYj98X97aiw0LOlXRdXKM2nKX9rZYzs+aD9EY9Gka8w2jv6LuXWg
 AVhrrte4OCb0c/0qUFEqH4lLGgiElpxcV4WhVd113Wsw9ms6aCyvX5KL+4L+GmhrJA9DsbVr0
 aRnSLCO/Oi+88PtjuXOA5UwtLx6pUO6tIWUYmX2kP4rRUzip22R1aSbH0DbCw5weqOXpG86xI
 jz6UOASBE/pvwOSPdggQrgLs7g81FCkSuNFAmBKNz4M6XVitA3l2F8JKiTkWQGNXeqEbuwp1b
 NEWJn2nQpGrDMcQOsup8kBfSkBhJ28ha/3i87bGinEXX1U0MF4eZWj3jkEDP2Tyslq+eXBv0q
 2NddezTfG5DZx7CXEutg0er00rvcfp0hjiA2aq0N4PHfiwtLbF4CI8bNHb/ybRirj8zetrB9R
 /iN2DlsSg2yI4pmKYG/GvkJZ5qOK3DrfNfoxIw7fS3THrCcLC2qpbNxqy1wIBajgOECxbqeCv
 f6ycpsgJr99z2f+IOqciN1/qCTbDve70ULINphTrFgbpu5SmrLvIDrst7y947DvONFToabUlF
 Zb0sIYU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
2.10.0.rc1.99.gcd66998


