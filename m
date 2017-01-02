Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5816205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 18:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755838AbdABSz3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 13:55:29 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33837 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755629AbdABSy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 13:54:56 -0500
Received: by mail-lf0-f68.google.com with SMTP id d16so28425529lfb.1
        for <git@vger.kernel.org>; Mon, 02 Jan 2017 10:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b50rARBXybK4UkqrHvUx8yNfpHP2aK6yGzuu06nCBKo=;
        b=NpHVs+D86GT7faC+4dLOTgZc3iG8NdIdPJG7cczMXJ7HNjRPbiZqNoWjj+6YBUj0dJ
         OBsUybtn5ZjFUM6x4RLYxOOesi6aBhmRnNqoi2+eSr8r3Igsc2eG59Bw+kgjdCSERx+3
         W1DSWk7XZAdC0tp4cr9TMThVzryrDmCr2g7TbcE5acaURvOTU6q79SS4OmfGq44iPIYs
         25t89t5U2TxYScWPT+X0uMFkJkER1M8q5wwGmAeP6wSAsDchUlyg7HjJfrp/hLA2zO4p
         B6W1JECWvv1BkkWLeruhtAdMAGtO0PXge+gi0LnBi3PT5kV34d7+0xVsHIYy6v7KsNH7
         N/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b50rARBXybK4UkqrHvUx8yNfpHP2aK6yGzuu06nCBKo=;
        b=KOXK7SQ559ezFJtnmVwP0c+KB/bUYDSxpzLDNs5G6XvbLrPPDiAaMAC9ycIfN3gXyV
         0F3kc2WKOjh1rkerVkFUjwF7ik5rrkzuTSVifXWXHrJwMDIxA8rgwvL1wUopaejzaxAN
         FC0OD7xH5FiYUF0rn5Jc4GMgMfUt8psfbHuLDLXTG9HBaSC7GGTwtlu6Zhpf/iK7ZuJM
         KKPxiQ8PQGEAsHH+hvSdPFxMIVcgX7cARqtfWLcT61OVoz6NBcIvGSUx2MVZIsri/GAq
         GVQaaOk3cj3LY56FB85UCDGh9eB6ut9ahAgij3gO8MGHvhb2TIvKrdPJpa/SCNoocaOk
         eVBA==
X-Gm-Message-State: AIkVDXLYM91Qj5Pufq2PIVC1sa7F9LJYqAS4NbdyKHhV+VBH5pgDzD5FRSaYRbfYGpGw7tfoEs7bGjKgwHi15g==
X-Received: by 10.46.9.21 with SMTP id 21mr21365741ljj.4.1483383294216; Mon,
 02 Jan 2017 10:54:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.79 with HTTP; Mon, 2 Jan 2017 10:54:33 -0800 (PST)
In-Reply-To: <ab92dc60-c623-0f6f-868b-b74b1d6dbd2e@alum.mit.edu>
References: <cover.1483153436.git.mhagger@alum.mit.edu> <20161231064746.6bvis76p5x5ubc2b@sigill.intra.peff.net>
 <xmqqr34n4ii8.fsf@gitster.mtv.corp.google.com> <CA+P7+xqqVFvDKSCTrGVVdpZB_VHwGdZ3gFQzo+RQqCu0FpOsAQ@mail.gmail.com>
 <994A5650F89F4B0080530BF7FD1879FD@PhilipOakley> <CA+P7+xqxSpV4yOjE+Lv0kw19Kq6UAbcN_-7O3U_EeBoT7AOtfw@mail.gmail.com>
 <20170102041947.5jzx6og5fcpv7oso@sigill.intra.peff.net> <ab92dc60-c623-0f6f-868b-b74b1d6dbd2e@alum.mit.edu>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 2 Jan 2017 10:54:33 -0800
Message-ID: <CA+P7+xrL6TCQGs3b0s_z97hHN_FbSzLKgUtd7tDT_uACECm=tw@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] Delete directories left empty after ref deletion
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 2, 2017 at 10:14 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 01/02/2017 05:19 AM, Jeff King wrote:
>> On Sun, Jan 01, 2017 at 12:36:11PM -0800, Jacob Keller wrote:
>>
>>> But how likely is it to end up with differing binaries running on the
>>> exact same repository concurrently? Basically, I am trying to see
>>> whether or not we could accidentally end up causing problems by trying
>>> to race with other git processes that haven't yet been made safe
>>> against race? Is the worst case only that some git operation would
>>> fail and you would have to retry?
>>
>> Yes, I think that is the worst case.
>>
>> A more likely scenario might be something like a server accepting pushes
>> or other ref updates from both JGit and regular git (or maybe libgit2
>> and regular git).
>>
>> IMHO it's not really worth worrying about too much. Certain esoteric
>> setups might have a slightly higher chance of a pretty obscure race
>> condition happening on a very busy repository. I hate to say "eh, ship
>> it, we'll see if anybody complains". But I'd be surprised to get a
>> single report about this.
>
> I agree. I think these races would mostly affect busy hosting sites and
> result in failed updates rather than corruption. And the races can
> already occur whenever the user runs `git pack-refs`. By contrast, the
> failure to delete empty directories is more likely to affect normal users.
>
> That being said, if Junio wants to merge all but the last two patches in
> one release, then merge the last two a release or two later, I have no
> objections.
>
> Michael
>

I only wanted to make sure that the failure mode would not result in
corruption. I believe that both you and Peff have alleviated my fears.

Thanks,
Jake
