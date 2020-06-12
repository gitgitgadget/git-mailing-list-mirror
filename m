Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA75C433E0
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 23:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9CF9206D7
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 23:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vfu1wIFI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgFLXOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 19:14:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62001 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgFLXOu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 19:14:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 51E63DFC94;
        Fri, 12 Jun 2020 19:14:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=63ErJMM0wiNlCp5uBTGQ87Yyn/E=; b=Vfu1wI
        FIzwoBPW7B3WD/7nMeEVdM7KU+xCI+TEkhwrCrF90w7Ebza7ivt5md3fJOl8OZwT
        e55YvZhc4wPgZBSrcWEJVS5cT3sRymjLu6GXfsGxoFXHcacyk940bdrVEr8l9//P
        LtZK1bfFJLA6vuFfg74SLhYpYHJrBiP/MFk9I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x1GigP6fKT97HO2a1j6fW10fARs6ulyV
        iqlJQv4Oh29seuOD2vSc9chT1YfQnPtyXCf72tM5IDfcqN+/8F+zlDhYGiJSt5Wd
        JeOrdGRmpv/9zBmqVlG+ktZHzqKzxmRcIL2CMGvBvptsmUXbEaLhKGLGbMxFaKiq
        x44DmfyyaKg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A6F5DFC93;
        Fri, 12 Jun 2020 19:14:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 97117DFC92;
        Fri, 12 Jun 2020 19:14:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] GIT-VERSION-GEN: update for the post 2.27 cycle
References: <4946cf3650b95191455630f85f59e5f93156d0ac.1591883410.git.liu.denton@gmail.com>
        <xmqq8sgtjsor.fsf@gitster.c.googlers.com>
        <20200612005217.GA3964@generichostname>
Date:   Fri, 12 Jun 2020 16:14:43 -0700
In-Reply-To: <20200612005217.GA3964@generichostname> (Denton Liu's message of
        "Thu, 11 Jun 2020 20:52:17 -0400")
Message-ID: <xmqq4krf27x8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81231082-AD02-11EA-846D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Thanks for the explanation, it makes sense.
>
>> Unfortunately, your patch does not say why, either, so it hasn't
>> quite helped yet ;-)
>
> I tried looking on the list but I didn't find any mention about this
> experiment so I assumed that you unintentionally forgot to update the
> version. Good to know that it was done deliberately :)

Well having said all that, I do not have a strong reason not to
update it.  Perhaps when the next batch of topics graduates and
cause the release notes to be updated, I'll update it as well.

Thanks.
