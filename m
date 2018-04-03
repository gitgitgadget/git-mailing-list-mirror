Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FA201F404
	for <e@80x24.org>; Tue,  3 Apr 2018 16:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752315AbeDCQ2S (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 12:28:18 -0400
Received: from mout.gmx.net ([212.227.15.15]:33163 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751461AbeDCQ2R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 12:28:17 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MCcja-1fBc044BGs-009NXG; Tue, 03 Apr 2018 18:28:07 +0200
Date:   Tue, 3 Apr 2018 18:28:06 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 02/15] t1300: rename it to reflect that `repo-config` was
 deprecated
In-Reply-To: <cover.1522772789.git.johannes.schindelin@gmx.de>
Message-ID: <083953bc0d5c7f497722a1b42b0e0be884fd1a4c.1522772789.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <cover.1522772789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:8BsewF8WU4CoST5TVci+DzkCLTGCmM1s34M35HyAtsPSCXCW7s2
 FgszieDVCPbgoRHk6cU4vlDoiHIHZN1snGTWDO16Ld/9Svvc0gN6HW1RpYO/SMCcQ5yM0BR
 LzfUP2V7RG0RTzyIAPE8HXEuYQO9wz6pSkLXS8ETUDtCLRnI+fPi2N31VpMgtAjPgSMXDbv
 pAaxDO9MVyRszFAeaQwIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tog7jHT2ijA=:M/GfPdzLR0RPsZ4xB6YBJj
 bYHCFealbIejTTquemHYBgBHdHQPnwGkEotQbDBQWxj8Jv5XHYhLMWSd4q5P/fHhMdcAKuvkB
 WiocPQSWi2HI4POMOQ+ngMU27t+XupBOIfN2vzZ//fOihjsiyAC1lKkxGG+1AttIgXuIy+eDx
 2RdMehWOxj+R+El0I6q0sQkgBVVPmmAO5VkznDgyfpzKYJxzCL2Sw/vOeH9eQjJPdzzYhPz63
 TXGLBGgIZVqfCFWoyZS4tBIsOXl8SLdn/5IIjfLqzXSKMZSywOPCSl8E6xoEgguqPHPNkQm51
 btccmxN7/CokSFUottCPHwQU92CUWwRzGtMWAS5UFhVkJ/cuRXwXLc2ca+d/BCtg+potAMSnF
 rLhAcaNH6c/lKZUxNxujlW7LDs1RMw8PsF6407aC9gXoA3gv4ZUoTGhPlB/oiZcqxO5LT2Wji
 Y5MoM9ftXGa1+nIU0R72BkIGFwq8alfQ+7+tAZZessubOwEeFJKRkwDY/kORFocRxvXn6cjbB
 SRzs7N5VmIqF5BEUA0H9ekIZLCIdAXKRpJCStYAdF7cDS0BBRquPwNu+XpctmJZErTpKW2aAa
 pgfzG1bYy53lA1OopJz+cb4m9aVV8qZcIccMdsknaCbhuKD0OvujaapZP715OeD9H9r3ibgAS
 aq2THSHrxx8BCNQTFsdKxrIMW9ZYyN2jj98qntfUJE2CQ7p3kO9+whZiT2rtF3I35hDXb36kS
 7NPNtPJm+vHDMLaz8irJ2ZCqkbhhdsYUFVV5KM7uyLKdJ0Vc1z+ZdLZ0RB/N6VELpjqz12yhz
 QWbd7OhV5BvNyxZi3VW8Hmf6SdY/XwFi1rqkK4mDn/4fC98NLQr5mnMm5V1R5U+HNUxD+fx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/{t1300-repo-config.sh => t1300-config.sh} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename t/{t1300-repo-config.sh => t1300-config.sh} (100%)

diff --git a/t/t1300-repo-config.sh b/t/t1300-config.sh
similarity index 100%
rename from t/t1300-repo-config.sh
rename to t/t1300-config.sh
-- 
2.16.2.windows.1.26.g2cc3565eb4b


