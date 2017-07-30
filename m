Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 104C320899
	for <e@80x24.org>; Sun, 30 Jul 2017 14:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754011AbdG3OtW (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 10:49:22 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:31300 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753925AbdG3OtW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 10:49:22 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id bpWyd3YF1iSHabpWydv1JX; Sun, 30 Jul 2017 15:49:20 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=UoATD64B c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=pGLkceISAAAA:8
 a=QIhr-27iAAAA:8 a=VANrzf5gZ-bd6q1UB9EA:9 a=wPNLvfGTeEIA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22 a=cgaYBWEFosGJW4rWv5Lf:22
Message-ID: <8256C530C7DE43D7BC72BFB327DF4726@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Kaartic Sivaraam" <kaarticsivaraam91196@gmail.com>,
        <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <20170730110921.11805-1-kaarticsivaraam91196@gmail.com>
Subject: Re: [PATCH 1/2] doc: fix small issues in SubmittingPatches
Date:   Sun, 30 Jul 2017 15:49:21 +0100
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
X-Antivirus: AVG (VPS 170730-2, 30/07/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfMJKhliXVhi4CRwkNqCDBs++jOk3j49kpHNYEhiZxXLo5eDcOW+0B0WSmKZ2v44aN+VH+cs0zf+4q7sIr4Wjaj5/3LN7GolOe76HFTmLLX20jIkRa0qE
 wy3lG9FFeASZdBLF6RZQ32KaAhsqzkwQ+Wx2XIm8sOH9rWM/mcnlX6Mc9HyKJgJwqTW3wQVJ82GvQBLIgAjjAya6VnCqAfZBzDf9RICCb1n2QmtDhr7+UhIP
 Ko/8H75ijeNN75b+MbMBJw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Kaartic Sivaraam" <kaarticsivaraam91196@gmail.com>

minor nit: It's nice, for these single character changes, to give a clue in 
the commit message as to what to look for.

E.g.

Quote the command, and remove duplicated space character

--
Philip.

> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
> Documentation/SubmittingPatches | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/SubmittingPatches 
> b/Documentation/SubmittingPatches
> index 558d465b6..9d0dab08d 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -293,7 +293,7 @@ then you just add a line saying
>
>         Signed-off-by: Random J Developer <random@developer.example.org>
>
> -This line can be automatically added by Git if you run the git-commit
> +This line can be automatically added by Git if you run the 'git commit'
> command with the -s option.
>
> Notice that you can place your own Signed-off-by: line when
> @@ -366,7 +366,7 @@ suggests to the contributors:
>      spend their time to improve your patch.  Go back to step (2).
>
>  (4) The list forms consensus that the last round of your patch is
> -     good.  Send it to the maintainer and cc the list.
> +     good. Send it to the maintainer and cc the list.
>
>  (5) A topic branch is created with the patch and is merged to 'next',
>      and cooked further and eventually graduates to 'master'.
> -- 
> 2.14.0.rc1.434.g6eded367a
> 

