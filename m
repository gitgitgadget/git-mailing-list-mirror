Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E9011F404
	for <e@80x24.org>; Mon, 13 Aug 2018 12:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbeHMOri (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:47:38 -0400
Received: from mout.gmx.net ([212.227.17.21]:55595 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728835AbeHMOri (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:47:38 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNf1y-1fnWuV1yXq-007Fz8; Mon, 13
 Aug 2018 14:05:33 +0200
Date:   Mon, 13 Aug 2018 14:05:39 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 2/8] t3206: add color test for range-diff --dual-color
In-Reply-To: <20180810223441.30428-3-sbeller@google.com>
Message-ID: <nycvar.QRO.7.76.6.1808131404370.71@tvgsbejvaqbjf.bet>
References: <20180810223441.30428-1-sbeller@google.com> <20180810223441.30428-3-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:I0o0VS7nmySEil3s1YrFd3nY2BK+rosXXjjbpwxlNNHwf2m3Wuw
 ANA6/iwvgoGnEzUpYYjDBSsalrcYtYq43ul0Rcsu/K+dqbO2A0P37lLY5PihD6OEwmM2ACc
 8EW281k7n3zhsVYxUhJOw3n38jMxgDC36Rm+i1xEbm40cAVeeNi9mz9kvrfPT9mFiwVg0XN
 kozSwcEhrf/Efst94/+6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hOGRWizzRF0=:FfSYTPCfSV9zzjsijZxV8r
 3Z3E7T7j0SebbVKJ5PbTUJns4ni/EyUqGaxd+r9Ia//q9S74LW/JNjTkabZP6rS2K5CfR40b9
 mdVbbgVUkY7/weBPU4bs/cCwpvYVYmnaWuv/YQ5QPM8RVKfkJ0gSuyev9pUtrLqbTwIA4dOaL
 vDcbw28LWSWJtdihC9sJ6neHicAgjk59Ro/l6A4W5r/5KRqHxjkKafT9M8AQ5sPo57518Jk76
 XIDuxvFIbZSVZhsD4ircYp5d23pr8nDPFDXwc0HACei5OtM41RrDrPedn4Qa6IZ7r+zakpbgw
 VV2OqZxJkm48TJGONhWaeuVtKSReXE+XBY4HXopsSXG3Gn/yR3FV37QfvJGeT5viOREPCatQ7
 Vz4NMRD64AAOtPCORFYL8GgGtKDv4GZkmvtKt4hDg9Pai99fX5FoI1jn3T1R+59Z8GVPlMRub
 h6nUEwYcRHSECc/MCBjIyofgBk+REfVifyCrDuPKnbIBZc1jscs89HGWzy/pmDNr8iBmVH1ov
 3JecKSVklFpFpFYbpnZEjZUXJDtcIjdXOiQzDgugtFt/EyfQG5j1PP1ujA4unBpcyTZ+/fkR6
 +PZ1zyyh4ocCXrgmgzYeneImUKoctX1qZ33/QsZ7TYKnCntgJD/P7rs8OhtuL+TBLficCvM+U
 junJ9MXSF6BkL8CjUybzeZuqGnnWa7RUhQ0SO30Y9I/2Z95sn5/zr5n4rLn3+Ufd84Q5/GHX4
 Iz54QhIJmKwqO1rZecUNM3xK2tda6b2pX7DRuHPoSDOfmD2HuKzktYX/zRuRaZEuQdwki8LCV
 RYkPxw2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 10 Aug 2018, Stefan Beller wrote:

> +test_expect_success 'dual-coloring' '
> +	sed -e "s|^:||" >expect <<-\EOF &&
> +	:<YELLOW>1:  a4b3333 = 1:  f686024 s/5/A/<RESET>
> +	:<RED>2:  f51d370 <RESET><YELLOW>!<RESET><GREEN> 2:  4ab067d<RESET><YELLOW> s/4/A/<RESET>
> +	:    <REVERSE><CYAN>@@ -2,6 +2,8 @@<RESET>

That's a neat trick to have an indented here-doc that contains
indentation. I should use this myself.

The rest of the diff looks good, too, thanks!
Dscho

> +	:     <RESET>
> +	:         s/4/A/<RESET>
> +	:     <RESET>
> +	:    <REVERSE><GREEN>+<RESET><BOLD>    Also a silly comment here!<RESET>
> +	:    <REVERSE><GREEN>+<RESET>
> +	:     diff --git a/file b/file<RESET>
> +	:    <RED> --- a/file<RESET>
> +	:    <GREEN> +++ b/file<RESET>
> +	:<RED>3:  0559556 <RESET><YELLOW>!<RESET><GREEN> 3:  b9cb956<RESET><YELLOW> s/11/B/<RESET>
> +	:    <REVERSE><CYAN>@@ -10,7 +10,7 @@<RESET>
> +	:      9<RESET>
> +	:      10<RESET>
> +	:    <RED> -11<RESET>
> +	:    <REVERSE><RED>-<RESET><FAINT;GREEN>+BB<RESET>
> +	:    <REVERSE><GREEN>+<RESET><BOLD;GREEN>+B<RESET>
> +	:      12<RESET>
> +	:      13<RESET>
> +	:      14<RESET>
> +	:<RED>4:  d966c5c <RESET><YELLOW>!<RESET><GREEN> 4:  8add5f1<RESET><YELLOW> s/12/B/<RESET>
> +	:    <REVERSE><CYAN>@@ -8,7 +8,7 @@<RESET>
> +	:    <CYAN> @@<RESET>
> +	:      9<RESET>
> +	:      10<RESET>
> +	:    <REVERSE><RED>-<RESET><FAINT> BB<RESET>
> +	:    <REVERSE><GREEN>+<RESET><BOLD> B<RESET>
> +	:    <RED> -12<RESET>
> +	:    <GREEN> +B<RESET>
> +	:      13<RESET>
> +	EOF
> +	git range-diff changed...changed-message --color --dual-color >actual.raw &&
> +	test_decode_color >actual <actual.raw &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> -- 
> 2.18.0.865.gffc8e1a3cd6-goog
> 
> 
