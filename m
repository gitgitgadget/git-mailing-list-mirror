Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B52E20357
	for <e@80x24.org>; Fri, 14 Jul 2017 14:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754543AbdGNOph (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 10:45:37 -0400
Received: from mout.gmx.net ([212.227.17.20]:51044 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754530AbdGNOpg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 10:45:36 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MC7em-1dNGQ511H6-008p68; Fri, 14
 Jul 2017 16:45:29 +0200
Date:   Fri, 14 Jul 2017 16:45:28 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v6 09/10] t3415: test fixup with wrapped oneline
In-Reply-To: <cover.1500043436.git.johannes.schindelin@gmx.de>
Message-ID: <3883eb7fcc4efb414aab51f586474d846241e8a1.1500043437.git.johannes.schindelin@gmx.de>
References: <cover.1500043436.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iBUfJ4ysx3xJX2pIkrPD+olPeqlwgYcEn8DtpywlGnOyidOXawM
 Ueq/tRbVKYb47IUOd5CJF/1Ujc9rIsb+5LWZzvVKwlPfe3hsPl5VWC1PjIoicK2AWSGDLPh
 21reufGT6dkzjYDSvTYcaeLUNshKYQtEQG5Xt4Mgq0+iaRvQiiLGuDl9h0d7IRqP4K055ly
 HS4zmJ1NeJBiZn1gYAWvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:D6IT9WRxb7s=:BmaKTvzfFNoX4H0oKCBMDf
 efC9VMq0Gkqlzjq9zx+2F0ATFLt6OHGZjacPiUJ8VSLSYf5QbS4yB9NCHHCwLQmOUnPmNZ49M
 rHrLSiKBpGzEL7SYnfitj140sSQ0139gRVfeOXAGSUD9f75xOOtV7nW7k2GokraXFXQ3OYcVR
 mFGJBnJSHZ8Snl1vywSTQ3b30HEvThyBtKIr/CyAex/RZyBLgHjjM/Yt/gxVHJVVUbmYB8Bb5
 0sP9H4km9NW4kAQDLuJblVawuWXKsui1kn/j/ps9sdwNMlUZtNP6iN7deX0JEOCFn3ipJ7+eA
 UVVf1R6p2jcpeHKwTAUw1renRPptVydbmiPGH2RKut2PWv7NdnMcMVBRHNSOZ+5eRsoXTLu2J
 jcH71YIrG6S+4cllcVp0guglx0hRdeZm3tfNtC+KO0vwnqwF7I+fLt+EzKXf8LcSHMkDKE/hA
 7R9Xh9AVHSoL/OLKZrbCskIpAC0u25wG+pYx/n8REn2R6Yb2x1QZdDYgZi4UF92gKwpHhLXeY
 dJqbxYMfSO66lmq4X/99Yvf0BrbZU2sViAnK9fgbOdzmruD7JOBI9lTmQK/I3BfynS8bL7yt6
 Rq/84cO7cEdDtk/r55Rk1LwSnSxf6veMA4wZUPZM6s9ZbhpaEo+psOkBACbHcKyp/wu+kMwJg
 JJY+fAwpcVH4+8/Hp2MQFX/zaYsrQDGmQNFQYsIW+Aam2ZFNRl/6WpFRnPwkAUTODV2h7fDtx
 rdf+Ep9gJn6Rt2XAe6csgemTMeoZzUCGSifkGVzdDZQC40XAstXWICK1U2KyHfwUicQV1Crle
 TtnolXcQ1AHQCKCMNt834lLI7SLGQihGeNS7q92dxqKUX6/cJA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `git commit --fixup` command unwraps wrapped onelines when
constructing the commit message, without wrapping the result.

We need to make sure that `git rebase --autosquash` keeps handling such
cases correctly, in particular since we are about to move the autosquash
handling into the rebase--helper.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3415-rebase-autosquash.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 6d99f624b62..62cb977e4ec 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -316,4 +316,18 @@ test_expect_success 'extra spaces after fixup!' '
 	test $base = $parent
 '
 
+test_expect_success 'wrapped original subject' '
+	if test -d .git/rebase-merge; then git rebase --abort; fi &&
+	base=$(git rev-parse HEAD) &&
+	echo "wrapped subject" >wrapped &&
+	git add wrapped &&
+	test_tick &&
+	git commit --allow-empty -m "$(printf "To\nfixup")" &&
+	test_tick &&
+	git commit --allow-empty -m "fixup! To fixup" &&
+	git rebase -i --autosquash --keep-empty HEAD~2 &&
+	parent=$(git rev-parse HEAD^) &&
+	test $base = $parent
+'
+
 test_done
-- 
2.13.3.windows.1.13.gaf0c2223da0


