Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF400C54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A261820724
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgDXRaM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:30:12 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:55951 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbgDXRaM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 13:30:12 -0400
Received: from [92.30.123.115] (helo=[192.168.1.39])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jS29S-0006Fr-FD; Fri, 24 Apr 2020 18:30:10 +0100
Subject: Re: [PATCH v3 1/2] date.c: skip fractional second part of ISO-8601
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
References: <cover.1586856398.git.congdanhqx@gmail.com>
 <cover.1587559135.git.congdanhqx@gmail.com>
 <c6d42785bb762f691b00c48b57c73a1933fadbc3.1587559135.git.congdanhqx@gmail.com>
 <xmqqk127jvrh.fsf@gitster.c.googlers.com> <20200423011812.GA1930@danh.dev>
 <xmqqmu72gfxu.fsf@gitster.c.googlers.com>
 <1861c472-7756-d433-9185-d83c03d72b9b@iee.email>
 <20200424000707.GB1949@danh.dev>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <97fb6f7a-bd6d-6f53-e944-bfc426b81b0d@iee.email>
Date:   Fri, 24 Apr 2020 18:30:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424000707.GB1949@danh.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Danh,
On 24/04/2020 01:07, Danh Doan wrote:
> On 2020-04-23 21:41:49+0100, Philip Oakley <philipoakley@iee.email> wrote:
>> On 23/04/2020 20:28, Junio C Hamano wrote:
>>> Danh Doan <congdanhqx@gmail.com> writes:
>> Would is_hhmmss() and is_yyyymmdd() be more obvious abbreviations for
>> most readers?
>>
>> Now that I type them, they do feel that bit too long... , as naming is
>> hard, maybe stick with the yms and hms, though I do keep wanting to type
>> ytd for the former..
> Not sure if I interpret your opinion correctly,
> Did you mean s/yms/ymd/ and s/ytd/ymd/?
Yes, and then no.
>
> Even that, I couldn't grasp the meaning of the last phase?
To explain the last part. I don't immediately recognise 'ymd' as a
typical abbreviation. A common three letter abbreviation, for me, would
be 'ytd' (year to date).

Taken together (my miss-spelling and alternate abbreviation), it
indicates that I was not tuned-in to the chosen abbreviations.
--
Philip


