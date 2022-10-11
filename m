Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5068BC433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 17:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJKRjz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 13:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiJKRjx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 13:39:53 -0400
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410A01120
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 10:39:37 -0700 (PDT)
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
        by wilbur.contactoffice.com (Postfix) with ESMTP id 924362C7C;
        Tue, 11 Oct 2022 19:31:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665509506;
        s=20220911-jt8y; d=wired4ever.net; i=sndanailov@wired4ever.net;
        h=Message-ID:Date:MIME-Version:References:From:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        l=518; bh=WxZzOxZXeTlf57cWr/NCKF0VC6jApvt3llzi8NtsFkg=;
        b=FcW+BNpo6Kok9RAKlUz/XDuwJP9WJIU3cueyTOpMnH8EGOW90N7yNxzlMAr/sOX5
        iWM02jTRkbF1j0w6IL1473ImosY6kj2ETTCAOnLzi3hLeAnBwo6sGtS0kS7YygFJb72
        6wInMv9VBy8rPL12AjfcKq9f3mAZIcJBn1aaTf/ULwsv8bITruy0R+dTvf5lCAdGzIM
        vVTOp4JqfG/bEDctaAJUiNwfDWIyjHK+mNJYtQALHvt+T/bD9lvxvzQh0MWtkvSS0aC
        FRTnXtF6dpseFw325Y670RT5Wtnp9WnXxyKQlIp9Ljm1ccnxREH9h2A0eUex/S7HzXR
        ZwRrOnflHA==
Received: by smtp.mailfence.com with ESMTPSA ; Tue, 11 Oct 2022 19:31:44 +0200 (CEST)
Message-ID: <f384d6b9-fb4c-cf22-ea88-8ab50f319a78@wired4ever.net>
Date:   Tue, 11 Oct 2022 19:31:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2] docs: git-send-email: difference between ssl and tls
 smtp-encryption
To:     Junio C Hamano <gitster@pobox.com>
References: <20221011164927.1516-1-sndanailov@wired4ever.net>
 <xmqqh70auvf3.fsf@gitster.g>
Content-Language: en-US
From:   Sotir Danailov <sndanailov@wired4ever.net>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        aaron@schrab.com, philipoakley@iee.email
In-Reply-To: <xmqqh70auvf3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ContactOffice-Account: com:378009619
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue 11 10 2022 19:22, Junio C Hamano wrote:
> Please always start the description of a thing by explaining what
> the thing is.

Wow I can't believe I missed that...sorry!

> I think the updated text is otherwise good, but it would be better
> to remove "The difference between ... is the following."  The text
> is easier to read without that sentence.

I just wanted to make it clear that this is how Git interprets these values.
But yeah, you're right, it's unnecessary.

I will make a v3 tomorrow.
