Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52FC61FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 22:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbcFXW2M (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 18:28:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52114 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751019AbcFXW2L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 18:28:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DFB6A27F4C;
	Fri, 24 Jun 2016 18:28:09 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JvSBqIz1XoHzTtzKa4cJxIjBuCw=; b=Rp0w+p
	Ud9rXQ4xLeYAf7ndRWgPYsWbh3MKRArZuvpsTlX3OFTMOxCRQyn+Yjs+iL7Ombe1
	hPss8LnE3l+t2txBOfWg8EpqVqwBaynsZNAj/sxmEgmoAxUSrmSgWqH+FwVZS+JY
	+g41HVXQvK10eXNRGO6UcWU7OsJgi/Es5+fgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i0dr6p1Pc5ZrrnenyxQBE7a3p1GmWmvK
	XDSyUQOb0lm78GF1Hg+WgoN0ushgDG1LKZxnQaV+tCKRwx2QzM5vZZZp/CD2zSFk
	yJb/O3nU9BXb6Wu1eClw9tKqJbvjxPDZsAZkiwte7Cjk7+BT8ynvASz3y7l2yUX+
	7EbYgE2vHj0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D7D0327F4B;
	Fri, 24 Jun 2016 18:28:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C8C927F4A;
	Fri, 24 Jun 2016 18:28:09 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Vasco Almeida <vascomalmeida@sapo.pt>
Cc:	Alex Henrie <alexhenrie24@gmail.com>,
	diane.gasselin@ensimag.imag.fr, Matthieu.Moy@imag.fr,
	git@vger.kernel.org
Subject: Re: [PATCH] unpack-trees: fix English grammar in do-this-before-that messages
References: <20160624053135.7848-1-alexhenrie24@gmail.com>
	<576D1BEA.8020509@sapo.pt>
Date:	Fri, 24 Jun 2016 15:28:07 -0700
In-Reply-To: <576D1BEA.8020509@sapo.pt> (Vasco Almeida's message of "Fri, 24
	Jun 2016 11:39:22 +0000")
Message-ID: <xmqqoa6qdxxk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EDE2C9FC-3A5A-11E6-9867-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> The only downside I can tell about this is translator are going to have
> to update those strings on their translations, but that is a normal
> thing to do on an active project like Git.

A larger issue is this fails to update tests that check these
messages.

