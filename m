Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A868AC00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 16:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbiHLQmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 12:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiHLQmf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 12:42:35 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E9CA7A92
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 09:42:34 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2BE5A1B5C91;
        Fri, 12 Aug 2022 12:42:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QJASuTM/Ttk34pXSdD+gKuW1HRsEZEhmPinrXb
        dVXbo=; b=PKKPCVkVigrLEwwp8zzSK20gH3/n3R+mjMzaCFygCvmKIsPvYxHr2x
        rluPzSzoC+4nVgMgBohekFNKDYVtBWXgslz5uMJEUnAeAqtiruEQ4ah44EO2/TSU
        X/YXyDw/BuKL6DsGJOuGgB4LEodqmufHNpfdOSuf14Pd+NKA1fooI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 23D091B5C8F;
        Fri, 12 Aug 2022 12:42:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C170A1B5C8E;
        Fri, 12 Aug 2022 12:42:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
Cc:     git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git for Windows 2.37.2
References: <20220811214252.4351-1-johannes.schindelin@gmx.de>
        <0e859fe2-3f23-4526-083c-082adb0028fc@github.com>
Date:   Fri, 12 Aug 2022 09:42:29 -0700
In-Reply-To: <0e859fe2-3f23-4526-083c-082adb0028fc@github.com> (Victoria Dye's
        message of "Thu, 11 Aug 2022 16:22:11 -0700")
Message-ID: <xmqqwnbdct1m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C20A4528-1A5D-11ED-BA84-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> Johannes Schindelin wrote:
> Just a heads-up: there was an issue with the process used to generate this
> version. ...

Sorry to see that it caused two cycles of release process.  Would it
have helped you if I had done things differently (other than "not
issuing maintenance releases that are not security relevant"), perhaps
giving a notice in advance by say a few days?

Thanks.
