Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADECC433F5
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 06:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC23460FD7
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 06:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhKNGoL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 01:44:11 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60752 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhKNGoL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 01:44:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 96974149C05;
        Sun, 14 Nov 2021 01:41:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u3f2AKEzbPlnS6dapu+2xOOHi7eYUqeKxT3w3L
        YyZDs=; b=xuRY3fMzSaMPKO+6Yvc8ELSv6TCGmOKILQMbtXx3YeaWzmudSadPCI
        /10Y7wjHg+r//fHZA5vLGE667BXt3+nyIpNGkK9Jm7aE1D84hPPptf1fKYBk+XvT
        qsX7lyl3Cw1AJlYjDv8UJiLrIu+lyga8y/jSQwYWk0JT2zi4Ws2L0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8DE0A149C04;
        Sun, 14 Nov 2021 01:41:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F22AE149C03;
        Sun, 14 Nov 2021 01:41:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Saksham Mittal <gotlouemail@gmail.com>
Cc:     Johannes Altmanninger <aclopte@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] MyFirstContribution.txt: fix undeclared variable i in
 sample code
References: <20211113122833.174330-1-gotlouemail@gmail.com>
        <20211113130508.zziheannky6dcilj@gmail.com>
        <2b2386b9-045d-a0b8-6dbc-8a9d0c446bea@gmail.com>
Date:   Sat, 13 Nov 2021 22:41:13 -0800
In-Reply-To: <2b2386b9-045d-a0b8-6dbc-8a9d0c446bea@gmail.com> (Saksham
        Mittal's message of "Sat, 13 Nov 2021 18:38:25 +0530")
Message-ID: <xmqq7ddbme7q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD3DA222-4515-11EC-B454-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Saksham Mittal <gotlouemail@gmail.com> writes:

>> It is declared, there is an "int i;" a few lines up.
>
> Oh, man, I never even saw that! The patch is completely unnecessary
> then. Sorry for that!

No need to say sorry; you'd want to be a bit more careful next time,
that's all.

Also, our code does not introduce a new variable in the first part
of "for (;;)" loop control, so even if the original lacked decl for
"i", the posted patch is not how we write our code for this project.

Thanks.

