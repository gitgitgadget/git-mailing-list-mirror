Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4824BC49EA2
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 02:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3447E613F5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 02:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhFOC0X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 22:26:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54267 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhFOC0R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 22:26:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C51D7C6A86;
        Mon, 14 Jun 2021 21:45:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=agznBnmjcdnH3ln+lc+iYm0gwVxbOlaT0PtrRj
        25+IU=; b=dCC5iowRP11vFy+E7MHxndYTqXBEXwB+5WAFGz50ccQYgsuyomiCRD
        gzzqT5PRyDVUYIGg1Tksq3VXCzT7RA1gafU+unIRlGV42KyUuvx4hOlTowld3cRN
        rsfZEjhaEcOi0fahoudI+v1ioIfQY4mXA0oi5y5yzlYEAgTdMlK9k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC159C6A85;
        Mon, 14 Jun 2021 21:45:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0D8DBC6A84;
        Mon, 14 Jun 2021 21:45:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH 0/2] Trivial cleanups
References: <20210613063702.269816-1-felipe.contreras@gmail.com>
Date:   Tue, 15 Jun 2021 10:45:45 +0900
In-Reply-To: <20210613063702.269816-1-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Sun, 13 Jun 2021 01:37:00 -0500")
Message-ID: <xmqqbl87zyra.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 672ED22A-CD7B-11EB-9A9E-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> These perfeclty good patches from 2014 weren't picked with no good
> reason.

These are safe no-op changes, but that does not mean they are good
patches.  It goes against Documentation/CodingGuidelines to bring it
back again now, which is a good enough reason not to look at them.
