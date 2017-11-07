Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BF6F202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 12:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934024AbdKGMbo (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 07:31:44 -0500
Received: from mout.gmx.net ([212.227.15.15]:51369 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751859AbdKGMbm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 07:31:42 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M4GRv-1f33073Pxj-00rnxR; Tue, 07
 Nov 2017 13:31:36 +0100
Date:   Tue, 7 Nov 2017 13:30:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Teach "diff" to ignore only CR at EOL
In-Reply-To: <20171107064011.18399-1-gitster@pobox.com>
Message-ID: <alpine.DEB.2.21.1.1711071329280.6482@virtualbox>
References: <xmqqshe7j0af.fsf@gitster.mtv.corp.google.com> <20171107064011.18399-1-gitster@pobox.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:M8j8IhIgzq4KG7r0IhDJDVki0sk9dV5W2Ak2GE8oqI91EGB7SYR
 htXU1qPBAuw/o31wtHXGMrYDU75DhiLz5ycNWy2vtZZoy7CtGBZ+CEbft73Mnn1b6g8MEma
 4gfLTCj60Ale1qKUFm65oNqqhuwY3BryF7OLN46MOhE3xAHU+ca2jUssucvRT1li4UJ1ZRw
 MtTcXxEysA7giW+IZPuTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Gg9tisphFD8=:G1+7aZ/e9JIF8P+mwLIZFp
 fpv/gQwUGrGCwbuEhA/54y4b9mLmSzutP4nLJzMt657l5K3tCOn7MbgeyW+UIEIJoeGnrYyxI
 zTYQ0rvuM4G9/gGB8vgK9t0135gEsUnUZeZCkSqdJ7CaFoiVj9Mn07oFvxBfLV5oaI1kUZmq5
 F9VoqvkPkrJg+hVSFTykn4uJUFKGZosuYU87/kISyzSo3TGPson5e5G15qHqX6bK1HCbsw/KE
 Lst7JR1BD+LnQoFw96x4jrxKvBSHGU/kSkoCZ4+MZ0gPHdcx4VgbBCMY6LXM8TQtJT4cU/nEK
 FpYBCFXnQA80aLV0R4iUNLgFP/n1I5avXSFRnBXtXdNZ+EkmIIsCI/qIzrf/V/leizqK/Cj+Y
 viWu9UZeeyDWAcmBjp61euyD86g8I1tnX631lpfxOYLtnLBMchafsUGmtXHfe2dgi/TOsiNiK
 KGoqyLvLSF2D/Teg6Sg+AFpuodcQ07Kubz1gDl6UMcEqW1i5LG1deR/pXyoijSTIkgxPW6+wN
 ajwPaXjl3asc/H+bTtibFVsMUI9U/0vJhXuUH79SNfFXiXF2YHVFULeCIYThUrYpAToOlO7cY
 zNwHB6b/47LwFrcrpNU+jaWGBLwAB7kTK+lyZy9QxFJSLfE3Tl4QLv33MeYZev6Z26+uxB/yN
 jTOIvZKedj7iZKGbrrPv7B3JB5FPlbInGf/VqaAnW+LfFoikK186SDYnncizC5sjwXsr7Ss4s
 LRKceY1QdyA4Xvtj32f8Rd0yZjgp819D6FO9K3/E4HeRHZQonJ+96UOcGmQ/65lLHTYheHR/u
 xFvMObmgKO2SnAGLHO2CdFDeUx8tDTMt2n/kQn5wcdQxFM8r04=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 7 Nov 2017, Junio C Hamano wrote:

> This time with doc updates and tests.  The previous one is at 
> 
> https://public-inbox.org/git/xmqqshe7j0af.fsf@gitster.mtv.corp.google.com
> 
> A change that is supposed to only change the end-of-line convention
> between LF <-> CRLF and nothing else can be verified with "diff -b"
> or "diff --ignore-space-at-eol" in practice, but these hide changes
> in whitespaces other than the carriage return at the end of the lines.

Good. I was wishing for such a feature in the past.

However, the short and sweet `-b` or `-w` switches are really, really
nice. `--ignore-cr-at-eol` is just very cumbersome to type out. So I think
you will want to add this patch to your patch series:

-- snipsnap --
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0e16f017a41..b7a45e8df29 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1400,7 +1400,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--patch-with-stat --name-only --name-status --color
 			--no-color --color-words --no-renames --check
 			--full-index --binary --abbrev --diff-filter=
-			--find-copies-harder
+			--find-copies-harder --ignore-cr-at-eol
 			--text --ignore-space-at-eol --ignore-space-change
 			--ignore-all-space --ignore-blank-lines --exit-code
 			--quiet --ext-diff --no-ext-diff
