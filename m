Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F02CE20A10
	for <e@80x24.org>; Thu, 28 Sep 2017 19:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750891AbdI1TEl (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 15:04:41 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:56172 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbdI1TEk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 15:04:40 -0400
Received: by mail-pf0-f175.google.com with SMTP id r71so1301461pfe.12
        for <git@vger.kernel.org>; Thu, 28 Sep 2017 12:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cF76Wumzj73nPVbTc5iRpGsoiDNHgsisKdnP2Pff3ok=;
        b=JF+StvL6QdZfiMV92ZSyXyugy2gsELmMSpJkQOzP4/2gG9ERymy6uYwkJQ3nARe/6g
         agN3LGdrkedxWTIljRzYREiJJ4lXjgqbU+8ZNnw1JR9+kF1Shy2hgFzkVVtgyeVMMqyF
         tQcsOl+8UeiG4rM5BG7DuiLJRPNxvT+YnNw/QAPfesB4uCg/P8s/uejatogpizZQknby
         TvRnENN+LxQfh7kpLpqryzfUNpHcCLmZKceBh2XfgnfU6qSdMDSZzPNUPzG2vG8idkv1
         56bL/Gig26+OVVojR7yEQ3QGdYO/5dIWn4Rihjt3nUjzx14blV7zmwHFV6ZEwTxtuKB/
         Zi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cF76Wumzj73nPVbTc5iRpGsoiDNHgsisKdnP2Pff3ok=;
        b=ANu+KjRCsnLiG9C8IS5IsSkWOs8Tj784i8Du9VPHperB4AxHzGyB2BhqeDtrFUc2g4
         eztmm79YM5dG7etrB21ZbwzIPuQHp4L4tXfjgrPARqztM/NV1dzZIjz8QZaLhjESYNhS
         KogiZmjKIstnz5ZGOBukJIiXe6l7LjxfPXlh+z8E/YTZTWh9yxaDyGAsEAl3dcCzk1Ux
         ELGhBOxJxj5v5J80REnuelZjVDiQbHVPNjgM9dM8It1w5ahOgw6j/lKYU6092Glfg1cP
         3b+vzFWQsDxfWNBJrYqOKKMkbyTOjm19mRyEV8IqACpPbAYuWeeEBidzsMKg0QiRKe2/
         OQkg==
X-Gm-Message-State: AHPjjUipCZCL+gfXvWCvQHj4id0T60Zrpslw8jKf7dtlRCoq5bbuXOVQ
        /Fd1sXJ3NmerP8gj4lrnQPiocB9F
X-Google-Smtp-Source: AOwi7QB+bxSrW12Qqk0YeI8g8Qv6eiq7WgGSTZShnISaC5GSjs/xgzynJj+xGrSlv65qjJ3yhc8BdA==
X-Received: by 10.98.66.220 with SMTP id h89mr5203126pfd.270.1506625480180;
        Thu, 28 Sep 2017 12:04:40 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:ddb6:7bcc:de8:4755])
        by smtp.gmail.com with ESMTPSA id p124sm4300507pfg.179.2017.09.28.12.04.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Sep 2017 12:04:39 -0700 (PDT)
Date:   Thu, 28 Sep 2017 12:03:04 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org, Andreas Heiduk <asheiduk@gmail.com>
Subject: Re: [PATCH] doc: correct command formatting
Message-ID: <20170928190304.GA174074@aiede.mtv.corp.google.com>
References: <20170928140648.GC9439@dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170928140648.GC9439@dinwoodie.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Dinwoodie wrote:

> Leaving spaces around the `-delimeters for commands means asciidoc fails
> to parse them as the start of a literal string.  Remove an extraneous
> space that is causing a literal to not be formatted as such.
>
> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> ---
>  Documentation/git.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Good catch.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
