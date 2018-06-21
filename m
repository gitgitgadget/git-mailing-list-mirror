Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C6FF1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 06:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932411AbeFUGVo (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 02:21:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:54153 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932241AbeFUGVn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 02:21:43 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MJByE-1fT8sj40wU-002nyF; Thu, 21
 Jun 2018 08:21:24 +0200
Date:   Thu, 21 Jun 2018 08:21:33 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Mike Frysinger <vapier@gentoo.org>
cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-stash.txt: document show options
In-Reply-To: <20180621005633.31440-1-vapier@gentoo.org>
Message-ID: <nycvar.QRO.7.76.6.1806210817200.11870@tvgsbejvaqbjf.bet>
References: <20180621005633.31440-1-vapier@gentoo.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jZGdxDvNXwtcdG4DuEhAuiEkLIsHcpy2zsXpOqps/xJOIKyMJ3k
 MRuy/tbkLyOjhJ1G6ovJ2Qs8DvUqdJ/LqljdYGGjIMnC8+SB0DdTwbRhHrhnc+9LoD/kgUR
 uXcPXz1AcnmfdVorVK2MoB/Z3xlQb9D7X+WLGkgreroxaIB3eIG5mqst4SSh1+s6kPFfS5d
 Axc1+yAJFPzr0oFwu4MLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QOFhHHvb0KM=:6PQ3f/E5i5OtK0Ajpf9ubs
 neomwG1v5vWy6f2EYrP9duSyp2qRbOD64k7jpczBl0UQv3BfyKEa0WEQhCJ4jcsu7e7stDauB
 hAdASmx9C/V7iKu5Jc4ePyKLv0E0dC6qxKdi5AaOqrai4FxasrFVEs+WNSX006jNZhbMSIjtb
 KsrHaaOdVnyAZ84LOJA/th5Je5zCrXEzQr8M2kt6chuCmAS2P1w8K9W3pv4aF7uJGP9DipHAC
 2GdCRKv1g3SRtmxnNc7knZMjTms47Pyunu/MgZ4WGFGHHe5B8F3WEHXQhDsYdjLAzHkhzAyRE
 4pMWMgzHSeV2MD8pC0o9TUOWFYvLPGkQQlG146VoPikdYFC+RsdirQfyVmRvgmPchWwtm30nt
 79s7IVRXOffd8MKtkZAWn956EKy5G5/dmMSq6mhrLBNT4PX2eAJ8fXsDHqteXJ2EP8QimTBcG
 ql4E98DkB0w2MY/wNXknFI+nAtnm0/+bymmvabenv1HCpN2SeDBEe5QfBYqFdw0V9S0JzYbZ6
 RjNG5rV50IKmRJS7FjQp++YSZvVDr6WpWNkpvc72k52EZL859p6dMcOWHNhR3WFHHpLyXEcXr
 LCT2OVNbKvrRe3oqqii6jT7G0Jq41VY6HtohfZTr8T6gMNlcRWYcMAqKgvlWx22O4M+AIsV/g
 RrQYbh7p1oXOY2spfQwNWGT4CF/f0H+1MXErVWb1TorCWL+k3fPSZDKdkuzxZEY56p0IJgr1d
 xd58dxBOEHnHkDGPsNND1gnR5JDUHzlBbBiDc/PKL55r5WYO8fSXtmSWjiIX6/ZrXpssWM0Hw
 9EMulQj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mike,

there is a GSoC project going on to make `git stash` a builtin, and I
think that this change makes sense and at the same time needs to be
coordinated with Paul, who is performing that builtin work, so I Cc:ed him
for visibility.

Ciao,
Johannes

On Wed, 20 Jun 2018, Mike Frysinger wrote:

> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
>  Documentation/git-stash.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 7ef8c4791177..76e4ca788102 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -106,7 +106,7 @@ stash@{1}: On master: 9cc0589... Add git-stash
>  The command takes options applicable to the 'git log'
>  command to control what is shown and how. See linkgit:git-log[1].
>  
> -show [<stash>]::
> +show [<options>] [<stash>]::
>  
>  	Show the changes recorded in the stash entry as a diff between the
>  	stashed contents and the commit back when the stash entry was first
> @@ -116,6 +116,9 @@ show [<stash>]::
>  	to view the second most recent entry in patch form).
>  	You can use stash.showStat and/or stash.showPatch config variables
>  	to change the default behavior.
> ++
> +The command takes options applicable to the 'git diff'
> +command to control what is shown and how. See linkgit:git-diff[1].
>  
>  pop [--index] [-q|--quiet] [<stash>]::
>  
> -- 
> 2.17.1
> 
> 
