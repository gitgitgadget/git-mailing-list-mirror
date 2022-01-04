Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F40C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 21:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbiADVrv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 16:47:51 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51932 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiADVru (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 16:47:50 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 67418176157;
        Tue,  4 Jan 2022 16:47:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b/pr41FJqD57k2jC4W7BPotE4O/k50dEeNM2yF
        5owK0=; b=B2YlxVRguCODv2bzOV7o3/ww7A/311WYBuEQOmJ86foP0HuwW/RUU6
        S7vJiaDMVwFMHSgTKSGujJHVOLP47sbrlTiqe3LG3joiqhTdMBaHZeQBGMpWleSo
        dJPnNQo3cZUM2e8CkAsRb9T4gTRrTj0Np6fc57Y4NDAIN4XJqSmiM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5EE2B176155;
        Tue,  4 Jan 2022 16:47:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9754D176153;
        Tue,  4 Jan 2022 16:47:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: Re: [PATCH v2 RESEND 0/5] git-p4: fix RCS keyword processing
 encoding errors
References: <20220104124913.2894-1-jholdsworth@nvidia.com>
Date:   Tue, 04 Jan 2022 13:47:45 -0800
In-Reply-To: <20220104124913.2894-1-jholdsworth@nvidia.com> (Joel Holdsworth's
        message of "Tue, 4 Jan 2022 12:49:08 +0000")
Message-ID: <xmqqh7ajb2bi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F43EF34E-6DA7-11EC-BA9F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Holdsworth <jholdsworth@nvidia.com> writes:

> This patch-set fixes a family of issues with git-p4's handling of
> incoming text data that contains RCS keywords, when those files contain
> bytes which are invalid UTF-8 codes.

I do not see any difference between this version and what has been
merged to 'next' at 650cb248 (2021-12-27).  Sent a wrong version?

In any case, if there is an update, since the original series is in
'next', please send in incremental changes on top of them.

Thanks.
