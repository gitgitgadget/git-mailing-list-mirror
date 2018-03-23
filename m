Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E92821F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752118AbeCWRKr (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:10:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:50431 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751691AbeCWRKq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:10:46 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M6jIK-1ecVbU1LMq-00wXjh; Fri, 23
 Mar 2018 18:10:44 +0100
Date:   Fri, 23 Mar 2018 18:10:42 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Wink Saville <wink@saville.com>
cc:     git@vger.kernel.org, sunshine@sunshineco.com
Subject: Re: [RFC PATCH v4] rebase-interactive: Simplify
 pick_on_preserving_merges
In-Reply-To: <c49af83f3ca3d180cbd101d62eccc3b021373d9b.1521779249.git.wink@saville.com>
Message-ID: <nycvar.QRO.7.76.6.1803231810220.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1521779249.git.wink@saville.com> <c49af83f3ca3d180cbd101d62eccc3b021373d9b.1521779249.git.wink@saville.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:BrBBIyL3eGf26JKL7RgFXlmCnC6R/I8zodSYrhQtQjMCJgEv5J7
 XGI9Rld3D9Vt4R2raDPtxcTjv/2n+Vdhl9mPKKecXsx+9uXfdx+iIBzuaeeaM0s8RdmUwiK
 zLkzUpULxIfEX+V6Db7hQnWVz3gZ1993Z631JITygPRxZ2rTHRic9QpXqK+deoJplkFXyVs
 esFXskUG1svjXMVpHStXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:P0vJstGIcHw=:ShHgjEuitkd8grvOtHAVpe
 NfVJ+AO6+duwPrEY3ZksmpigahLoGg8oYdykSkCfDl2fiF/wdtdeEOx7VTU/BZv9DLnUq5OWm
 2z0zceh/olg6IfCtWTcKOlPsh2t6CbFw16k8uhCXAnyYDl6a/kMy3UbdxxuaKSsluDiBFPlHq
 A+j0lJYtYyxbP73Rg/s2s+P0+S3hxlWlJv6BACwXFKYhItzwesb/aaA/7mosglMxBQZASlCVV
 jq0dvY1wBGqmN1rpiwazt1Bpw/uLDNjIFdc/deZqW6W0F2D7IRrMTQ7f3rRB1i5pNeQG+Ud0d
 MoMyUgtbmvz6t+EtYxlRol2Zj9Xz7aV5ftgvaW1yCs+veYXmbyJIJI5iwHjkY7S9DB3G7U1iV
 faMYQzwFjJli0xSkWVt5uuPzYlKjnG2QnYk9hRwx4tPyhmaN9iTHBUGJ6fSxA7YY3LhHXVtD9
 cZYMyrZ3QbTKNRPawbuow+Bzjws9FzFm0nS81/RWgCu7fnU9i20K8ZUGGYvtLO5Ew2DcKGmfU
 ef3lkpAp9Cq0mMV/XiRzivnfMC/oxZbHftBxiVjkdbDSiANnruXoQ3RMWshyLcvXswiXiAKVZ
 IeSQgQBmnhv57bjvhk4AkEnhlAxlG4Lz0w16kZkWGaj9Ct0YUquQS2CAM1CJvyTDOKGqze+SQ
 GF/RR+q7boCELoISfWia5GltbgXtiwsAeTwgD9Dozfn1q7dT6bN00OFhaEWfxt4XChD1BQFmC
 Ytaif+QbztswvKp2L8d4Nw4zr07tgDN4iidPncRqiWuLaxuUi8uItnzf9KxFfYz/C5xLKnkCb
 orGWjL9fzZ96AkLAWxJ21NcbsTVHWEfX2uj6cBvaX5JL/L6GJw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Wink,

On Thu, 22 Mar 2018, Wink Saville wrote:

> Use compound if statement instead of nested if statements to
> simplify pick_on_preserving_merges.
> 
> Signed-off-by: Wink Saville <wink@saville.com>
> Reviewed-by: Junio C Hamano <gister@pobox.com>
> ---
>  git-rebase--interactive.sh | 17 +++++++----------

The patch is obviously correct.

Thanks,
Johannes
