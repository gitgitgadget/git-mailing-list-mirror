Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E502D1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 21:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757179AbcHCV4h (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 17:56:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50199 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751898AbcHCV4g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 17:56:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 016EB31708;
	Wed,  3 Aug 2016 17:37:33 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2ZeOA0GIFu6qN9oA+TK3LHjcNkc=; b=ccScmd
	70PtjPLyfpUnKb1P4hGJEcw0A54Lk1wFlj5NzwmVcLk/MV7HFCTNC3wa4orO8jK2
	Vwgd+Rjpbb/zAumP7FJCEXuzyh/HkpVH07AJ1GMkRNt1CAaTR9YN/K0XsBekbHHQ
	IgzdFP32zGflkTZwxEm8ANDn9vkG7hFoP/kkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rps1mfI6fRtZLhJVjJ1JGe82r71nc2oW
	WjpuffCUSkf0ZPnDiK6P5RQe/XLa5WrEWK1CAm9b529knpEJu6kaXdVtiETs24NH
	VSHe7mAk5TTf/OjDvjg9xVPi9UkLvqh/QRXMIQHzy1A7v9ouEpIq4JGgH5CFOzPx
	ZXTiwp2DKo0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EF40131707;
	Wed,  3 Aug 2016 17:37:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7BE3031706;
	Wed,  3 Aug 2016 17:37:32 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff Hostetler <git@jeffhostetler.com>
Cc:	git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 3/8] status: support --porcelain[=<version>]
References: <1470147137-17498-1-git-send-email-git@jeffhostetler.com>
	<1470147137-17498-4-git-send-email-git@jeffhostetler.com>
Date:	Wed, 03 Aug 2016 14:37:30 -0700
In-Reply-To: <1470147137-17498-4-git-send-email-git@jeffhostetler.com> (Jeff
	Hostetler's message of "Tue, 2 Aug 2016 10:12:12 -0400")
Message-ID: <xmqqmvkt7cv9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C4AC006-59C2-11E6-8BEA-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> +	else if (!strcmp(arg, "v1") || !strcmp(arg,"1"))

Missing SP between arg, and "1" here (FYI, editing it here to fix
would affect a later patch that has this line in the context).

Other than that looking good so far.
