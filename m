Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CDFC48BDF
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 01:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 079B96134F
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 01:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhFNB36 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 21:29:58 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60626 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbhFNB35 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 21:29:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A671514BF7D;
        Sun, 13 Jun 2021 21:27:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Uke2lLMx2ZM3
        q9ai5gJ2zprOaiWaaA+K5johFrCllwg=; b=WjJEcLlb8ZpjMevB8SfZyyLbSG6K
        4X/nI0EAFJT5OGms8bcCjxbVVeu4K/+AP4gaX/oYmM5c4ReU1rWsrtUmtKosF/AQ
        qtSiCIWxbAnekPyzkA+3dHo8PcMVHPAkHFq6zOEpYCsdBrat/5qNfZ/jZRmoztSw
        QzY+iocZPnufOzA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A13614BF7C;
        Sun, 13 Jun 2021 21:27:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D3F0D14BF7A;
        Sun, 13 Jun 2021 21:27:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 0/2] Avoid gender pronouns
References: <20210611202819.47077-1-felipe.contreras@gmail.com>
        <87k0my1bgp.fsf@evledraar.gmail.com>
Date:   Mon, 14 Jun 2021 10:27:50 +0900
In-Reply-To: <87k0my1bgp.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sun, 13 Jun 2021 09:15:01 +0200")
Message-ID: <xmqq5yyh1bhl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BC80D524-CCAF-11EB-9DB6-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Jun 11 2021, Felipe Contreras wrote:
>
>> The latest solution looking for a problem [1] is to use the actively
>> debated among linguists singular "they" [2].
>>
>> Leaving aside the linguistic intricacies that not all singular "they" =
are
>> equal [3], and the overwhelming sentiment that these kinds of politica=
l
>> discussions don't provide value for this community [4], the "issue" ca=
n
>> be easily solved by simply using different wording.
>>
>>   - The reviewer herself
>>   + The reviewers themselves
>>
>> Problem solved.
>>
>> Cheers.
>>
>> [1] https://lore.kernel.org/git/pull.975.git.1623085069.gitgitgadget@g=
mail.com/
>> [2] https://www.theatlantic.com/culture/archive/2013/01/singular-their=
-affront-good-writing/319329/
>> [3] https://ahdictionary.tumblr.com/post/147597257733/updated-usage-no=
te-they
>> [4] https://lore.kernel.org/git/87wnrooa17.fsf@evledraar.gmail.com/
>>
>> Felipe Contreras (2):
>>   doc: avoid using the gender of other people
>>   comments: avoid using the gender of our users
>
> This looks good to me, especially the reduction in verbosity in hunks
> like:
> =09
> 	- * parameters to the callback, `strbuf_expand()` passes a context poi=
nter,
> 	- * which can be used by the programmer of the callback as she sees fi=
t.
> 	+ * parameters to the callback, `strbuf_expand()` passes a context
> 	+ * pointer with any kind of data.
>
> The comment gives you the same information, but now it takes a shorter
> time to read it.

Looks good to me.  I am tempted to suggest that we should take this
as "fix to the documentation proper".  We can discuss the policy and
guideline separately.
