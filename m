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
	by dcvr.yhbt.net (Postfix) with ESMTP id 20F3C1F732
	for <e@80x24.org>; Tue,  6 Aug 2019 12:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfHFMTT (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 08:19:19 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37616 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfHFMTT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 08:19:19 -0400
Received: by mail-yw1-f67.google.com with SMTP id u141so30732597ywe.4
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 05:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DNv6VnU2XLaNMct9teB+YcJuJEpw88muEdMVxMQCb6o=;
        b=ScOfN//KIXpMVVebAgSa6mDhveq8Pw6iWkPY36nKZBhuWZVoMtvqZqihFEijZsVnY+
         UiEDhy8brab03uB3C3XQ3nSaDHIWznW3Kgk8dy8sV4B/HSjG42GkwVO4D+socsDPqxMT
         mwH3jI8xRvqRyxqvtjQA7T9e6BhqY+vVKxiN+z0CaVqxvseyxmDsAD3sZPcL8AL+HGwr
         VWG5Iy4vPG1r5OSlsKJ5aWZYSE892sjV7nyGwylJuV0G5ic9HQdEddvp2WZULB4npiw8
         wUcRjxMbaaXV32SDkf1mp+jbhh3JXpiXEfGIblmIhkOq1HwTirerw8nfMV1IaTc+b5e5
         wTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DNv6VnU2XLaNMct9teB+YcJuJEpw88muEdMVxMQCb6o=;
        b=opVmro1oLoiNIub5fy580TtC/xLypbqFuFgEcLYMy+rgX7j6XHKw/BBTw5LYzhUu4X
         hGQpZmk8QS9Ch89PqRwaobH6tWgq11v7t3lU4osi1C7nZOwY6JcKsWwUfy8GFaQb/9Ns
         7LPjpJabDOgRa6czTIM7AtGedlsVmaCMzxhupMiml+M0PocSIfu3cgu9YVD6Aed/iBe/
         adGtT8Q1yP3o4KoV0kI1Cry1CpLQxxhwj6fGREM3hHGaVABaUDiPOJCXCN61UrOugoAp
         tdJaIPur8ZykN4GOz/VXx381Qu/tUVqHJa+ZGTAXJl6eKvTcIh9lbzSA7XxQBQ5XowFu
         e4Qw==
X-Gm-Message-State: APjAAAW03OSaAgqjIa1mLRjGp98SuxGdkL6KKB9Q/hLqcdyPQPRTONT8
        /PeQ7/D01K/XgeEL6g7JlXY=
X-Google-Smtp-Source: APXvYqy3SXSzphFD9sdh78GDgb2Xh84rdxsNXqtAMD5tMdahjbAZSYQo1EWEJc69GsiSr9Crx0mnaw==
X-Received: by 2002:a0d:d043:: with SMTP id s64mr2071743ywd.346.1565093958115;
        Tue, 06 Aug 2019 05:19:18 -0700 (PDT)
Received: from [192.168.1.12] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id r10sm19772484ywh.8.2019.08.06.05.19.16
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 05:19:17 -0700 (PDT)
Subject: Re: RFC - Git Developer Blog
To:     Andrew Ardill <andrew.ardill@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
References: <20190806014935.GA26909@google.com>
 <CAH5451=Qa5BGnoRdvtcmT6mXXK+i8iD7WAkKFfNU4b6J-0bX9g@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e97608ed-1900-e2c0-c20d-e73586c1fdd5@gmail.com>
Date:   Tue, 6 Aug 2019 08:19:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <CAH5451=Qa5BGnoRdvtcmT6mXXK+i8iD7WAkKFfNU4b6J-0bX9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/6/2019 12:52 AM, Andrew Ardill wrote:
> On Tue, 6 Aug 2019 at 11:51, Emily Shaffer <emilyshaffer@google.com> wrote:
> 
>> Are folks interested in writing and reviewing this kind of content?

I am interested in writing and reviewing! Here are some topics I am
interested in writing:

* Updates to the commit-graph feature
* What is a multi-pack-index and what is it for?
* Git at Scale: What makes a repo big, and how to avoid it?
* Advanced Git config settings

Here are some topics I'd be interested in seeing in the wild
(and was considering writing them myself if I didn't see them elsewhere):

* Partial clone: what, why, and how?
* Life cycle of a patch series
* Crafting perfect patches with interactive add and rebase

It would also be helpful to have a post for every major release
highlighting new features and giving users examples of how to use them.
Taylor has been writing these on the GitHub blog [1], but maybe he
would be interested in writing them for this new venue?

[1] https://github.blog/2019-06-07-highlights-from-git-2-22/

> The idea sounds great, and I would be happy to review content - even
> if it's only for readability and spelling!
> 
> In terms of collaborating, I've found the processes over at Git Rev
> News[0] straightforward and sensible, if you're looking for ideas.

I agree that the review process there is helpful, and users contributing
edits via PRs to a feature branch works quite well. I would also suggest
writing a "request for review" on the mailing list before merging any
pull requests.

One goal I think would be important is that this blog is that the posts
come with some amount of blessing from "the Git Dev Community". That is,
they should be service-agnostic and focused on helping _all_ Git users.

That said, I also suggest that the authors can list their professional
affiliation as some minimum amount of credit to their employers. Something
as simple as "Author: Derrick Stolee, Microsoft" would go a long way to
justifying the work it takes to write these on the community blog and not
a company-owned blog.
 
Thanks,
-Stolee
