Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D6821F463
	for <e@80x24.org>; Fri, 20 Sep 2019 16:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403823AbfITQvt (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 12:51:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52943 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390491AbfITQvt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 12:51:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 734E82D2D9;
        Fri, 20 Sep 2019 12:51:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2sw+aZByY41d
        yxl84eQ181XpP14=; b=GKSTkthyGlTdvOxiHZYIQWZj1VCmy5wOKn3olYDqiQ1G
        iTbbwEmQQ49dBGAuWVJYaCtKr6D6n1KnXBE+2siKeQjimX8fl46N4Lxl94lUZk0a
        6hr1t8D9oBMBrUanLM84JAavJQf+p5DhJfvxM/JQCb4D/+1j3AAqIUlvtjbQSb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tnHsHs
        IAUv5zs/6NVIEFmBlI37/5pKxJHZ1Yja3LPNUGZCyzIqpwzBDf+WwReCL8EmCpag
        NvZZGW60tLpt8pSnWvn+SCoH5HWdmNlyJYVrMlQzvk7LcfGqJOSD+t9APSO688zh
        rarnvtJhYKsaS4wjkyMoqMkTBYp3xBGTfqmBE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C7FE2D2D8;
        Fri, 20 Sep 2019 12:51:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CE9582D2D6;
        Fri, 20 Sep 2019 12:51:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Sep 2019, #02; Wed, 18)
References: <xmqqy2yl44lw.fsf@gitster-ct.c.googlers.com>
        <CAN0heSrB_eZwRcXkTaNDQR+U1Xp0R_14ke+fAYyVfaV=R3apxQ@mail.gmail.com>
Date:   Fri, 20 Sep 2019 09:51:45 -0700
In-Reply-To: <CAN0heSrB_eZwRcXkTaNDQR+U1Xp0R_14ke+fAYyVfaV=R3apxQ@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 19 Sep 2019 06:41:05
 +0200")
Message-ID: <xmqq8sqix65a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EED77784-DBC6-11E9-AF7F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Hi Junio,
>
> On Thu, 19 Sep 2019 at 01:44, Junio C Hamano <gitster@pobox.com> wrote:
>
>> * ma/asciidoctor-refmiscinfo (2019-09-16) 3 commits
>>  - doc-diff: replace --cut-header-footer with --cut-footer
>>  - asciidoctor-extensions: provide `<refmiscinfo/>`
>>  - Doc/Makefile: give mansource/-version/-manual attributes
>>
>>  Update support for Asciidoctor documentation toolchain.
>
> What you have queued at ma/asciidoctor-refmiscinfo matches the latest
> version I posted. Thanks for picking it up.
>
>>  Expecting a reroll.
>>  cf. <CAN0heSq9B8NSr7-Bcqpiags6wyMm_3KUGeo+7GZA85nd7GnG=3Dw@mail.gmail=
.com>
>
> This reference ("please hold off") is from *before* that new version, s=
o
> you can drop this reference.

Thanks.
