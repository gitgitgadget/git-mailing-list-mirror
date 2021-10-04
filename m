Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7715FC433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 11:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 554436136F
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 11:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhJDLm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 07:42:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57589 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhJDLmy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 07:42:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 065DC166363;
        Mon,  4 Oct 2021 07:41:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Js/2puaJ2hyAQmElUiRLBjSfElsbs2omT6VmxqsZrR8=; b=oDSw
        Gxa2U6+0/NclmjrghKsUrP/5Hc0FTZKmeBoWVL19wH2zx1KG2CP/1TgdwxO7/5sM
        b7lFCjCuHfuBEXIWrrXUxZrpKCbxWwsa6qhi6UjjrerXuPBfHd1sbmplU9+cPWbq
        t4ICq0GBjqMySFswkGIJhmRGifQ7TSKOjOHkc+Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F3BAC166362;
        Mon,  4 Oct 2021 07:41:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 64AD7166360;
        Mon,  4 Oct 2021 07:41:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        "Dr . Matthias St . Pierre" <m.st.pierre@ncp-e.com>
Subject: Re: [PATCH v3 2/2] blame: document --color-* options
References: <20211001113725.13354-1-bagasdotme@gmail.com>
        <20211001113725.13354-3-bagasdotme@gmail.com>
        <CAPig+cSWutBRQK+Qy=nkaDZRvy4trVNPuo+cF-quC2rBwNe2fw@mail.gmail.com>
        <e70942cd-8362-b8d0-f168-01f6c190fb0b@gmail.com>
Date:   Mon, 04 Oct 2021 04:41:00 -0700
Message-ID: <xmqqk0itxbjn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3A4046C-2507-11EC-8738-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 02/10/21 02.10, Eric Sunshine wrote:
>>> +       config option. Only the line annotation (see "The Default Format" section)
>>> +       is colored.
>> You can drop the last sentence entirely if you start the blurb like
>> this:
>>      Color line annotations differently, if...
>> 
>>> +--color-by-age::
>>> +       Color lines depending on the age of the line. The `color.blame.highlightRecent`
>>> +       config option controls what color is used for which range of age. Only the
>>> +       line annotation (see "The Default Format" section) is colored.
>> Ditto about dropping the last sentence.
>>      Color line annotations depending upon the age of the line.
>> 
>
> I observed that both --color-lines and --color-by-age only apply to
> default blame format, ...

Technically, it is sufficient to say "color line annotations"
because the default format is the only one that is described to give
"line annotations".  I do not think it would hurt too much to be a
bit more explicit, perhaps like:

    Color line annotations, depending upon the age of the line, in
    the default output format.

I personally feel "(see section X)" is being a bit more ditracting
than being helpful to readers.

Thanks.


