Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 334B220323
	for <e@80x24.org>; Wed, 22 Mar 2017 21:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751567AbdCVVQK (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 17:16:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58616 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750972AbdCVVQF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 17:16:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6E247FCAD;
        Wed, 22 Mar 2017 17:15:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KQTa54tlFTyJ
        fARCQnqutLQg/go=; b=FQzsD69SiNhyszsdA2Vp3LEZTyWCF7KTRnfgPj4/sZ3D
        RQGXHsXvzG4m8uzTIF8qAPTxRjk3aHye1MYRMBdEzrXcnJyz1zFN+nMLCboMGVqU
        S6qCyuPWxkGyVr8hksDTfm7qoepNHXrBJ+H/bKlPoMNaHPJ1ufMq4wAkyjQWW5U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=N/6/zL
        5ujuNQ1U4KpRWL5cWP9WVRn4dYHl1aooh7HuLIrAp3C/L2Pa5AWl3ANYVJ2OTwRU
        69Q906FOAFaFSt9kr4iRXjcLC6vgK0iHbxCNsQQ8/I75Csb2g8PozfUD5xlwh7/3
        gFvb+0irDNGCgV/fVe4P1fnrkll0WdByRLOCk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF9277FCAC;
        Wed, 22 Mar 2017 17:15:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1500B7FCAB;
        Wed, 22 Mar 2017 17:15:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 10/16] tag: change misleading --list <pattern> documentation
References: <20170321125901.10652-1-avarab@gmail.com>
        <20170321125901.10652-11-avarab@gmail.com>
        <xmqqo9wupixz.fsf@gitster.mtv.corp.google.com>
        <CACBZZX70pb=h3nPKDY-rcM3rjh9SNYUzUhxA3Hu0-Jph8ODxdg@mail.gmail.com>
Date:   Wed, 22 Mar 2017 14:15:09 -0700
In-Reply-To: <CACBZZX70pb=h3nPKDY-rcM3rjh9SNYUzUhxA3Hu0-Jph8ODxdg@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 22 Mar
 2017 20:32:46
        +0100")
Message-ID: <xmqqwpbhhv36.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A19B703E-0F44-11E7-B88A-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Yes, all of this is correct, but not relevant to what I'm describing
> in the commit message, because I'm making a documentation change and
> describing how you *would* expect git to work if you read the
> *documentation*, not if you read the code.

OK.

>>> +-l::
>>> +--list::
>>> +     Activate the list mode. `git tag <pattern>` would try to create=
 a
>>
>> Dont say <pattern> on this line.  It is `git tag <name>`.
>
> Makes sense, but this is something I copied as-is from git-branch.txt,
> which then has the same issue, so v3 will have yet another related
> patch...

I think you'd rather want to make it a single patch to be applied
and merged independently, as a fix to a documentation bug we somehow
noticed that is unrelated to the main theme of what we were working
to perfect ;-)

>> The "-l/-d/-v" options follow the last-one-wins rule, no?  Perhaps
>> also show how this one works in this test (while retitling it)?
>>
>>         git tag -d -v -l
>
> This will fail as tested for in "tag: add more incompatibles mode
> tests". We weren't testing "-d" with "-l", or this combination, I'll
> add both to the tests.

Thanks.
