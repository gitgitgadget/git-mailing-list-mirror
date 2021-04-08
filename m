Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA75C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DACE161159
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhDHWyj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 18:54:39 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50586 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhDHWyi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 18:54:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3CBFF1301BB;
        Thu,  8 Apr 2021 18:54:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5vRJpWdx6dXT
        kqpZmZZcJmo4vC8=; b=qHP+TNetR8YoIB1qzSXbqixzq431qM64C9kczStFzgVM
        bjgBSXsRHtlaq1K3Xf3dMuXD8cesDTtj6ekLRWZZJcnlgnQCOFfMOjdB7M2VMW1T
        ZXNTAoQ2RYGST/g9ENgkjKo8QNhsE9I/GReD/1Tk1Xoko3TYmLkKmp9cx/vK9Gk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fFcyZs
        +oZR8UMckdfr7Rqojs7k4HX+fT8GaMal0CLeWmMerQg6MvyZySmOWcVlII3BGcpt
        jyScHl+0jZmNX6YJExpGsi2OsP5kDWx4Y1AHeDW1v2e0dtj0q5HSCbm+25RpWjQY
        Jyr8zzJAk1a/74AjPlsy58Gwdn+MRxfSLmbLA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3679A1301BA;
        Thu,  8 Apr 2021 18:54:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7E7781301B9;
        Thu,  8 Apr 2021 18:54:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Wong <e@80x24.org>,
        Georgios Kontaxis <geko1702+commits@99rst.org>,
        Georgios Kontaxis via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v5] gitweb: redacted e-mail addresses feature.
References: <pull.910.v4.git.1616396267010.gitgitgadget@gmail.com>
        <pull.910.v5.git.1616817387441.gitgitgadget@gmail.com>
        <20210329014744.GA2813@dcvr>
        <8330ef0d7195de461f961d72f90998fa.squirrel@mail.kodaksys.org>
        <20210408171648.GA7133@dcvr> <xmqqmtu8sd2a.fsf@gitster.g>
        <20210408211904.GA16486@dcvr> <87blaoieef.fsf@evledraar.gmail.com>
Date:   Thu, 08 Apr 2021 15:54:21 -0700
In-Reply-To: <87blaoieef.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 09 Apr 2021 00:45:44 +0200")
Message-ID: <xmqq7dlcqteq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5CA24B72-98BD-11EB-BD05-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Apr 08 2021, Eric Wong wrote:
>
>> Junio C Hamano <gitster@pobox.com> wrote:
>>> Eric Wong <e@80x24.org> writes:
>>> > As a data point, none of the homograph@ candidates I posted here
>>> > on Mar 29 have attracted any attempts on my mail server.
>>>=20
>>> That is an interesting observation.  All homograph@ non-addresses,
>>> if a human corrected the funnies in their spelling, would have hit
>>> whoever handles @80x24.org mailboxes.
>>>=20
>>> I take it to mean that as a future direction, replacing <redacted>
>>> with the obfuscated-but-readable-by-humans homographs is a likely
>>> improvement that would help human users while still inconveniencing
>>> the crawlers.  It may however need some provision to prevent casual
>>> end-users from cutting-and-pasting these homographs, as you said in
>>> your original mention of the homograph approach.
>>
>> Yes, exactly.
>>
>>> But other than that, does the patch look reasonable?
>>
>> I only took a cursory glance at it, but v6 seemed fine.
>
> Ditto, I left a small nit comment about a needless /i in a regex, but I
> don't think that needs a re-roll.

Thanks, both.

Will tweak the /i out, and re-queue with acked-by from you two.
