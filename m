Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41CA21F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbfG2UJV (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:09:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38344 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730188AbfG2UJU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:09:20 -0400
Received: by mail-pl1-f194.google.com with SMTP id az7so27907337plb.5
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S2p1heH3zgT+xOBi4HBnkEqn/TFAsjtWwkZbA9ViN74=;
        b=A+hfn9n7W+Yb9R7NJi65j/rDtRS28x0MX2ApOyN40AA0ugixxkVldkHOBLtqoOpkkR
         wozztSItIXmeL86PkbKc2kogyKrasgD1XYoSSpqyiUdul1uJjsCqaYZnLfS4VPlQj/wq
         c7IZPwkYQa3aDdP5wLGRbUOCIL+hMO516TlOjLEBEceeFmvDA6zYJ/QGxGqCL/LvEoPm
         vt1g1D3/SmUBfTIKMiGTYmZr9tv0futg6k7iAxqUuzMOR5Z1cixfeK2gIoFQObUcfnb3
         B04RHI0cNzQWAIRnuyt/59jp9U3n8Nsgh/QFjEF/KCr5aRmlQKfb/e2VgfQ8LZLWkKQx
         sXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S2p1heH3zgT+xOBi4HBnkEqn/TFAsjtWwkZbA9ViN74=;
        b=pu97slV7nEdwJe2KN6RwEnJPQPDoSwmBIsLY5W5EHlIK/GOYu5G2ybG/RG1NsijYnJ
         6JMv4b8rsm+rRyDNYyD8ugN/9Wk3oPTHkXRIXqzLqKZMHeQmzj2ty/MCTGI6ljrvef3q
         sR5hfDP79HXDUSQFFFj1Zg7MUh3NIYN0jvzjtmGK3zCIwsg/OiYZ1waPnPsgCA+Mp1z2
         EXq43O1agRLECFLLZCJ6QWjkCLoftjs6mT1c2if9DlTtPbW3ReIemEPuR+DdWsEiDs/J
         6hqGyvQU/+zc2Rd/JgLZMCIpG1KuXWXSEfZBWz9Pj6mjc706ofCZjbiOIGdFGCeTzQyE
         93Jw==
X-Gm-Message-State: APjAAAXG1+XNrPmZSo2H7y70Lrvr/oH3dKVsZEug3bffjQabESVImG+M
        V7E/K1SSVqVl8Mlna9WjJIkD1vDEym8Aq1KlYtg=
X-Google-Smtp-Source: APXvYqyu/N6Nqrmls/SlWZT1YcUX8GUNiha0978QUtUIi4XpxHPm8pTOQ8Bftyk+0DZr8SkTO2NfkpuRGmv/rqLKYAg=
X-Received: by 2002:a17:902:758d:: with SMTP id j13mr109945945pll.197.1564430959977;
 Mon, 29 Jul 2019 13:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqbml6pgfm.fsf@gitster.mtv.corp.google.com> <cover.1563490164.git.steadmon@google.com>
In-Reply-To: <cover.1563490164.git.steadmon@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 29 Jul 2019 22:09:07 +0200
Message-ID: <CAN0heSppzb9MCcR2296y1FFBoYyOs16e73DFhgV1bjkkxemRww@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] pre-merge hook
To:     Josh Steadmon <steadmon@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>, stefanbeller@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 19 Jul 2019 at 01:56, Josh Steadmon <steadmon@google.com> wrote:
> * Martin's objection on 1/4 that the sample hook would always exit
>   successfully is (I believe) incorrect. To test this, I ran
>   "/bin/true && exec test 0 == 1" in a /bin/sh subshell, and it
>   correctly had a non-zero exit status.

I retract my comment on this. It was incorrect, indeed.

>   git-merge: Honor pre-merge hook

Nit: s/H/h/

>   merge: do no-verify like commit

Nit (maybe just me): this could be patch 1/N, before getting started
with the real focus of this series.


Martin
