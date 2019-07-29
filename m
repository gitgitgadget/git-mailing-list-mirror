Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C469C1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 15:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388227AbfG2Psj (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 11:48:39 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57085 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387495AbfG2Psj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 11:48:39 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 141FA83867;
        Mon, 29 Jul 2019 11:48:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=peMN0sz9GA5B
        0/6uuD781iW4nqM=; b=A3zJVPHqubU2HLIbB4HxrdPLssR1n+UZ+0f3qxMGzghU
        aT14xS8HMHPzfv5gicC1JTnSlEaNPmO1TQWm8jjHi+SSy1PnaezKYo00RU80Sw5z
        dSl6r8HIuDdqivUguL7G/Kxq1U7B3hyfIPcSCxlyPzfCZWvQfdUmGun5Xe83zs8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ZDaQmN
        aeC3JNq5V/rc3kYKX/CuIrqnGkQqVajp2dR0KFSN0VVAqcHUtUxhsYPoNIHVlstF
        xOikiJYni/afjcrHD9gPuVO0SbH0WgxT1hrPDPGszIAMMBfhPpyP30ezah5L/zZn
        ISLGK3AXktbZjULc/buD6TesNFamjG8achdtI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0CE7583866;
        Mon, 29 Jul 2019 11:48:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 359DF83865;
        Mon, 29 Jul 2019 11:48:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Olivier Bornet <olivier.bornet@puck.ch>
Subject: Re: [PATCH] Documentation/git-fsck.txt: include fsck.* config variables
References: <20190729093928.GP20404@szeder.dev>
        <20190729095914.30573-1-szeder.dev@gmail.com>
        <87sgqo6ejk.fsf@evledraar.gmail.com>
Date:   Mon, 29 Jul 2019 08:48:28 -0700
In-Reply-To: <87sgqo6ejk.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 29 Jul 2019 17:33:51 +0200")
Message-ID: <xmqq36iox2nn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5093FF3E-B218-11E9-842F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Jul 29 2019, SZEDER G=C3=A1bor wrote:
>
>> The 'fsck.skipList' and 'fsck.<msg-id>' config variables might be
>> easier to discover when they are documented in 'git fsck's man page.
>>
>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>> ---
>>  Documentation/git-fsck.txt | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
>> index e0eae642c1..d72d15be5b 100644
>> --- a/Documentation/git-fsck.txt
>> +++ b/Documentation/git-fsck.txt
>> @@ -104,6 +104,11 @@ care about this output and want to speed it up fu=
rther.
>>  	progress status even if the standard error stream is not
>>  	directed to a terminal.
>>
>> +CONFIGURATION
>> +-------------
>> +
>> +include::config/fsck.txt[]
>
> Before this include let's add:
>
>     The below documentation is the same as what=E2=80=99s found in
>     git-config(1):

I actually do not think we would want to do that.  I am all for the
kind of 'include' proposed by this patch, and we should strive to
make it easier for us to make sure the duplicated text are in sync.

But that would mean that the readers will have to see the "is the
same as the other one" over and over.  If our documentation set is
consistent, they should not have to.

I think we *must* make such a note in a total opposite case,
i.e. "here are the summary of the most often used options; for full
list, see git-config(1)".

> As I did for a similar change in git-gc in b6a8d09f6d ("gc docs: includ=
e
> the "gc.*" section from "config" in "gc"", 2019-04-07). Sometimes we
> repeat ourselves, it helps the reader to know this isn't some slightly
> different prose than what's in git-config.

So, I think we should revert that part out of b6a8d09f6d, too.
