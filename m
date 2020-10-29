Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C08C55179
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 17:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 187BD21531
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 17:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F4aKsKev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgJ2Rnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:43:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62664 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgJ2RnX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 13:43:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 910337D48C;
        Thu, 29 Oct 2020 13:43:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=voxvgwCzmFuLm3bWkhEnrmp/mvw=; b=F4aKsK
        evrMXa5qEMdkG5ezP2BTLoVfSUKzOlt2qAvMFXv42121JYYoR2aK/NFS+ZU8fmMP
        pbsXXRXheR851ODX9wscbhldfdeGy1o9fzPRg+MCPXphANNQyf44XM8OxbP3bDRi
        rvSLBpmI9/UoOmG3xwKDgkTd4QinZyz1cPf3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Xl8aNJo/WCvMR6w0TH+bcW4RJ6zmC9gz
        aEA3h/wf3cD5cWMcDhZf8GR6d+sz3PFkPN+KnaGbw4KY/sZW0A6Hix6xb2q5chRx
        UHkUpVS+ThqxytmUx4pX2oUr7Q4G/ypHk7rh4tmq1R3TpCns3keJUwqa0QjM5nSY
        65pGp4zpcPY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 88A0B7D48B;
        Thu, 29 Oct 2020 13:43:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 10E727D489;
        Thu, 29 Oct 2020 13:43:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 00/29] completion: zsh: latest patches
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
Date:   Thu, 29 Oct 2020 10:43:20 -0700
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Tue, 27 Oct 2020 20:06:43 -0600")
Message-ID: <xmqqy2jp6i87.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C71598E-1A0E-11EB-98AE-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Changes since v2:
>
>  * Silenced pkg-config command in case of errors
>  * Improved loading of bash script so it's backwards compatible

Will replace.  Thanks.
