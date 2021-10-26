Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51DFC433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 15:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1CA160F9D
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 15:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbhJZPhq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 11:37:46 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:16922 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231789AbhJZPhp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 11:37:45 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mfOTw-0001ul-7T; Tue, 26 Oct 2021 16:35:20 +0100
Message-ID: <8df2fe20-1198-ad99-34ef-f9fa50a67fa2@iee.email>
Date:   Tue, 26 Oct 2021 16:35:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [Summit topic] Let's have chalk talks (part 1/?)
Content-Language: en-GB
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>
References: <nycvar.QRO.7.76.6.2110220950020.62@tvgsbejvaqbjf.bet>
 <b485b282-2b26-b9ab-da5d-ea59f5fcf463@iee.email>
 <20211025222648.GD2101@szeder.dev>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <20211025222648.GD2101@szeder.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/10/2021 23:26, SZEDER Gábor wrote:
> On Mon, Oct 25, 2021 at 09:56:56PM +0100, Philip Oakley wrote:
>> In the meantime, while chatting to a colleague about the birthday
>> paradox and its relation to Bloom filters, I realised I didn't
>> understand what our Bloom filters were trying to do and what they recorded.
>>
>> I had a look at the code and documentation, but there isn't much there
>> about our Bloom filter implementation. A chalk talk could later be used
>> in the same manner as the packfile discussion to show what the filters do?
>>
>> If there is someone who'd like to talk through what the Bloom filters
>> are doing in Git then I'd be all ears.
> Then perhaps you might find it's worth your while to read through
> this:
>
>   https://public-inbox.org/git/20200529085038.26008-16-szeder.dev@gmail.com/
>
Thanks for the link. It's quite a size of commit message ;-)  Are there
any plans to extract the 'how it works' parts into a Bloom filter doc?

Philip
