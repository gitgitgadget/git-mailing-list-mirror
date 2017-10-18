Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E18B11FF32
	for <e@80x24.org>; Wed, 18 Oct 2017 00:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757686AbdJRALS (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 20:11:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57416 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757020AbdJRALR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 20:11:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 50CC1A3FA1;
        Tue, 17 Oct 2017 20:11:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=82xoNGomlRXNjGMWPcZTLsnJojQ=; b=u0ottX
        v36fxDbCUXr/ayjZcQe1faLgKDGgh5noncE85aiLqG6cYaENaalLGvZzBRDXheRm
        KIYnQ7g2YI54HWamCE8Yb0PlblJ62KNJS0OQ9zYCDOwX9Lyq+utVcy+EhFt3KPkg
        LEmxcrICmWlbY6532rVBHAOXCHjrP/9dvtckM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kh5nLrvO7Bggi2ysWjbt3TEw+HEksDO3
        M7KTYXor57U5LH5gstbCV/N9g8ckpuqKcwMI5YgG0AKDyMmPPKn9p0Nd3b0p6zCE
        6IH9vkKGnWIfyqH/Ul/P0KnXUg3ln2Saj2xzffU5MWTlLPEHD0LnI04xnJ/HiMVd
        Q+HQDzOMa+Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4936FA3FA0;
        Tue, 17 Oct 2017 20:11:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BD48BA3F9F;
        Tue, 17 Oct 2017 20:11:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Glasser <glasser@meteor.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] doc: list filter-branch subdirectory-filter first
References: <0102015f277a12fe-c69362e3-b14c-4b5c-abaa-4693fd6632c2-000000@eu-west-1.amazonses.com>
        <0102015f29b9128b-a8d6e31c-06f5-421c-989a-230a484482d3-000000@eu-west-1.amazonses.com>
Date:   Wed, 18 Oct 2017 09:11:15 +0900
In-Reply-To: <0102015f29b9128b-a8d6e31c-06f5-421c-989a-230a484482d3-000000@eu-west-1.amazonses.com>
        (David Glasser's message of "Tue, 17 Oct 2017 09:45:15 +0000")
Message-ID: <xmqq7evtmi1o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC24DDE6-B398-11E7-8E5F-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Glasser <glasser@meteor.com> writes:

> From: David Glasser <glasser@davidglasser.net>
>
> The docs claim that filters are applied in the listed order, so
> subdirectory-filter should come first.
>
> For consistency, apply the same order to the SYNOPSIS and the script's usage, as
> well as the switch while parsing arguments.
>
> Add missing --prune-empty to the script's usage.
>
> Signed-off-by: David Glasser <glasser@davidglasser.net>
> ---

Thanks for being extra careful.  Will queue.
