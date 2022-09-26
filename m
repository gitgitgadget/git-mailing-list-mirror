Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE4AC07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 17:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiIZRiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 13:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiIZRhu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 13:37:50 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6142A87697
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 10:00:11 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05CE7142A96;
        Mon, 26 Sep 2022 13:00:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qKPhsyhJRZwY
        zp/IXldHskhewaO5RA4cpGV9CaX4SMo=; b=XR1VNlAvS5Wnx1MfKmb8LFSH5XAn
        UWPBao6Xehxt1V5HOoTcwLukFMWanCK57a93e0/JDWJv9epVMIPwhDaSBPjBeKbT
        0LtRofa0FXE5AKQsbrYNm/otkaq0ARqaUsORfeaZjWWQihlfEh2Wxtu5lMbrIXDX
        Igiitg5xfHYKzWc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E97BE142A93;
        Mon, 26 Sep 2022 13:00:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 32B9F142A80;
        Mon, 26 Sep 2022 13:00:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Claus Fischer <claus.fischer@clausfischer.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: Scriptable mode for git bisect
References: <Yy4c6/jHupgThj7j@clausfischer.com> <Yy5g80OtVG4op8L1@danh.dev>
        <xmqqwn9srb9e.fsf@gitster.g>
        <69B998A9-0E3E-45F0-8733-F2A3F11625A5@clausfischer.com>
        <Yy+n7/NolP5rCpwX@danh.dev>
        <C9CD178B-7A21-4F89-9D74-7CBD68DBF0C2@clausfischer.com>
Date:   Mon, 26 Sep 2022 10:00:02 -0700
In-Reply-To: <C9CD178B-7A21-4F89-9D74-7CBD68DBF0C2@clausfischer.com> (Claus
        Fischer's message of "Sun, 25 Sep 2022 14:42:43 +0200")
Message-ID: <xmqqo7v2qdf1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AA840E8E-3DBC-11ED-868A-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Claus Fischer <claus.fischer@clausfischer.com> writes:

> Oh thank you, I didn=E2=80=99t know that / didn=E2=80=99t grasp that wh=
ile reading (apparently too fast) your previous mails.
>
> That is way nicer.
>
> Thank you.
>
> Claus

Now I am puzzled by your earlier response in the thread, e.g.

  https://lore.kernel.org/git/E10623C2-FF73-4E5B-AD28-C255B02F3B0F@clausf=
ischer.com/

In any case, it is good to see that your issue has been solved.

