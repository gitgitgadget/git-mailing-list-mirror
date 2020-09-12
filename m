Return-Path: <SRS0=gF6X=CV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB6DC433E2
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 21:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57D252078B
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 21:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZEHm3dXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgILVsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Sep 2020 17:48:13 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58328 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgILVsL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Sep 2020 17:48:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 21B3BF3B0E;
        Sat, 12 Sep 2020 17:48:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xxemC8pmphxax4ZeHjjuZVUY/ZE=; b=ZEHm3d
        XtqwapuJ/ZqKIV7e8Zkalc4i7Eh2Mpyjj7P3lRsu8ZUFxIXpC8iQtp6DBhUhnnLq
        yx9JR4THWA3mi15UW2NHmo8FeVc1L9dSIAMF927uxXkfAUKrfb3zwYV41Mt5mgM0
        ryZmc4qSICV3UastDYsCgC7k/v3AjEsRdjHjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bQG9B3hbh94F3bUIRZeIjltV9ANrq/Vl
        pGiEdscxEFVZlZllj9IxMGpYmnnVUn2T3d0JzhsziB/9eMwSYeikOQcacBkZAJKZ
        Ap5bf0c2N7+0JgtCSH3ta97Te2oa3WWnaXjK3KcEuhuxqPC4kwicA4Fa4HmS/mjd
        R3khLAZUw9Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1A683F3B0D;
        Sat, 12 Sep 2020 17:48:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 48ADAF3B0C;
        Sat, 12 Sep 2020 17:48:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH 0/3] FAQ entries for merges and modified files
References: <20200912204824.2824106-1-sandals@crustytoothpaste.net>
Date:   Sat, 12 Sep 2020 14:48:05 -0700
In-Reply-To: <20200912204824.2824106-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 12 Sep 2020 20:48:21 +0000")
Message-ID: <xmqqwo0ymzu2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A54C1C60-F541-11EA-8759-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This series introduces a few new FAQ entries on various topics.

All look like topics worth covering.

Thanks.
