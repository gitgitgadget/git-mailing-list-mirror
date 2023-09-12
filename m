Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBE6EE3F0C
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 19:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbjILTZQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 15:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjILTZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 15:25:16 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E6D18D
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 12:25:12 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D25733608;
        Tue, 12 Sep 2023 15:25:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mIJJWMjpbLq5
        e5SGspYeegH4jkB6adLHoGxfFSYHKMo=; b=j1filt/v72Bl+3WcOT1P6hbWgvPf
        ELzJKy9q1KwANB6vxVruQlKnKkjEdlVG3TZTjEGz84XH3ITYJ2SSEbetZhzIN3OJ
        /y1K1KdXP5aob8kzT45XBNpke0bc6mDNfWbD8+a6QfnEXjB8aGBWPZ+ps/8bJcFA
        y0H2kfvQZNiWQrg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6652833607;
        Tue, 12 Sep 2023 15:25:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C85B633606;
        Tue, 12 Sep 2023 15:25:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2023, #04; Tue, 12)
In-Reply-To: <2579735c-d0cd-d159-8cdb-3348c808b9ef@gmail.com> (Philippe
        Blain's message of "Tue, 12 Sep 2023 13:32:17 -0400")
References: <xmqqpm2npbwy.fsf@gitster.g>
        <2579735c-d0cd-d159-8cdb-3348c808b9ef@gmail.com>
Date:   Tue, 12 Sep 2023 12:25:03 -0700
Message-ID: <xmqq34zjnqi8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1379D078-51A2-11EE-9645-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Junio,
>
> Le 2023-09-12 =C3=A0 12:57, Junio C Hamano a =C3=A9crit=C2=A0:
> =20
>> * pb/completion-aliases-doc (2023-09-11) 1 commit
>>  - completion: improve doc for complex aliases
>>=20
>>  Clarify how "alias.foo =3D : git cmd ; aliased-command-string" should
>>  be spelled with necessary whitespaces around punctuation marks to
>>  work.
>>=20
>>  Will merge to 'next'.
>>  source: <pull.1585.git.1694274592854.gitgitgadget@gmail.com>=20
>
> Thanks, I just sent a v2 so let's make sure this is what you merge:
> <pull.1585.v2.git.1694538135853.gitgitgadget@gmail.com>

OK.  Thanks for a heads-up _before_ it hits 'next'.

>> * pb/complete-commit-trailers (2023-09-07) 1 commit
>>   (merged to 'next' on 2023-09-08 at 842587016d)
>>  + completion: commit: complete configured trailer tokens
>>=20
>>  The command-line complation support (in contrib/) learned to
>>  complete "git commit --trailer=3D" for possible trailer keys.
>>=20
>>  Will merge to 'master'.
>>  source: <pull.1583.git.1694108551683.gitgitgadget@gmail.com>
>>=20
>
> I've incorporate Martin's suggestions so let's wait to merge my v2=20
> instead:
> <pull.1583.v2.git.1694539827.gitgitgadget@gmail.com>

It is too late for a replacement v2 once it is in 'next', though.
