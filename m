Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F90C1F597
	for <e@80x24.org>; Tue, 24 Jul 2018 21:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388607AbeGXWUK (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 18:20:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39706 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388597AbeGXWUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 18:20:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id g2-v6so3731894pgs.6
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 14:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b9NMkcTpyTjVtKvbUu7FVs+xQ+EgKQmKw/2/OevvWWc=;
        b=ZL66R8vCgkLKsPQgAAuaNipILJ1RkD4GrqMzVj0a/8JOQZMDL5fUnl7xTztSAESwDK
         toeXR5OZ7sinVcxLxES2OQZ+XBurPSDhS1MKttpZDtKubANY/gfr8uziHhWniUXv8w4i
         Q9trtuGQVkGtzWuIwmrS4wicAZB0qQ5BX4Yi9+AXYbwRp1SKYUeEAfnF4MtjUP+mo98l
         /yUsLgsBa2uDpMl9v2TG4chozxzBFsUl27yffa6p4smOjCJ1q1lfZB2cpGrqnIc/AyGS
         PEAiF1ue7xThBDBzHiWyVly9slMYpRpqXKU68CF9yIwJZ7Ne+XDdt1XrrZVConQMG9eE
         L9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b9NMkcTpyTjVtKvbUu7FVs+xQ+EgKQmKw/2/OevvWWc=;
        b=oHodk1tsaU3kIjbtEGN0FRXzdBeh9HaMXL93bTL54UOhUzpyjp548hZESehLB4ZhA/
         BtUUVAh6pd0RhTWGEl8T28CHshg0XHM6VjLEk8fAn34eEDuMDP/XT6jXfXZCpW6YYlgA
         HuTIpK3urqa6JFK0d1IyCSxn/I/KoDiE0qi80K4uR3X0/r9wUvBioF2GzxUGccaTvFHG
         Q3UDh1vc4DA1uH3pKROWehw7Fp/DT2gYufiUNUFQE0fiTdtdYBBDatap9ohgsjHbR5HB
         1AFExIGNSU9iHSOwMXyrkU/I79c2YG2lOfI5mv3LEF9OZnv/qkTYNBqQzGZCp62cQM55
         lTWQ==
X-Gm-Message-State: AOUpUlEwIpegANBOSKgZTNWXmvUN/7x1ERCt7iYLAg3blxU+eexe4UBZ
        yr6GxEMCy11XBUut/aLroQ7Hjn08
X-Google-Smtp-Source: AAOMgpeAmcyTNfdn1j+kL6fF5GRoMUzrAnFwKwclv/yabl07URN22XhZWb1kgJbAq0QjLtqhn/fdGA==
X-Received: by 2002:a62:8b0f:: with SMTP id j15-v6mr19566904pfe.33.1532466708566;
        Tue, 24 Jul 2018 14:11:48 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id e21-v6sm35235133pfl.187.2018.07.24.14.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 14:11:48 -0700 (PDT)
Date:   Tue, 24 Jul 2018 14:11:46 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     frederik@ofb.net
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: de-alphabetizing the documentation
Message-ID: <20180724211146.GB136514@aiede.svl.corp.google.com>
References: <20180706213239.GA867@flurp.local>
 <20180706211828.GC6195@aiede.svl.corp.google.com>
 <20180706232147.GF6343@ofb.net>
 <20180706234715.GA81694@aiede.svl.corp.google.com>
 <20180708010926.GK6343@ofb.net>
 <20180724195217.GA9366@ofb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724195217.GA9366@ofb.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

frederik@ofb.net wrote:

> Next week I should have time to send you a patch with the manual page
> reordered...

Yay!

>               although, unless you have a special 'diff' which can
> detect when text has been moved from one place to another, I'm
> guessing it would take you even longer to check the validity of the
> patch than it would for me to create it.

Fortunately we have "git diff --color-moved".

> However, I'm happy to do this or whatever other small projects you
> would like to delegate as far as improving readability of your
> documentation. I just need to know what is likely to be accepted.

Starting with this one seems fine.  Maybe people on list will have
ideas for followups on top, or maybe you'll have ideas for ways others
can help you, or both. ;-)

Thanks again,
Jonathan
