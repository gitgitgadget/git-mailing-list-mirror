Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F55EC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 17:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiGURjq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 13:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiGURjq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 13:39:46 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F698B48E
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 10:39:45 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89096135D20;
        Thu, 21 Jul 2022 13:39:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FWn/33906oIL
        9m7NtZiLjVxbLRpC8gcV+xL8yxGBm9A=; b=NPoxPO4q0OlqneKjwibEcwdDfb39
        p04e1Zr8ZSacsZvBEvwJ2xbi5iW+jpn/HmBdgn0/hldQuXjTXh8L3CL6APyB7fcH
        7PnwebxnisMglcbMxiOYe6mlYT9xRqPUQxmOKWLslmvGMWPgl770OpYWLkLM6iXC
        4ewP9+jz74dKGow=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 820B1135D1F;
        Thu, 21 Jul 2022 13:39:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE055135D1E;
        Thu, 21 Jul 2022 13:39:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yuri <yuri@rawbw.com>
Cc:     Konstantin Khomoutov <kostix@bswap.ru>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What is the URL of git's bug tracker?
References: <a5f48218-94ad-195e-97bc-b29c4a588903@tsoft.com>
        <20220721101948.2i3nyroxrexg4voi@carbon>
        <98dc2e8e-58b6-80ad-65da-2bd1cc5dffc2@tsoft.com>
Date:   Thu, 21 Jul 2022 10:39:42 -0700
In-Reply-To: <98dc2e8e-58b6-80ad-65da-2bd1cc5dffc2@tsoft.com>
        (yuri@rawbw.com's message of "Thu, 21 Jul 2022 09:49:22 -0700")
Message-ID: <xmqqfsiuicv5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1B49AFE6-091C-11ED-8CF6-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yuri <yuri@rawbw.com> writes:

> On 7/21/22 03:19, Konstantin Khomoutov wrote:
>> There is none - please read https://git-scm.com/community
>
>
> On 04-09-2021 I reported to this ML the bug that git-2.31.0 printed
> stray messages during 'git stash push' command.
>
>
> git stash push -- x11-toolkits/fltk
> Saved working directory and index state WIP on main: 4c2cc95952a6
> graphics/mesa-devel: update to 21.0.b.4390
> <stdin>:83: space before tab in indent.
> =C2=A0=C2=A0=C2=A0=C2=A0 LIBS=3D"$LIBS -lX11 $X_EXTRA_LIBS"
> <stdin>:84: space before tab in indent.
> =C2=A0=C2=A0=C2=A0=C2=A0 CFLAGS=3D"$CFLAGS $X_CFLAGS"
> <stdin>:85: space before tab in indent.
> =C2=A0=C2=A0=C2=A0=C2=A0 CXXFLAGS=3D"$CXXFLAGS $X_CFLAGS"
> <stdin>:88: space before tab in indent.
> =C2=A0=C2=A0=C2=A0=C2=A0 DSOFLAGS=3D"$X_LIBS $DSOFLAGS"
> <stdin>:89: space before tab in indent.
> =C2=A0=C2=A0=C2=A0=C2=A0 $as_echo "#define USE_X11 1" >>confdefs.h
> warning: squelched 40 whitespace errors
> warning: 45 lines add whitespace errors.
>
>
> Now in git-2.37.1 this bug is still there,
>
>
> Is it forgotten about? Is the fix planned? Is it fixed but not yet rele=
ased?
>
> It's impossible to say without a bug tracker.
>
>
>
> Yuri

Is there aything to be "fixed" in the first place?  What the
transcript shows is that the user tried to run "git stash push" and
in the process of creating the stash, it noticed whitespace errors
in the files that are being modified and reported, which is not
something that is unexpected.  It does not look like a bug.

At the end, after showing the "warning: 45 lines...", perhaps
something else happened that was not described in the report, like
"the stash was not created"?  If so that may be a bug, but it is
unclear if that is what the complaint is about, so...


