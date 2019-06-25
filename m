Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 921BF1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 20:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfFYUHI (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 16:07:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61670 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfFYUHI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 16:07:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 650E0165576;
        Tue, 25 Jun 2019 16:07:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nmM8WdIKVG6b
        CGNC45PfOZ80Z+g=; b=b/yQ4674jvWwdZyvxWrgeGN7A2iQ472dSl2VhvCyn+ug
        3oYkXyd9lFWXYJNWjBUQr6VOCBks9SMtvwDOAJL5saP/Gs/8XXd55yfmeJ8iadGk
        3QatqnxCJvMPX6DuzyB2i6WEr2zQS4tAK5PYNNGe8uvB9J+7kEOKR7u1ZrGIiro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QHwcqp
        ncf/H2hn9d27VH0EKpU+7ktIIZ6tS8Z72Vs2V1F3npEV32OvrKtL/4tUMxs/5Iq3
        B4hDWkAi2JUxtwwjs2xTEh6hup2/OyuEi7bmV/rFyTW3PVNapt8hK3ChVRFvAN+g
        ByjMC1vx9WDT+whbNDKJmAaO27leFMIrzrUg8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D1CD165575;
        Tue, 25 Jun 2019 16:07:06 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AA44E165574;
        Tue, 25 Jun 2019 16:07:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Catalin Criste <cris_linu_w@yahoo.com>,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] doc: fix form -> from typo
References: <0102016b8d597569-c1f6cfdc-cb45-4428-8737-cb1bc30655d8-000000@eu-west-1.amazonses.com>
        <CAN0heSraZh+j04qjeaVtS5bsNoE=Hf_FBU-kfcB+69BkZz+zHg@mail.gmail.com>
Date:   Tue, 25 Jun 2019 13:07:04 -0700
In-Reply-To: <CAN0heSraZh+j04qjeaVtS5bsNoE=Hf_FBU-kfcB+69BkZz+zHg@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Tue, 25 Jun 2019 11:41:00
 +0200")
Message-ID: <xmqqv9wte8ev.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CDE1E4C8-9784-11E9-AB04-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Hi Catalin
>
> Welcome to the list!
>
> On Tue, 25 Jun 2019 at 09:43, Catalin Criste <cris_linu_w@yahoo.com> wr=
ote:
>
>> @@ -88,7 +88,7 @@ save [-p|--patch] [-k|--[no-]keep-index] [-u|--inclu=
de-untracked] [-a|--all] [-q
>>
>>         This option is deprecated in favour of 'git stash push'.  It
>>         differs from "stash push" in that it cannot take pathspecs,
>> -       and any non-option arguments form the message.
>> +       and any non-option arguments from the message.
>
> I think this is actually intended as "form". It took me a couple of
> readings, but what this paragraph wants to say is that any non-option
> arguments will be used to form (construct) the message.
>
> Do you have any suggestions as to how this could be made clearer?
> There are at least two of us that have stumbled on this. :-)

"become"?
