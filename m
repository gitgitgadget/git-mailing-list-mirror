Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C3B820986
	for <e@80x24.org>; Tue, 27 Sep 2016 21:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbcI0Vvd (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 17:51:33 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:49250 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752124AbcI0Vvb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 17:51:31 -0400
Received: from PhilipOakley ([92.22.61.72])
        by smtp.talktalk.net with SMTP
        id p0HgbutbfxR4bp0Hgb3u4w; Tue, 27 Sep 2016 22:51:29 +0100
X-Originating-IP: [92.22.61.72]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=7aZpnnQXZO14GhbF6d5nLQ==:117
 a=7aZpnnQXZO14GhbF6d5nLQ==:17 a=8nJEP1OIZ-IA:10 a=pGLkceISAAAA:8
 a=NEAV23lmAAAA:8 a=KXXSyito0JIqXYrVPX0A:9 a=wPNLvfGTeEIA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22 a=Bn2pgwyD2vrAyMmN8A2t:22
Message-ID: <A9427F4400044104B47378E024C7C2A4@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Pranit Bauva" <pranit.bauva@gmail.com>, <git@vger.kernel.org>
References: <010201576bfb6c7d-0b68228f-9503-4dd1-9721-713477fa2596-000000@eu-west-1.amazonses.com> <010201576d63f422-abe45938-0da1-4fc0-b0e7-3e552b59d10a-000000@eu-west-1.amazonses.com>
Subject: Re: [PATCH v2] rev-list-options: clarify the usage of --reverse
Date:   Tue, 27 Sep 2016 22:51:30 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfE8PDsd4j1eojEDBAUvIjPMPPF5Kxd64NyJgSaKBoMO8aELUbIzAuaXBJyWmCjCMPtTEGxArDHKrnJNZz8kPde8ARiWkE38a4kNBmuhBF+lKfVuUJAhx
 3BXcTP4ACtmohQnYlMk2dCo4EoFFdtoWCE4bTK2VlmcxKFTEZEjYy25aiMnA4pjUAidWSVo/pPWgPKTOYpm0MDI/rrbmJWkAPD8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Pranit Bauva" <pranit.bauva@gmail.com>
> Specify even more clearly that --reverse works only with the commits
> which are chosen to be shown so as to eliminate the confusion as to
> whether the first n or the last n commits with be shown when used

hi Pranit,
micro-nit: 'first' and 'last' can be tricky to distinguish for lists (e.g. 
of commits) that can be considered from both ends with equal ease (people 
are so easily confused ;-). In such cases its always worth stating the sort 
order mechanism (within the appropriate sentence). However, in this case the 
clarification is to clearly point elsewhere, so I'm OK with the patch.

> with `-n --reverse`.
>
> Reported-by: Ruediger Meier <sweet_f_a@gmx.de>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> Documentation/rev-list-options.txt | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/rev-list-options.txt 
> b/Documentation/rev-list-options.txt
> index 7e462d3..5da7cf5 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -657,8 +657,9 @@ avoid showing the commits from two parallel 
> development track mixed
> together.
>
> --reverse::
> - Output the commits in reverse order.
> - Cannot be combined with `--walk-reflogs`.
> + Output the commits chosen to be shown (see Commit Limiting
> + section above) in reverse order. Cannot be combined with
> + `--walk-reflogs`.
>
> Object Traversal
> ~~~~~~~~~~~~~~~~
>
> --
> https://github.com/git/git/pull/296
>
--
Philip 

