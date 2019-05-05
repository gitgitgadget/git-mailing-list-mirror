Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6597E1F45F
	for <e@80x24.org>; Sun,  5 May 2019 16:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfEEQKc (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 12:10:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39684 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfEEQKc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 12:10:32 -0400
Received: by mail-io1-f68.google.com with SMTP id m7so6868842ioa.6
        for <git@vger.kernel.org>; Sun, 05 May 2019 09:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JvnmmZljJLMkhzT80rhsHtBSFmQfcSY+g8AoLQXAyh4=;
        b=mfNdQkzrMG/g9GLZWE95RY0fXElOQm9XltkzG5VQ4NM8fDHnMAgzMfaZmvoBkKOMlK
         eOS5SLiyqxlLCuMpdN4u2AOen5JMfMWrbmtacHkWS00fFLpnWNUgD6i58elfSr62li65
         0Sz0AmvzjAn8tecubz/64IGbbrn24GP2S2gt/NlGG1Ej/xiF81++E/W6z5kACMgHdhH/
         mHV4NMT3vInStyr076BOMOWlgN9nyLL9FGrnGLtpM8ngvZ5Bk1IOUZm0j5WGGaTmFd2X
         g4kTql4HWz+L0iuG+1BRoGYV2ryRrVJvHQR5pje1+UukJWQ4uIDcRcfyGzrd3mJNDg/O
         2Nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JvnmmZljJLMkhzT80rhsHtBSFmQfcSY+g8AoLQXAyh4=;
        b=pCjHHDpCHO7pBzOW+VnD6jJwz8mqRGKMxsWMPKAEI9tmt3ZA1fSOS14hoLGrm81oGE
         FVgwULuBcYdD/tqeh7B28mjMJ3uo+knalUAr+RWX1sAGVlYXFgiUwr1r2VbgNr+dgC9Y
         bdmiY9bBEIfjDAlmIlZsJ9GZmOlki7jg/5BWNpiDSG+yHOwI3nP2RCUxbQz4gEhOm25b
         PDA00ix9z47mC5YdSmkM4mIYkJEpGiZIhvLQKL5OBCdLwlSeRbOs5izsRf1ox3PajYnk
         BrQzuL/vCjgHkQBEkCEM8LkS1g93YbiO8HGkiQuhaWUqK76cSH9sz9ebhob8Is2FTRQ5
         E3/g==
X-Gm-Message-State: APjAAAV+cmkFKraXwcqshof1C8oaMRaCpln+iZrbDWV16/aD8c0gkeqR
        KOdwuCon00C9nvlL+3tUPw4lmOoD
X-Google-Smtp-Source: APXvYqxSDzaXf5qSc5f/6k3bdyU3OVEWaMma1lsCiGIOtjy5Wkt/BYNYKiz5106nTR/KFC2OvgeKhA==
X-Received: by 2002:a6b:e718:: with SMTP id b24mr2034977ioh.213.1557072631283;
        Sun, 05 May 2019 09:10:31 -0700 (PDT)
Received: from archbookpro.localdomain ([199.119.233.193])
        by smtp.gmail.com with ESMTPSA id u13sm576052iof.22.2019.05.05.09.10.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 05 May 2019 09:10:30 -0700 (PDT)
Date:   Sun, 5 May 2019 12:10:27 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/4] cleanup revisions.txt
Message-ID: <20190505161027.GA6683@archbookpro.localdomain>
References: <cover.1557071877.git.liu.denton@gmail.com>
 <cover.1557072286.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1557072286.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, I specified the wrong --in-reply-to. The correct parent message
should be this[1].

[1]: https://public-inbox.org/git/cover.1556367012.git.liu.denton@gmail.com/

On Sun, May 05, 2019 at 12:06:54PM -0400, Denton Liu wrote:
> Thanks again for the comments, Andreas! I've incorporated all of them
> into this reroll.
> 
> ---
> 
> Changes since v2:
> 
> * Marked more optional arguments with []
> * Added Andreas' "revisions.txt: remove ambibuity between <rev>:<path>
>   and :<path>" patch
> 
> Changes since v1:
> 
> * Added patch to fix instances of "rev" to "<rev>"
> * Marked all optional rev arguments with []
> 
> 
> Andreas Heiduk (1):
>   revisions.txt: remove ambibuity between <rev>:<path> and :<path>
> 
> Denton Liu (3):
>   revisions.txt: change "rev" to "<rev>"
>   revisions.txt: mark optional rev arguments with []
>   revisions.txt: mention <rev>~ form
> 
>  Documentation/revisions.txt | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> -- 
> 2.21.0.1049.geb646f7864
> 
