Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 564201F45F
	for <e@80x24.org>; Wed,  8 May 2019 01:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfEHBm2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 21:42:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63478 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfEHBm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 21:42:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3FA766A7FF;
        Tue,  7 May 2019 21:42:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zqWe1ScPGfwJMVztnuiJ6mmRvj8=; b=gM+Bfj
        yK6mmNmaIy/CzkO3+gdtSPUh4y7YMc2PMD/uC2Y5jPSi5oxOBVSCTd3o08fXOpLu
        r3phJF2yoousbj2QA4mAm6lN9dLkiZxZK29T3maNTp5NAJIT7j5G7qhaKoyevr8o
        WsCx3Jot/Upi6cZ3IXWBm4tMP3I5aHc0IQY0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S2BIODmq5fOrlaBewWXUZyazHJog4djr
        lEu/PwWY5mpIWJeEhSl8iY8LoOGbvth5vgUpi6p4/ZtNooigu3J2pBSbhQ9lVguO
        3+TLtrzzKt4OdiPqr1fretfM50Rb1kTMSR2flSnKnB47lAJ/CKDVt3VleFuVvvsT
        8lAJFHD9uXk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 374306A7FE;
        Tue,  7 May 2019 21:42:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 68EEF6A7FB;
        Tue,  7 May 2019 21:42:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Dr. Adam Nielsen" <admin@in-ici.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] make slash rules more readable
References: <20190504101905.7522-1-admin@in-ici.net>
        <xmqqlfzilgrm.fsf@gitster-ct.c.googlers.com>
        <6549e684-ac91-4a66-afa0-73c0e8c658f8@in-ici.net>
Date:   Wed, 08 May 2019 10:42:21 +0900
In-Reply-To: <6549e684-ac91-4a66-afa0-73c0e8c658f8@in-ici.net> (Adam Nielsen's
        message of "Tue, 7 May 2019 12:23:02 +0200")
Message-ID: <xmqqlfzhk9he.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86BEA068-7132-11E9-9ED0-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Dr. Adam Nielsen" <admin@in-ici.net> writes:

> On 07.05.19 12:07, Junio C Hamano wrote:
>> "Dr. Adam Nielsen" <admin@in-ici.net> writes:
>>
>>> gitignore.txt: make slash-rules more readable
>>>
>>> Make all paragraphs valid, even if they are not read
>>> in strict order. Make paragraph better understandable
>>> for pattern without slash. Add paragraph for pattern
>>> with slash. Be precise whenever a trailing slashes
>>> would make a difference. Add some examples.
>>>
>>> Signed-off-by: Dr. Adam Nielsen <admin@in-ici.net>
>>>
>>
>> Have you run "git diff --check" before committing the change?  It
>> seems that many updated lines end in trailing spaces.
>>
>
> Uh, I forgot that. I will send a clean version in a moment.

It's OK; "git am --whitespace=fix" can rescue a gotcha like this.
