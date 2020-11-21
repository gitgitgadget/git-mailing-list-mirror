Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F5BC388F9
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 21:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 261D52080D
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 21:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D8rFNU7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgKUVxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 16:53:31 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61163 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgKUVxb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 16:53:31 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BCB07110598;
        Sat, 21 Nov 2020 16:53:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6S8zesOjdvgTs9ShJyEwEdRdNv0=; b=D8rFNU
        7vaY7W4NFMh6Xfjp16wDR/byqwoWSjZQr84rwCy9fDdQWxWnQizlawzC4uOfZvxt
        B6eODRBYF9WKdwzalE3I2xIc+zFBWozq0IJvXG7RTLiVz7yvPxM6Icw42lB70pPM
        YbYL5xSpuDW1mo45ss4/buOdYFm6nTK89T/IE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oMqxGX36qaK4x6amUbJsFQq9weMtUfBw
        +jC/w9pvFtGHYqCotDWgf1g87XGRKGTdhn4lCfzG2+SHN/x+0E7kgtBVskqO+6to
        2BQCGHikWf2IJ/iYO1Mhim7O9V+Rpu/QvUdEuGFE9IGy4xaV76LwIXRoVGTD9PW2
        Po2yo8fq86U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A2A34110596;
        Sat, 21 Nov 2020 16:53:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9EF90110595;
        Sat, 21 Nov 2020 16:53:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] myFirstContribition: answering questions is not the end
 of the story
References: <xmqq3613vrtx.fsf@gitster.c.googlers.com>
        <CADtb9Dw6+g61vNAvhdWqecMwh_M=nW6Ot21Cwy1wyP9EtDkN7g@mail.gmail.com>
Date:   Sat, 21 Nov 2020 13:53:25 -0800
In-Reply-To: <CADtb9Dw6+g61vNAvhdWqecMwh_M=nW6Ot21Cwy1wyP9EtDkN7g@mail.gmail.com>
        (Philippe Blain's message of "Fri, 20 Nov 2020 21:54:36 -0500")
Message-ID: <xmqqh7pis7fu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC8FFAD0-2C43-11EB-BDE5-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> I think this is a nice addition. However the patch title should probably
> be prefixed "MyFirstContribution" and not "myFirstContribition" ;)

Will update.  Thanks.
