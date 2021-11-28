Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEFAC433EF
	for <git@archiver.kernel.org>; Sun, 28 Nov 2021 23:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359652AbhK1XVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Nov 2021 18:21:11 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62133 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbhK1XTL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Nov 2021 18:19:11 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 270D21583C5;
        Sun, 28 Nov 2021 18:15:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xCgfJcWqEjvrItulxq7EjSWxxGfGzGBJLDUdJE
        v+pXQ=; b=MvWCtoqQ/uKYN9iHsudJIKjuLslE7xl+0vcC2EhEImceKIwOkvV82a
        eFJn0XbJ3hEMa45Td+EBOfpTsSDF7aYTKYbdkGbc3wq02Dbs35c77xcPci4eNgYz
        HKCiVpjeeVSMQWG2KBvqC9dqX0zXNzILl9VYMSXGppZTRTmQ70a+0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1F05C1583C3;
        Sun, 28 Nov 2021 18:15:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 39B0A1583C0;
        Sun, 28 Nov 2021 18:15:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, tr@thomasrast.ch
Subject: Re: [PATCH] add -p: avoid use of undefined $key when ReadKey -> EOF
References: <20211128174903.5623-1-carenas@gmail.com>
        <xmqq8rx85ala.fsf@gitster.g>
        <CAPUEspjo+cKLnE+MoABp_NnGDCCz8fL=pJj3ZNsKmCVetUn1jA@mail.gmail.com>
Date:   Sun, 28 Nov 2021 15:15:48 -0800
In-Reply-To: <CAPUEspjo+cKLnE+MoABp_NnGDCCz8fL=pJj3ZNsKmCVetUn1jA@mail.gmail.com>
        (Carlo Arenas's message of "Sun, 28 Nov 2021 12:52:39 -0800")
Message-ID: <xmqq4k7v6fdn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 203DAAD6-50A1-11EC-91CC-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> I have no strong opinions eitherway, so let me know what you would
> prefer and will get a v2 with it; thanks for reviewing.

I have no strong preference either way, so I just queued what we
reviewed as-is.

Thanks for the fix.
