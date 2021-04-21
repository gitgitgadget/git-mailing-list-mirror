Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692B2C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 00:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE7561418
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 00:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbhDUAnW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 20:43:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50879 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbhDUAnW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 20:43:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D73DB118824;
        Tue, 20 Apr 2021 20:42:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jSVTVBEAMjs/3KF4V2zzPGPUu/w=; b=pFbkQW
        DBPxGlYoibHRYvwSKjNrcACqFVVFGOSm8b8R6c1pFkgC0SL3EiDeFr7s7UKVQicN
        0XcoSpV3fqmtbcfMq8aQSdP+LWj7Bjsx6VbUrWbWyHHxayfPJzRdL9VRr+xB6eef
        huwE6Rsex3PV0LzvL+fCuhGbCGs6NZsQU+5Hk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m8aTns1yq6bLn4NOk9oVnqMnVO9m/J2s
        WbfPE1xbGBwIT6z3mGyIadOz1BFexhRDxcqTBAlflosrcqCyfSzouwHx85+pDdOf
        FTfUQbdt1+S2We4vX5/6wUO8K7lJoTYNslFp4qqKm7L/wIFBtf0WW1sN5h8B1WW8
        U+AxcqAPFCo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D07E2118823;
        Tue, 20 Apr 2021 20:42:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 050ED118822;
        Tue, 20 Apr 2021 20:42:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bruno Albuquerque <bga@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] object-info: support for retrieving object info
References: <20210420233830.2181153-1-bga@google.com>
Date:   Tue, 20 Apr 2021 17:42:44 -0700
In-Reply-To: <20210420233830.2181153-1-bga@google.com> (Bruno Albuquerque's
        message of "Tue, 20 Apr 2021 16:38:31 -0700")
Message-ID: <xmqq35vk1n97.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D628F94-A23A-11EB-8736-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bruno Albuquerque <bga@google.com> writes:

> Sometimes it is useful to get information of an object without having to
> download it completely.
>
> Add the "object-info" capability that lets the client ask for
> object-related information with their full hexadecimal object names.
>
> Only sizes are returned for now.
>
> Signed-off-by: Bruno Albuquerque <bga@google.com>
> ---
>
> This version is a small change with just style fixes.

Will queue.  Thanks.
