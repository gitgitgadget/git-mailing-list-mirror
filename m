Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757E6C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 20:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5799860295
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 20:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbhJLUZ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 16:25:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57782 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbhJLUZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 16:25:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E15381013FB;
        Tue, 12 Oct 2021 16:23:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gBCya7t1QOZX
        bq3alHQc4hDeMIpRVkq0PoAcjUos6mU=; b=EJzbP0kJsxiUOYqaSM5c5hiw6s9e
        fiLDwYL19IWAEC9LiJ7PhD7rC+ngXjhCjIoekA4XMYPN+rkWVqCfCa+LPtFxNkhk
        GjE5BaW37Sd6E4dE19rF57qu2s2KRhwGUe41L4z/QmPYezQ6wY9Z0KwIsx/6jbFl
        vD3zNvgvps13q/I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D95031013FA;
        Tue, 12 Oct 2021 16:23:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4AF331013F9;
        Tue, 12 Oct 2021 16:23:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v4 0/3] Use default values from settings instead of config
References: <20211005001931.13932-1-chooglen@google.com>
        <20211012174208.95161-1-chooglen@google.com>
Date:   Tue, 12 Oct 2021 13:23:24 -0700
In-Reply-To: <20211012174208.95161-1-chooglen@google.com> (Glen Choo's message
        of "Tue, 12 Oct 2021 10:42:05 -0700")
Message-ID: <xmqqmtne2ds3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 40C52A94-2B9A-11EC-8F8F-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> And since I am re-rolling, I incorporated =C3=86var's feedback regardin=
g the commit
> messages (thanks!). I considered combining patches 1 and 2, but patch 1=
 has a
> grown a little to fix the CI issues, so I've decided to keep patches 1 =
and 2
> separate.

OK.  Will replace.  Thanks.
