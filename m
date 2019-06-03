Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 759581F462
	for <e@80x24.org>; Mon,  3 Jun 2019 18:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfFCSGM (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 14:06:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55397 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfFCSGM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 14:06:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 39C3F7BD16;
        Mon,  3 Jun 2019 14:06:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XbEmSHm+Zip8l37AGuyZo9Cifzg=; b=rgMWWv
        7yZnFf2A85MqYI8Gs2N8Rj4+f7S9QlNF+LbApmZgFMveiCnp/QbrUc7de2nofZoj
        //ZrNhjHIvMpRzDl8oIuiboV00WOSn44Jc+Z6vWn/yDhtKPxeuYxe6pNORFzUW9k
        ik7k0R8uAF/0UbVVhjAYU4KKXUYV5iZDhfkmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DG1IZINinXLuvS6lcYgKR7eYmp50uLWX
        1dGSjGMLpnFZDBku1apbmOgcDeBNhm7gP5XHEeJZjizkuu1zh5mjP85Cz3Rph4SZ
        yQYj1QMoeQx4tneNftHQlefCYmkVTvB32rBmfMJbs7hun6VvauVQIRDmfaaNq6RY
        wLcdkT3OXo0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 31B627BD15;
        Mon,  3 Jun 2019 14:06:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 582EA7BD10;
        Mon,  3 Jun 2019 14:06:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] RelNotes: minor typo fixes in 2.22.0 draft
References: <20190601155106.GK3654@pobox.com>
Date:   Mon, 03 Jun 2019 11:06:05 -0700
In-Reply-To: <20190601155106.GK3654@pobox.com> (Todd Zullinger's message of
        "Sat, 1 Jun 2019 11:51:06 -0400")
Message-ID: <xmqqo93ev90y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 427D34FC-862A-11E9-918D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
> These are all just minor typos I noticed while reading the
> release notes.
>
> I did find the first entry on the checkout --no-overlay read
> a bit strangely with the multiple "out's" in '... checking
> out paths out ...'.

Ah, of courese, "checking paths out of the tree-ish" was what I
meant to say, as I find "checkout" (or worse "check-out", or even
worse "check out") used as a verb a bit too techy.

Thanks for all other typofixes.
