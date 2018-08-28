Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8BDA1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 19:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeH1XEp (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 19:04:45 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:44631 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1XEp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 19:04:45 -0400
Received: by mail-pg1-f178.google.com with SMTP id r1-v6so1159804pgp.11
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 12:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KG1EXHxjZCBZH6OPSqw3gHh8WmdJQFN5l624aWdau8E=;
        b=foOjx48WfC/nQG4+4bAsvGCDA7Ht7oV1Y5a5zPrhliIpdYITJioaePsZ1xfcB2WBXZ
         mPSzX/p0NxLk662yiZ+UBXy7jk//kUfUt55hmdSNNqcB9u3kc3c8nmrYrymTIQUgUMX4
         f+W2QU2bw8VR9CvToD2/4o8IXEzeFT561VQoJnedDa6wfm+Lag51lcJ+t3bGRAesIGal
         FIdXikjxC29pHPULbU/W8RodGHPGN8ZbHVxJUV7km7lR9mby8IteJFhjyTh8H8bbbMSd
         mSzhIuQt5DWiD/Y7QeJWZYGh7SycOZiCW23eAw/JEVZ6DXD+LqaV1vEoXjWmltu+cllj
         6eFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KG1EXHxjZCBZH6OPSqw3gHh8WmdJQFN5l624aWdau8E=;
        b=f6QcHmr2zfVmT4CnGXZw6YlnQUy1yoBv+h22Lvs4UlQseYTaZzCAeFZkwtMY2O9WAr
         4wUQIuCQIVenMCkz9zN3rWDrPDPp9XT01sUGnE8nCi5p/Qw2IaV6WUTjiilTsBwvqGvM
         +0AaUEU75jRLqctK07ol4W9fqOJ8qSbpP0JDj8HLwbOINqf4ijz08aWTJMSdCfCJDPRn
         xN7OjFBe+9SI5+HJxbB2AcBCTexZ36cvJNiqru2Y9AOa2QMYEr5YIe3VGgtG3bviAC3w
         IPwZQw/eLLuWucRHyMQ0clnsWvZCc6dcX9ViCu075/ZCfIYpzMDjRC3aZqmc6+FcVlVl
         QOFw==
X-Gm-Message-State: APzg51CqqjEta/jApj+cIKb7trFxpQO0ct9ubMuv8u+HUSNXRf7lskQj
        Q1j+JTkl44Yd2MFZJThhEKA=
X-Google-Smtp-Source: ANB0VdYIdegdvucZsY/P+eulapJkpkjJi1fBKDP7RZrki/ma+e/WIFgjtvkRabYnd+A9stZRa3qWAQ==
X-Received: by 2002:a65:6499:: with SMTP id e25-v6mr2621625pgv.224.1535483503267;
        Tue, 28 Aug 2018 12:11:43 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id u9-v6sm3444421pfi.104.2018.08.28.12.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 12:11:42 -0700 (PDT)
Date:   Tue, 28 Aug 2018 12:11:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Contributor Summit planning
Message-ID: <20180828191140.GB46388@aiede.svl.corp.google.com>
References: <20180813163108.GA6731@sigill.intra.peff.net>
 <d5d3fe71-d52b-ac9b-d48d-d288b6569e5a@gmail.com>
 <20180813171535.GA8476@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1808271458450.73@tvgsbejvaqbjf.bet>
 <4f0e85ed-6402-65b2-442e-67a1a7a7486d@gmail.com>
 <20180828190608.GA46388@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828190608.GA46388@aiede.svl.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:

> The current IRC experience might be a bit unrepresentative, due to
> https://freenode.net/news/spam-shake:

https://freenode.net/news/spambot-attack may be a better link.

Thanks,
Jonathan
