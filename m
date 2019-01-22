Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 482C11F453
	for <e@80x24.org>; Tue, 22 Jan 2019 15:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfAVPYp (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 10:24:45 -0500
Received: from mout.gmx.net ([212.227.17.20]:33177 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728318AbfAVPYo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 10:24:44 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LyR1G-1hFGWt2TAc-015oRv; Tue, 22
 Jan 2019 16:24:41 +0100
Date:   Tue, 22 Jan 2019 16:24:26 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Sven van Haastregt <svenvh@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-submodule.sh: shorten submodule SHA-1s using
 rev-parse
In-Reply-To: <20190120204653.3224-1-svenvh@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901221623370.41@tvgsbejvaqbjf.bet>
References: <20190120204653.3224-1-svenvh@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hMEbHI09HcobnoOYZwEB4Io6hsUigIAH5y1JMH350lwcxQCYnxu
 8bpet/TF7JMGFnum9C7TgtQ5w2mhFf16L3SlPKQns4epVG0YvqaRkiuxSRvMvQp+WBw46Ln
 7FXn9S+h0HKNAPiATVFocgNlzIGuRE0jgleVAcgMRTHp0emR8m8mDWu+W3mB0TfbSlVhuqR
 wSy61ULU0/G/qG3NFzdYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1y0hnmMs3BE=:Gg2rr+dl0L6iZdxR2xxGQT
 qU+FdSyVNdrUeQeMBPwLDeoY+qBUscxUn9WoCOaJ3/21JkikQmF9z3/+VIM5gI6u1keTPImrX
 sLfiM+fs01q3VrHib47JhOzWXTZ0X6XvHUDdNBP/hQRVaTGg1kOqPaeNWY5T+G0OLAQPcpo/d
 zAT1ETczTH0P839a61cqK94NlFOzT2gMZINsoHqkgrnGKfWUk5egkCHDQvN+JAGOMJOeB2lcQ
 zixCTr62Q96I7HVj5utRPxmV0Y8Xtrg3HFY8nU5nuf9tv0JEG/aF4f0EBctpkJ1KygA0axlB5
 C9eB09+0mUnrHa1A2iW1IkQwX6REcbQ0uexUh2kiRDjuL7ZEyJngObLcpOf4zEaelTkQjFmIv
 LLuDx8vNCMstL6BczbnjuzvsRzINEtee23ugW5dLevRMmpDbzoQwbVkzsAQhKW3sPH0amgmJV
 AMY7FfPVKD3Ef69UyHiKMP4kq7RZ0JP7UllKZ8PBWFez5YAkCtCa9yrVUvnM/rnCKtcwAEdkD
 8JSk8AnZfhvsCO+u43qp1+q36WuuWzym5q3KLLDhUbx8BA0QVTXuh66RviFF23gh/T/EuzExw
 07+y+GrFZW3jn9ai3wAJ6gj9Jy3BLXB/2Driuxep6hi76FKemLNBv0Vxq0W6/21826gCdqwyM
 ix2ZPMyeCAcV08rX4BkFuprEDRVhlh5eGssXXeKkv56Md7MYNkBemGbe2vqs6YPJ+7uCq4Pna
 797Im35qeC+q4Zmej2XxjO8vCFJ7iIfLJzg46wHSL7RiOX9IjPBmc0T9/eCcMhqHxyG/Thain
 lmeBRMBHbCEk8LydD2tT408td0qBONY+ATdgxkqQ68xsdAY9LaTjJB8AtZ7X81hCjxz8aO4fT
 xsH/hYXt12/aVnUdETsQ0PO4aeUswNRjcNYDGhXE584n1eAqG50sA8mLRTAourljOdIQJJg7U
 4m01zcQoRAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sven,

On Sun, 20 Jan 2019, Sven van Haastregt wrote:

> Until now, `git submodule summary` was always emitting 7-character
> SHA-1s that have a higher chance of being ambiguous for larger
> repositories.  Use `git rev-parse --short` instead, which will
> determine suitable short SHA-1 lengths.

Good point. Just one suggestion:

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 5e608f8bad..a422b0728d 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -850,8 +850,8 @@ cmd_summary() {
>  			;;
>  		esac
>  
> -		sha1_abbr_src=$(echo $sha1_src | cut -c1-7)
> -		sha1_abbr_dst=$(echo $sha1_dst | cut -c1-7)
> +		sha1_abbr_src=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_src)

How about `git -C "$name" rev-parse --short`? That would less likely run
over 80 columns/line, either.

Ciao,
Johannes

> +		sha1_abbr_dst=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_dst)
>  		if test $status = T
>  		then
>  			blob="$(gettext "blob")"
> -- 
> 2.20.1.dirty
> 
> 
