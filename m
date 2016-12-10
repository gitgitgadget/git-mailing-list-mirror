Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5F351FF7F
	for <e@80x24.org>; Sat, 10 Dec 2016 20:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbcLJUwU (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 15:52:20 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:32314 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752583AbcLJUwT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 15:52:19 -0500
Received: from PhilipOakley ([92.22.22.210])
        by smtp.talktalk.net with SMTP
        id Foczc6KzZgKstFoczcLBak; Sat, 10 Dec 2016 20:52:18 +0000
X-Originating-IP: [92.22.22.210]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=ml+yzTU89BnYyX12/wy+jA==:117
 a=ml+yzTU89BnYyX12/wy+jA==:17 a=8nJEP1OIZ-IA:10 a=pGLkceISAAAA:8
 a=t1KctSBbKY_QnIvKVvoA:9 a=wPNLvfGTeEIA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <34DFA15DE05248069167FE613B66CD70@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Kristoffer Haugsbakk" <kristoffer.haugsbakk@gmail.com>,
        <git@vger.kernel.org>
Cc:     "Kristoffer Haugsbakk" <kristoffer.haugsbakk@gmail.com>
References: <20161209155112.2112-1-kristoffer.haugsbakk@gmail.com> <20161209155112.2112-4-kristoffer.haugsbakk@gmail.com>
Subject: Re: [PATCH 3/4] doc: make the intent of sentence clearer
Date:   Sat, 10 Dec 2016 20:52:18 -0000
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
X-CMAE-Envelope: MS4wfDt6zcDLRzrJNJScq57kY49XMEOT5yKYC7JW9YvKoU4yB2H3sKMOjf1losr5VwnhuMZxXCCCQWuh/8OBmhitc9yUdZirw1ufLqC45vN4eRRp9tstBUpq
 FBxaX2VRAuTABlQCKLcF0jdw2O/836NCfT6vfpRGAFClkgZh4Ij61wmgjyxuI3kWyn1MMoFf1rYOb7jC342yYdtWFYeAq5S9ajmttbWfO9Y/qu96ooW4bS5b
 gWGUH87gCvpRSbNd+5gHog==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Kristoffer Haugsbakk" <kristoffer.haugsbakk@gmail.com>
Sent: Friday, December 09, 2016 3:51 PM
> By adding the word "just", which might have been accidentally omitted.
>
> Adding the word "just" makes it clear that the point is to *not* do an
> octopus merge simply because you *can* do it.  In other words, you
> should have a reason for doing it beyond simply having two (seemingly)
> independent commits that you need to merge into another branch, since
> it's not always the best approach.
>
> The previous sentence made it look more like it was trying to say that
> you shouldn't do an octopus merge *because* you can do an octopus merge.
> Although this interpretation doesn't make sense and the rest of the
> paragraph makes the intended meaning clear, this adjustment should make
> the intent of the sentence more immediately clear to the reader.
>
> Signed-off-by: Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
> ---
> Documentation/gitcore-tutorial.txt | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gitcore-tutorial.txt 
> b/Documentation/gitcore-tutorial.txt
> index 72ed90ca3..72ca9c1ef 100644
> --- a/Documentation/gitcore-tutorial.txt
> +++ b/Documentation/gitcore-tutorial.txt
> @@ -1635,7 +1635,7 @@ $ git show-branch
> ++* [master~2] Pretty-print messages.
> ------------
>
> -Note that you should not do Octopus because you can.  An octopus
> +Note that you should not do Octopus just because you can.  An octopus
> is a valid thing to do and often makes it easier to view the
> commit history if you are merging more than two independent
> changes at the same time.  However, if you have merge conflicts
> -- 
> 2.11.0
>
Looks like a reasonable emphasis to me
--
Philip (UK) 

