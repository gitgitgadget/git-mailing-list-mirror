Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C27D1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 23:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932803AbdCXX2s (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 19:28:48 -0400
Received: from mout.gmx.net ([212.227.17.21]:54649 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755581AbdCXX2r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 19:28:47 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MeLKt-1cX0qd2rVP-00QDWq; Sat, 25
 Mar 2017 00:28:40 +0100
Date:   Sat, 25 Mar 2017 00:28:39 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/7] mingw: enable DC_AND_OPENSSL_SHA1 by default
In-Reply-To: <cover.1490397869.git.johannes.schindelin@gmx.de>
Message-ID: <6582a2da7a322dd309733933803d714db8e8fff9.1490397869.git.johannes.schindelin@gmx.de>
References: <cover.1490397869.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VS8wqspQScYVrXm7qwTw1SKgwgsjqyweBoyrmncaw0rmHyWus/u
 FjjQmCDakimRdBLyQkR5tBgG8RO8ET8vNwHP4uw2jztyYf0brP/+2eV40PdNjoMnCPY5z5Q
 u1dNpHn1saZi7ShDMipUZpi556kxpETT8uO0+mzFXWuajqGhyqblYzBvGErWo8SSzX95+z+
 AQ1PSMFre+jNF8kND75dQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tuDCfmFreuA=:IJeYwlqoED8R9vILGwQ3DD
 Oo2bSOUU6sMTWEdzsqg6aB6c+T49tcfeDjTeyCmp7ssrcxCWdIM+yc1vOMyNlkfvSUFUCQ3H1
 lwB7E6tn7Yt65pRX1DpNC06cGUAY0L9HeY8NZYwhINU9MDRIMYz1W2mSduF3eV0JL3vDnabnI
 xPkNCa4f8Kr5/kAZ/lDwqt1EK8RZqeYWVSMPYVkRw2lFyq6TzKmcwJ1linTeskrPR3GXPgXcb
 boYjVUuuHf3YsZHC6KnHfExAjmqWnjhD1EjOt9/7PHvaFjcAJdvOxwEzafQOz2nlPI69UkB0i
 7r+tzydCIcbPb3ytVKdx0rxL6y47L/mmKH6cvHSW8JDWPTIpAqLdWPjMtj0iJgwJipwDePEBE
 MJZTZUAUeMH13m8E1E6M3vdDn5M6DrWy35MBauG7tG2+9b0Zr4H6iO+491PKNFgChpRJ/19xE
 /Z4/vNRtshlcsi4h8ol1+mvJSJzTofuMJ03QU0EijxikZjJRqYjshHFHR9/9O9naGAsxiaE2C
 eHOjzPbNrMiyYjasE0yu7XLYHYMDXyThRItAdmUELwjOKwjzhv4hs1SdwQ9c6ZuEEUwWsFIwI
 TWRfenj6RY93Q9Ab9JvC7E3Z13fQHcrJMRdtexMi6OPL8L9dbr19Bw+hhvqdtFDvjgzpYD03n
 8BkFIW9eEM2Rv4/lqYVHugZs8+T0BQix4Inlr6cYjlHqdWhJNQtAYA1akee4Yd9Uutaopj2Ea
 qdPqBdzbk4nabx4Bi/ZZ0D4tFj4tyTZ03N8SzdjXhiFyBhTl+t1p0dT3VqQQ2fJ+2FjMjIXH8
 HHlzl3E0450IQZIC4PSp1VRcPeWLw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 399fe192719..a16e9ef0551 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -552,6 +552,7 @@ else
 		USE_LIBPCRE= YesPlease
 		NO_CURL =
 		USE_NED_ALLOCATOR = YesPlease
+		DC_AND_OPENSSL_SHA1 = YesPlease
 	else
 		COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO
 		NO_CURL = YesPlease
-- 
2.12.1.windows.1


