Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDC2C433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 162A120575
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iZNkK9JK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgEMVQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 17:16:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56994 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgEMVQA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 17:16:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F16C7BD5A4;
        Wed, 13 May 2020 17:15:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=aUSrnGvoEQvh
        hWuqzm8Url0z7Bc=; b=iZNkK9JKWrWxK9lPwXQp69cx6iVHrs1LwYl3O1lpnbLm
        Gz8jw9BLp4OVUWC7OqbUSkNoYhzEv4yZNMtTKBB8ljLPjVLMGn5/kpMwmIP34nzb
        ZzX0Co5Al8P23WNfrZK24T3qUijrtWnAlr6CtZwEWIod62seimtEIdhL5wstvPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SHf0TS
        myxVLFEnVrbMXoDFWzrbfC5fQpTOcAnjYT9Hzm+Gcp9tgvF2s5nj0GB4rxeQy2da
        NLE/Jba2S/9FdHWWQoNwPlR+WnQjUYDXGl6YW9EYilQaRNiJ+9Da3cufHPy9Z3a9
        7j6HgWtohxdWbihVgolbz1Xq7HU6W2KwuYnG4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E9F69BD5A3;
        Wed, 13 May 2020 17:15:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1F85BBD59E;
        Wed, 13 May 2020 17:15:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denis Efremov <someden@ya.ru>
Cc:     git@vger.kernel.org
Subject: Re: Update git version for apt-get
References: <D9813694-67FF-403B-8C7D-8DF013C96D98@ya.ru>
Date:   Wed, 13 May 2020 14:15:54 -0700
In-Reply-To: <D9813694-67FF-403B-8C7D-8DF013C96D98@ya.ru> (Denis Efremov's
        message of "Wed, 13 May 2020 23:54:44 +0300")
Message-ID: <xmqqftc3sfhx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EF3D45A8-955E-11EA-BB15-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denis Efremov <someden@ya.ru> writes:

> =EF=BB=BFIs there some plans to update git version for apt-get from 2.1=
1.0 to higher (maybe 2.13)? It will be very helpful for a lot of cases wi=
th docker images.

Wrong mailing list.  Perhaps talk to either Ubuntu or Debian folks?
