Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74B6C433FE
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 21:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3E8460EB4
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 21:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350341AbhKOVpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 16:45:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51934 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350763AbhKOVfe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 16:35:34 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BFA03F2519;
        Mon, 15 Nov 2021 16:32:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tMi/KWN6ApuW4apkWxRIFybYmPkmQoTPQFKEzw
        yZ50U=; b=DXahZJ4JbvMEX7AU5kIP7ZWzt6vgJTqZq/bqz+8ayRMNQqvTS6BBZf
        pt7LaBKvSmMmzdyOp7OrNN4ZRzLz+CuR+WkGv+DKSzxIJ/GiGcxlaXUwQWNxTHsZ
        5O8I4A0zEkdSvmSob+seq5wikr7LgP+StDo40Wgb1wRr4mSJpLTlI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8263F2518;
        Mon, 15 Nov 2021 16:32:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2DEEEF2517;
        Mon, 15 Nov 2021 16:32:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git for Windows 2.34.0
References: <20211115195335.5290-1-johannes.schindelin@gmx.de>
Date:   Mon, 15 Nov 2021 13:32:27 -0800
In-Reply-To: <20211115195335.5290-1-johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Mon, 15 Nov 2021 19:53:34 +0000")
Message-ID: <xmqqo86lcdg4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 882A0086-465B-11EC-A42A-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Dear Git users,
>
> I hereby announce that Git for Windows 2.34.0 is available from:
>
>     https://gitforwindows.org/
>
> Changes since Git for Windows v2.33.1 (October 13th 2021)
>
> New Features
>
>   * Comes with Git v2.34.0.
>   * Config settings referring to paths relative to where Git is
>     installed now have to be marked via %(prefix)/ instead of the
>     now-deprecated leading slash.
>   * Comes with Git LFS v3.0.2.
>   * Contains new, experimental support for core.fsyncObjectFiles=batch.
>
> Bug Fixes
>
>   * Configuring a system-wide VS Code as Git's editor was broken, which
>     has been fixed.
>   * It is now possible to clone files larger than 4GB as long as they
>     are transferred via Git LFS.
>   * Git now works around an issue with vi and incorrect line breaks in
>     the Windows Terminal.
>
> Git-2.34.0-64-bit.exe | 2a833d15f97539e845b3883e375a8a152e8199b63ac345282d80f834f7d6a9b6
> Git-2.34.0-32-bit.exe | e665d6d2e454bfe2a9172e326becf00a8d82d0de080cebdae4218d1727b1897e
> PortableGit-2.34.0-64-bit.7z.exe | 12f6aed40fdf2d409dc61d5d1626eed97b0e818549d92626bfffdd7bc580855c
> PortableGit-2.34.0-32-bit.7z.exe | 46643dde0f40bee6e7963b9d67ec2f78ffc6882d452b866940e5fe5724dbdba3
> MinGit-2.34.0-64-bit.zip | e53818f68308a8f7988f37e2b56f4e8da2aa93b279b6a70c87a21972c7c4ab93
> MinGit-2.34.0-32-bit.zip | a8b68a86e999e5c6caf0bf79a92a20631c6b3d9c90404db49f27ed2244d3cb11
> MinGit-2.34.0-busybox-64-bit.zip | 5812ef40a0f03f917128f3b4866a7d463932b7f0b2744ac901f00c6434eedce2
> MinGit-2.34.0-busybox-32-bit.zip | bfbd5c5dc95d094616f40bd3d27833434b5c3d5dc8a5f3285236b50f6eee93d7
> Git-2.34.0-64-bit.tar.bz2 | dcbfd2b24c321973bbd7e27ef841be07749668a0a75c3fad1ddec933154d85d6
> Git-2.34.0-32-bit.tar.bz2 | 1b1961c9875edf35aca188e5182b80b1b6d0adae50c01f99f314b83c0062fdc5
>
> Ciao,
> Johannes

Thanks for quickly releasing and announcing the port.
