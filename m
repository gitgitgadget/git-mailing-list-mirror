Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBCEA1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 00:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbeHWEZT (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 00:25:19 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:39430 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725727AbeHWEZT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 00:25:19 -0400
Received: by mail-pf1-f175.google.com with SMTP id j8-v6so1793546pff.6
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 17:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n2+K2E3lQatSqBkZeJ2lgx/5KVNaYiPRqPW+y8CLWPE=;
        b=HtdEaT8EnvynmYXLmX8XZppG/7IxdbiO4J2i0MdY74ChnZBfaCzAF1VOZQ2rVoVwbq
         WA2+PZQFK35dSATM7dmzUVB22u+Z5RlgRoLedg/s6QuzytkyjkP3PLBmJxv14Yebuo2p
         D46Znk6zG3sjX6copBWwLYkChV6GBHkw/ZNep5yIJbtY/mJY/zoTrLJ3XAfVM/AUN/CT
         t+Ee5E0sszyrbKChxW7WLhUqZweyJhAh7CDGSkq5S8jHoXyBzP3KNV4TK6iAar6Uthqe
         HcwSqP3CxJV4oHWK4+pjhf456b1xY9kCYYO4mAMTvt3iXkfwCxPFULJq7yZI8GnhQFhk
         NJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n2+K2E3lQatSqBkZeJ2lgx/5KVNaYiPRqPW+y8CLWPE=;
        b=btGkIKnzu/nPgp6WmPWI0J/vvOxNEXE0jOVoNWQU9Eg7vxVbF7kslhTDlY3NfkE0q3
         45wMr1g9OKm4M8PUE+/Wn/KiRHysqvBhz1I/bXYJC86aVgZOOf6r/wLt77FL5piodTDU
         9dFca1+Bqo+GZbsXauu7DoVn01DS1zmnN9PWEXh7SoIMQBF60gm5qkqoGt+GxEelBw8G
         /4tje5MQzV32OaPMRhF7lsCpf0sYulOlzigZgvpguo8diFrIqH/RDkLdc+5gHWfO9e+4
         Izqufd9JrnHMMf28RkQwid1D21vsKE7xaAaiMgSllC7bnuVQXyrItET3jWQrlAo0jGM0
         FAlQ==
X-Gm-Message-State: APzg51CScbhpGSoSxSNn1PgfTHNd/8P0Q1cmBHiE3I+jaDz2/o2Yzw0b
        FdVNpt50FWJ9ojLTIgz87P7epuFO
X-Google-Smtp-Source: ANB0VdYIInJim8+OXLLBVo61laIEBxCKq5vTaz0SRwGk3zGvp8G0T/2sSvcw/csh+plG5RqNN/3p1A==
X-Received: by 2002:a62:ce48:: with SMTP id y69-v6mr14131pfg.91.1534985892144;
        Wed, 22 Aug 2018 17:58:12 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b14-v6sm4346208pfc.178.2018.08.22.17.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 17:58:11 -0700 (PDT)
Date:   Wed, 22 Aug 2018 17:58:10 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Gaux Nation <satingaux@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Contribution for an Open Source Git
Message-ID: <20180823005810.GA92374@aiede.svl.corp.google.com>
References: <CAM5=pr8+x-=9ZYKQSAYp3D5TRmqKf7ui7utgvwsxmf_e5vrGoA@mail.gmail.com>
 <CAM5=pr9LZ_zpmqFJTiOw765sbDkq0AoujzOWK1U_bjstC5FyEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM5=pr9LZ_zpmqFJTiOw765sbDkq0AoujzOWK1U_bjstC5FyEA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Sachin Sharma wrote:

> What do I need from Git?
>
> Guidance, neither too deep nor too short(optimum).
>
> How can I get started for a contribution?
>
> What are the necessary technical skills needed for a contribution to
> Git?

To add to what Stefan wrote:

This is a good question.  There are a wide variety of ways that a
person can improve Git, from the point of view of improving how it
works, adding features, documenting it better, helping users directly,
and so on.  All of these kinds of projects require different skills.

I think that for many, the first barrier to entry is intimidation.
As Stefan staid, don't be intimidated --- we won't bite. ;-)  If you
make an improvement and the project doesn't take it, you still get the
satisfaction to being able to use that improvement.  And the project
is quite open to improvements and after a first false step can help
point you in a good direction to get things done in a maintainable
way.

Another piece of advice is to take advantage of the real-time help you
can get from IRC.  See the IRC channel link in https://git-scm.com/community
for details.  https://kiwiirc.com/nextclient/ might be useful for
getting started with IRC.

Thanks and hope that helps,
Jonathan
