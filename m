Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B56931F855
	for <e@80x24.org>; Mon,  1 Aug 2016 21:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbcHAVtH (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 17:49:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51023 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752119AbcHAVtE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 17:49:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AE70132443;
	Mon,  1 Aug 2016 17:49:02 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AB8iPFQSJCO/1oQvNE23N/qKhD8=; b=tgDwLU
	t9KKj2El6EKUbJfXVkH1r3rjtxhBw3Bjd2gArBnx8D4X1GLqit5JOgw6ymjSgr1H
	GhrLmT3bDg6eUjj6LsrHO9913qwbIbhpDAJNDTXPKHubULdcGenqaMPUDnHrtyj8
	EfxF/NLwSTmk/m0gvQviZHMa95StaiYDvwIvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AF96GX8KAwuHZ4wU93BHt/1OAUm1FGGC
	dS2PJ0n8D+VH7avpkGJdWgg0OmOLfUuNioJdmqt3otxDUwRr8sfRghUAlV/l7Okr
	wKMsy6nUGAV8wsv9uUs4dHnkCninS2c0gsKcH0GzkEV1MekdnpzFjCkmOnJ7JK8Q
	xVYg8H6XNB8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A579532442;
	Mon,  1 Aug 2016 17:49:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 181BD32440;
	Mon,  1 Aug 2016 17:49:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, apenwarr@gmail.com,
	jrnieder@gmail.com
Subject: Re: [PATCHv3 0/7] submodule update: allow '.' for branch value
References: <20160729004409.2072-1-sbeller@google.com>
Date:	Mon, 01 Aug 2016 14:48:59 -0700
In-Reply-To: <20160729004409.2072-1-sbeller@google.com> (Stefan Beller's
	message of "Thu, 28 Jul 2016 17:44:02 -0700")
Message-ID: <xmqqmvkwgnxw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C27F10B4-5831-11E6-A7AB-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This got bigger than expected, but I am happier with the results.
>
> The meat is found in the last patch. (At least what I am interested in; others
> may be more interested in the second patch which could be argued to be a real
> bug fix to be merged down to maint.)

Indeed 2/7 and 7/7 are both interesting.

Will queue; thanks.
