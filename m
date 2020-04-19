Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24811C2BA2B
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 05:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA63920753
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 05:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OxWAga4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgDSFeF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 01:34:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50349 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSFeF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Apr 2020 01:34:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EE945C4891;
        Sun, 19 Apr 2020 01:34:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GoYoxtb2cZbP3PLlb8RJnyC1Fi0=; b=OxWAga
        4cTgqSW6s7Mua5Q5xebomTkJEj2TpK974cpClAIi8oFgwUSbgRn+CMR40t001aRf
        UBo4w8RvBJI1MCb8w9+0gfS71ONngSdKwSyDptrBPfA5f2m5EGhmkmYf1y4KFpQe
        oZ935zd9rDqiOGpl2P9kng0SaLVvOmxpuvLUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TLi7Ryf5ASxreCDP7OhfdV8g1YMhAEkU
        s/2JdaDbkDj6SB/Ju0mGyqv8jrmw6nkRcjoDJHfbTKw2pFvJE3iWHKwGE5yqfMfG
        HJny9bH6MWITWZRC/6fZIszKeXXIMfyBqetoauntwoWDOaAAO0kZDwXxO301XSkt
        M8IcHSNKYY4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E6A3AC4890;
        Sun, 19 Apr 2020 01:34:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 27AA5C488E;
        Sun, 19 Apr 2020 01:34:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kelvin Wu <kelvin.wu@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Why the stand-alone installer for macOS hasn't been updated for 8 months?
References: <CAAxGxjXv+VvN6PqOK8WbxO6_eFrcBhiaj2xRWcUhCtO321JmOg@mail.gmail.com>
Date:   Sat, 18 Apr 2020 22:34:00 -0700
In-Reply-To: <CAAxGxjXv+VvN6PqOK8WbxO6_eFrcBhiaj2xRWcUhCtO321JmOg@mail.gmail.com>
        (Kelvin Wu's message of "Sun, 19 Apr 2020 11:54:28 +0800")
Message-ID: <xmqq4ktgt4xj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60603DB2-81FF-11EA-9F8D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kelvin Wu <kelvin.wu@gmail.com> writes:

> As title says.

Because nobody volunteers to make one?  You may be appreciated by
your fellow Apple customers if you volunteer to ;-)

