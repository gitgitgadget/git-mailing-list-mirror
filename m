Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 574B91F71B
	for <e@80x24.org>; Thu, 28 Jul 2016 02:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758880AbcG1CNd (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 22:13:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50727 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753144AbcG1CNb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 22:13:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6534831F17;
	Wed, 27 Jul 2016 22:13:30 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t5Il9S15BJjXbbvZyDLjMPHGKQ0=; b=hLWin6
	v1usKGNMlxAuBirgQ2g10qf8QSQjfY4hWOHzW6t8lR8bvT7j861qn6lx67hV66BS
	cbLI7f/gzCRIijYUeTC99HAGNMfNltqi6BsFkDVmABrUvYrnhxDvGLu8Z2LzUogq
	6AgdAbbTLUiKZn+AcAtRJkszKSjSJycVlGf14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nazN1HY1qydOr91kbQJH9hnbde1htvGX
	0EdpXwj0MYH41rKVtvbAKLT8YBpNn7+AaovjcGa3IMPC5AFqNC4fx2jbAGTrfHHi
	dXYQz2ivF8oZ0S2XkIWRGwRrltFuZh6mrguFef3yk94gNrZNkA+sFKFBvXUkBhcj
	6KU7KMaXwnw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D2A031F16;
	Wed, 27 Jul 2016 22:13:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C536F31F14;
	Wed, 27 Jul 2016 22:13:29 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	David Aguilar <davvid@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brett Cundal <brett.cundal@iugome.com>,
	"David A . Greene" <greened@obbligato.org>,
	Charles Bailey <cbailey32@bloomberg.net>,
	Techlive Zheng <techlivezheng@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 3/4] subtree: adjust style to match CodingGuidelines
References: <20160728001650.21482-1-davvid@gmail.com>
Date:	Wed, 27 Jul 2016 19:13:27 -0700
In-Reply-To: <20160728001650.21482-1-davvid@gmail.com> (David Aguilar's
	message of "Wed, 27 Jul 2016 17:16:49 -0700")
Message-ID: <xmqqinvqtsqg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E05C3516-5468-11E6-BD49-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> This is a replacement patch for (previously) 3/3 that includes Junio's
> suggestions to fix the alignment for continuation lines and case bodies.
>
> The subsequent patch addresses the function definitions.

Looks good; thanks.
