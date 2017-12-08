Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2882720C31
	for <e@80x24.org>; Fri,  8 Dec 2017 17:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752559AbdLHRqj (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 12:46:39 -0500
Received: from mout.web.de ([212.227.15.3]:60560 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752003AbdLHRqi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 12:46:38 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MY1Am-1eaXz13Vjc-00UvwE; Fri, 08
 Dec 2017 18:46:35 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, ashishnegi33@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 1/2] t0027: Don't use git commit <empty-pathspec>
Date:   Fri,  8 Dec 2017 18:46:33 +0100
Message-Id: <20171208174633.9903-1-tboegi@web.de>
X-Mailer: git-send-email 2.15.1.271.g1a4e40aa5d
In-Reply-To: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
References: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:3lbCwbYYdVeWftaKcK3sZXAcPXMrX74jUDrjVGizi+2wm724U8n
 skU6H/f+1a38RpOWgfLFUgqvJtxyA98TjNMZ+Vmvinot0nD7zpe+us2wAvlPwmHTxMMCpOn
 vYiuP2r+Brhm3/stFsAt+sNZ1IAN6Ti2V7M2y9OJwz+lCFC9+DeL0Wboe5DAiHPZt2fzDey
 DpX/gRc76Q1a94JtQImmA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l0W+dvHRySA=:baR5112HfmYrSMTryfqV/d
 8XWLbFBhgE68WzIdYuD9S4CTd0BrpqY4/J/ImEefhWvNTILK1AI7e5v8q3v+1bf0AlM4RkRjo
 Ct+kC+Bc8q/Ic67BewHIju2yVrOfr4XjMZ3j+5XjU2+ZPqgorJ2nBqoK1cbH1fCnRVdOSJCcT
 R434pVFdQJgr+9PYeI0PX+puIreUPDEsbKJ/Ng+YpICfg6zJ4sTDmcKRu6nxPdP65omdyLqZl
 Ywb3gjGFr7+nl4VXNjsOv+tKnBwMSx6bQZbDkP6PcxrsMSQtYG8/nsM8OtZkR0a38EbDhJLoo
 UFvZLXGQaOTw8B9QcyVp6LvSinJmzw0Mxm8bKPwYn77d6+9JQIbTCPvHWOIvS+5K9YdQJ776U
 ntQ5DQq1fPcCzTOp9GqwRIUVaeP5VGpi9plGH/B9fTDwD06ZkHzrZ6EKN7+bDZcDuRMVQT5Sf
 CD9+DVJhN8ZfV6NC9+VfrfEOZOVIJJ9+4LKFtuaad5Sc6WwiXz/LZBQit4Kt7Sqxf9H4djPWd
 6xp5x9bdT4sVO8per1UQZxU6mKc/sYfwiB4EBwNap7pxx0OodXPT5wb4c2QevL5nsmvEXYPu/
 9QNV4eW0gq66t7MQpFuVDXBKUABn3Cp2OWaJ9DuDWX7SZntUsAyhvIFKVes/njf2L4IAkQHfF
 1gz/HYI/SYU9Bx9YPjqLgnPEzzSbIchvTf6ujJNSMEnnZ8uBMneoZv4txma5wdknJVCLjPbns
 HhZkPwrOjBg11Bt7QLMcY+bVMkPesnIbM/G/a0mr8kArXZLHrG5KNdCG7cmBUOVJjsLmRHvJC
 K1DVUwOw35LfFkpUxdfUtrY01HPlpENsBitwqpuBwffUC8zMKY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

Replace `git commit -m "comment" ""` with `git commit -m "comment"` to
remove the empty path spec.

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 t/t0027-auto-crlf.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index c2c208fdcd..97154f5c79 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -370,7 +370,7 @@ test_expect_success 'setup master' '
 	echo >.gitattributes &&
 	git checkout -b master &&
 	git add .gitattributes &&
-	git commit -m "add .gitattributes" "" &&
+	git commit -m "add .gitattributes" &&
 	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONE\nLINETWO\nLINETHREE"     >LF &&
 	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nLINEONE\r\nLINETWO\r\nLINETHREE" >CRLF &&
 	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONE\r\nLINETWO\nLINETHREE"   >CRLF_mix_LF &&
-- 
2.15.1.271.g1a4e40aa5d

