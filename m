Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468FEECAAA1
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 18:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiIOSFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 14:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiIOSFh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 14:05:37 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5FC8708C
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 11:05:36 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DB3D31B131A;
        Thu, 15 Sep 2022 14:05:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rzVXEIwyZOdponUH62Pu4dejyZUrTDGXqqjOFg
        EKiXI=; b=WBY0tVauUmNU/jPbCE57HmQfkcnBr8rYyWIjv9Zj7esrc0wWh0BCOi
        YA6f5CLZKfTauNO1YtiSP5aM1jm6iJdLsXHI4ukyorf+IgEoFd1Y0xqGxfIIY8dz
        kzXYNuiRHdwHr+Of/qwFUYRCoTpW29yLJNnnEEyWHc3cM25HzCgjI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D3D9B1B1319;
        Thu, 15 Sep 2022 14:05:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 11B811B1317;
        Thu, 15 Sep 2022 14:05:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Brijesh Patel <bridgepatel@gmail.com>, git@vger.kernel.org
Subject: Re: BUG: Value for GIT_SSL_NO_VERIFY has no effect
References: <CACs=J2MLnawNF5mp19sCJAZADPenHjWVZvKW5rM1fwELHjqqyg@mail.gmail.com>
        <YyMi76Cy7KnfZFU4@tapette.crustytoothpaste.net>
        <xmqq8rmkpsit.fsf@gitster.g>
        <YyNPp3UMCii67ugC@tapette.crustytoothpaste.net>
Date:   Thu, 15 Sep 2022 11:05:30 -0700
In-Reply-To: <YyNPp3UMCii67ugC@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 15 Sep 2022 16:15:35 +0000")
Message-ID: <xmqqwna4ms2d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD288A10-3520-11ED-AED2-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> SSL_NO_VERIFY is worse, as it is not even described.  So we should
>> add it to "git help git".
>
> It is documented in git-config(1), but of course we should also document
> in git(1) as suggested.  Do you want to turn this into a nice patch or
> would you prefer that I turned it into one with your sign-off?

It seems our mails crossed ;-)
