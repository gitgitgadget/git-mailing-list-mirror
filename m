Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2BE01F744
	for <e@80x24.org>; Thu, 30 Jun 2016 08:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbcF3InA (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 04:43:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:56127 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751703AbcF3Im5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 04:42:57 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M51eM-1bX9xD2tGo-00zG3i; Thu, 30 Jun 2016 10:42:37
 +0200
Date:	Thu, 30 Jun 2016 10:42:37 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/9] Report bugs consistently
In-Reply-To: <xmqqfurv3ejz.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1606301041380.12947@virtualbox>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <8615dc276828a3f99a27ff2eda9909548a7d435e.1467199553.git.johannes.schindelin@gmx.de> <xmqqfurv3ejz.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5D96/83oNjTAND5VpYb8m/KgQ72pL2D5kFTn6j1eFiGQ9sYY4kM
 oXyZ69nXiv/jfKNOuwVH6cmvhvQGWtWShscwaR8kiRP6pWzHIQBckWkbKilSwcUWh4LLaie
 7NY1REzI09I3U+14VKRSgEK13o0Zok2NX2BfkQNypv/hq68LbpG/W/UZnU0tbF5/mqDiOQs
 tplc2IbE+mNbDxrhJIGqw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:6R6t6OqoqGY=:pBYIbmALsgou2VyfEMd7J8
 6R1y7dzNXTUQjcIF5yLR3YH2Ah0P97Bi3aAOACtCdfxvlFYMQUSK7TW/j11Eqpy5UCbr9jlKy
 1l7dnJr0XV06G945roiY2agDAoG1MpYvJkmHLD67+VROvvfsuQBGRpHn9fyu+u7md9hl0XJtC
 0snPcTYmyxkNgccD+MNYW8t5Y9WMr23gv536lhhDji1A6Lwihpie1Xd0V+cgp9PFuzGvdFtKp
 XjcuvNertjpJBl+fFyayYSO6Ny0RrG0QV/eYRNNy9BHCRCSTuxQpxRj5VJkU8W+cwPbmkjj8L
 zCR3x7TKiKMoM45uUWkFz4ZbAAnVLJXUVJijUx+gLD8d/j+BqdX6ow8EAqcRdiALopQuyYRyL
 pzSWNRczTiDnifKDkEAMECHpZe07DqQH14EXf7IQuBf5CoVcVfap5E8ObM+CNgJX0cA3wUx+9
 mOWSWVdEty7H6r8zf20IpR0vOSMr5KsXMoo32CggoZDB78FCy6+JxaxTR93loLnCAXPF8MbIb
 8h9Fd5xBX7DG7cwAKxtmbdYPnl8sG/5y+DvfA3RMpR8M05rcMdWqeQeMDBp6y8z/RdWo2BlHn
 bU2hE/GprH2fRMLkKWmOKDwPHXrWL4u5F8dAWGHH3oop6/Muiw4JRkxocua1Kzr7BEgvumviS
 UshFSe9LYjHc9luDTN1GXQ+ZKtFWGtVkhv9OeI+TrQGHxz0bLWn0nyuYJotjbsJwkFLeu7Y00
 6qSGZeu5g7fEfpy8Tb5CjBdp81a/2sWdzpHeoX5TfTCQ/J6Ty0yTwYuaVo06IgEB5fgj4Hla5
 Vst2lbm
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 29 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > The vast majority of error messages in Git's source code which report a
> > bug use the convention to prefix the message with "BUG:".
> 
> Good thing to do.
> 
> But if we were to review and apply a 200+ line patch, I wonder if we
> want to go one step further to allow us to write
> 
>     BUG("killed-file %s not found", name);
> 
> instead.

If the idea is to make it easier to find, I would wager a guess that
'die("BUG:' would be just as good a search term. Even better, I think,
because 'BUG' would also match comments.

Ciao,
Dscho
