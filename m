Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAE8C433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 08:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E81A764E25
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 08:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhBKH7r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 02:59:47 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65207 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhBKH6t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 02:58:49 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5FD2610A7D4;
        Thu, 11 Feb 2021 02:46:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jPABmsxakvejh7/PQNocWK7m3do=; b=BLlX1T
        EDV232Lps/fUkhgUa0s730kcJvTTVk+ZxtrHuzxGiUJFEYMA0ir9+cAN1qfJoi2O
        m5EIjerlRdR4rtokv0sKEMnzSE3QqKW0IvGlPXcYeYuLd1fXVltGodij9bJJARPW
        R3zP4HSXuTsqklBCbHaNpoe/7vIFUNxUaJ6Fg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tnYTv4oLARR03m3G+cBowlWVpqkTYxIG
        1LkKAnJpSn3CMPeGWM2duKsozhZXWMh7FoKkAF6pk6RZMc8L0x19xfDa+yhLWeH7
        H68u0Ia7LqbrxEjhA3+jO6fdUUjiE1e/Sp9g5yF9uP5N2IPeOCQOHul9LMS1MSvp
        3lYic7rQIV8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 588CE10A7D3;
        Thu, 11 Feb 2021 02:46:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8E88810A7D2;
        Thu, 11 Feb 2021 02:45:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v4 0/6] Support for commits signed by multiple algorithms
References: <20210118234915.2036197-1-sandals@crustytoothpaste.net>
        <20210211020806.288523-1-sandals@crustytoothpaste.net>
Date:   Wed, 10 Feb 2021 23:45:55 -0800
In-Reply-To: <20210211020806.288523-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 11 Feb 2021 02:08:00 +0000")
Message-ID: <xmqqtuqjxd1o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D6F1800-6C3D-11EB-A082-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This series introduces support for verifying commits and tags signed by
> multiple algorithms.

Thanks.
