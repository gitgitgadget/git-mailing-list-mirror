Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5DBC433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 21:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E6D60F6F
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 21:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243109AbhJOVd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 17:33:59 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61232 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243106AbhJOVd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 17:33:58 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9166416090A;
        Fri, 15 Oct 2021 17:31:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mav7A5yXr+2cMbitENo/mShHLIKteEzq82zomQ
        1JFcA=; b=dx49boqCHxcIYo3xWY5QQIR1ejdDk/dsSOSD72oXT/11c4A9r70i1v
        j3SkZjEjAZftdLiSAJ2gdJjnkRM+Iwq890CVPitmdKbxTDEjXqteIAqGO3Mfl+BL
        fgJ1wynW79pa/7wHI/k8pdozvu6GkLtQJi2eWyVofRgifDqYtGMC0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 899C7160909;
        Fri, 15 Oct 2021 17:31:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BADEF160908;
        Fri, 15 Oct 2021 17:31:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v5 0/3] Use default values from settings instead of config
References: <20211012174208.95161-1-chooglen@google.com>
        <20211015201631.91524-1-chooglen@google.com>
Date:   Fri, 15 Oct 2021 14:31:46 -0700
In-Reply-To: <20211015201631.91524-1-chooglen@google.com> (Glen Choo's message
        of "Fri, 15 Oct 2021 13:16:28 -0700")
Message-ID: <xmqqmtna3rgd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D433A60-2DFF-11EC-A39D-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, all three changes look quite well reasoned.

Will queue.
