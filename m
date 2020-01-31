Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EF3C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 23:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ABF120705
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 23:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hDRi/cwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgAaXGn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 18:06:43 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52866 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgAaXGm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 18:06:42 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B8F86B4A56;
        Fri, 31 Jan 2020 18:06:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oPOaSn9rJ1Z9DpZDOuWyOhFxUyY=; b=hDRi/c
        wlMtiM/Xc56htKHsuptf+YArj9L15sIE0zZnm3sKmB0QsR7v/JQNAyLQ7qx0I2O7
        XwVowv+b8+5aJtEKn6iskHv+bCOZ4FAzK+LGS0PUOWQwc+MgTklxCbxzsjTtEdHq
        iZtUe9dEjF0AfgHt8iZ7DazgVqa8o/kcTF3co=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w+kBAHCOchuXgkLcM2MMs7ZiQyDPa+TW
        i0HCmgJA+1MLB8ZT3eCnhLNi2g6IWPjRtzy4vJZM6JUoAxW9GBIZ9rST6j0TmTOa
        vGnQObuHiwEAq9cAFobqaQL66RGhCxKCtnfssIkGd1JPp2q2b4l870Lw6MbjIvzx
        rLsbbTKVKcA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B0189B4A55;
        Fri, 31 Jan 2020 18:06:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DDEDEB4A52;
        Fri, 31 Jan 2020 18:06:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] doc: describe Git bundle format
References: <20200130225818.193825-1-masayasuzuki@google.com>
        <20200131221800.240352-1-masayasuzuki@google.com>
Date:   Fri, 31 Jan 2020 15:06:35 -0800
In-Reply-To: <20200131221800.240352-1-masayasuzuki@google.com> (Masaya
        Suzuki's message of "Fri, 31 Jan 2020 14:18:00 -0800")
Message-ID: <xmqqtv4b8bus.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 557FF5FE-447E-11EA-8170-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Masaya Suzuki <masayasuzuki@google.com> writes:

> * Change "you" to "the receiver" and "the sender" (I wonder if this should be
>   "writer" and "reader").

I come from "a bundle is a frozen snapshot of 'git fetch' transfer"
school, and consider the act of reading a "fetch" too much, but I
think "writer" and "reader" is more understandable for new readers.

Thanks.
