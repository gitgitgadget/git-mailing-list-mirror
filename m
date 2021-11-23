Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2969C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 22:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbhKWWFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 17:05:43 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53000 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbhKWWFm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 17:05:42 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5771A159512;
        Tue, 23 Nov 2021 17:02:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YQ41dGFnx8Yv
        KbKHkckQDHEDR49vgKvAw5T16fkPif4=; b=b+Y4bxfZ4irpKg3LA70mC32fdYqY
        2CD0a0Bzg7k2hMO89Ns0tKER4qtg63OKeGfg2PI6z1PYysbhmRRVtRyXyc/BsX9L
        6GXuOT/BX0epGhCWYVcjidU9dhtrE7UrDc7b+BhSSejmm177WS37PBmI0qIzVjZR
        FyRBsy6QUr367x8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4FB76159511;
        Tue, 23 Nov 2021 17:02:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A98A115950F;
        Tue, 23 Nov 2021 17:02:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Aleen =?utf-8?B?5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Cc:     =?utf-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87_=28Aleen=29_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v11 1/2] doc: git-format-patch: describe the option
 --always
References: <pull.1076.v10.git.1637567471.gitgitgadget@gmail.com>
        <pull.1076.v11.git.1637681215.gitgitgadget@gmail.com>
        <3d7e96ce2b32096a6b900abe825b9df7b0ec3831.1637681215.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2111231710500.63@tvgsbejvaqbjf.bet>
Date:   Tue, 23 Nov 2021 14:02:29 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2111231710500.63@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 23 Nov 2021 17:12:00 +0100 (CET)")
Message-ID: <xmqqr1b67cp6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0DD83E7A-4CA9-11EC-AC33-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 23 Nov 2021, =E5=BE=90=E6=B2=9B=E6=96=87 (Aleen) via GitGitGadg=
et wrote:
>
>> From: =3D?UTF-8?q?=3DE5=3DBE=3D90=3DE6=3DB2=3D9B=3DE6=3D96=3D87=3D20=3D=
28Aleen=3D29?=3D
>>  <aleen42@vip.qq.com>
>
> I triggered the Azure Pipeline to submit this patch series after mergin=
g
> the PR that fixed parsing of the `From:` line.
>
> It looks a bit funny that this is in two lines, so I downloaded the mai=
l
> from https://lore.kernel.org/git/ and fed it to `git am`, which was jus=
t
> fine with it.

;-)  Thanks for double-checking carefully.


These two are identical to what has been in my tree (as I
manually tweaked the patches from the previous rounds).

1:  6112004764 =3D 1:  e9181bd6fd doc: git-format-patch: describe the opt=
ion --always
2:  b26f121395 =3D 2:  ca426b823b am: support --empty=3D<option> to handl=
e empty patches

I'll pretend that I took v11 but please do not get alarmed if the
author and committer times are from v10.

Thanks, both.
