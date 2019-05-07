Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB6B01F45F
	for <e@80x24.org>; Tue,  7 May 2019 14:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfEGO3x (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 10:29:53 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37870 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfEGO3s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 10:29:48 -0400
Received: by mail-it1-f194.google.com with SMTP id r85so26029907itc.2
        for <git@vger.kernel.org>; Tue, 07 May 2019 07:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FI9kuH4j90dpqVT1GHQY/sqC0EXWKRgKypnXP3uXAH8=;
        b=To5HUATJLMGPZjsCFkQRJ3weKfOwBN3G1Pp1fsfFXDTjqtydv9h5zvDTtlQXk/IR95
         5KyZARJrYgY9zqWJirfW5OlMX+7o44fIW9WwquRJeCnNh/9kJNuO5Rz2xNQ/VK44teb9
         pcnI+YZen6OUnTsh6eumHRVO/xPIDb7tCIasC35gfAab9EUhky4pxhSwInryaIZaZbHp
         FX8+fgFBD0VFPzv+tvY30mSPqD055Sie+veHdNutiT9LTNh6uVGhkwprls5SXw0cAZbG
         2SkhE6iXz1racrjwDqCnSS5FzgEaMjVjP1cRCgSsmgtfbZkVpIM4VOaiLPn4JUjwZpI5
         Mbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FI9kuH4j90dpqVT1GHQY/sqC0EXWKRgKypnXP3uXAH8=;
        b=hK4x5L5EB/vy5sCqvuDXlBsY7GnhbVrBf1/l+CnalqYzp+BlCGOWMoA9xnFzGTy6qu
         cXwnhFZ/q3nRWipQoCvKZQ9QKMBb9eGeKRW5vKP3Ht5DxmNp4yCS18OK0Eh8swfL7Fqd
         Ni71q0cCYhpTxqS4EFLpZfnM8CoQ77dkFbYZZyEkBK/d1n9PhAXn4d+VRAALcYdklld9
         ZfPO3CD5SvjoY8cBs6vUuXsFW0R9Tb808R1zBUhtwteVjotGxggt8z9J/40+GXIbuuzS
         +ASNkRW0cprpnwVzkYFhEu0ex8TO0V9XgKPiIRzDpeAtzFLSypTpW6ppX6+PfWLurP1c
         TWSQ==
X-Gm-Message-State: APjAAAWG3P2KdPd/yMjF1zvXDoa9htnH52rT/HHAoFqJVcdXsC8peWhB
        MXpBURgIAh4fHSkU4dORMX2WGs/y
X-Google-Smtp-Source: APXvYqxQLV8nwP/RvnXo4Aso7gQOePYivtrFOqE2rYkNlWjwJ9V5jz/xzffFHP2VbBsDKDJDiEtBJQ==
X-Received: by 2002:a24:8c:: with SMTP id 134mr22983058ita.24.1557239386925;
        Tue, 07 May 2019 07:29:46 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:780:ed13:bfd5:1bea:adb7])
        by smtp.gmail.com with ESMTPSA id b12sm4757863ioq.31.2019.05.07.07.29.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 07:29:45 -0700 (PDT)
Date:   Tue, 7 May 2019 10:29:38 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/4] cleanup revisions.txt
Message-ID: <20190507142938.GA3769@archbookpro.localdomain>
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

Hi Junio,

I noticed that there are both `dl/rev-tilde-doc-clarify` and
`dl/revisions-doc-update` branches. The latter comes from this patchset
and is a complete replacement for the former.

Thanks,

Denton

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
