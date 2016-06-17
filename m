Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8754F20179
	for <e@80x24.org>; Fri, 17 Jun 2016 18:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886AbcFQS0b (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 14:26:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60519 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753257AbcFQS03 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 14:26:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DDFE123553;
	Fri, 17 Jun 2016 14:26:27 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iwpe0RDNrwfFc/u8ZSrf2N/h5Pk=; b=ab993S
	LMzMnpGxG6NeAGYeIDX/53wELZg8nqTL4mai7bc19TMkaFsHZMUuxH0lNG1ArFCs
	4xnd8r5AdW997zjgV1lw+zX+WLBhSK843e0IU5V0n0oRP47A3kQzFlnkgAqhgxU/
	/vGmZxGB6D7kTkznAtb6VbE9W8tx4fevk7dbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t0S7ICkPTQ+HqP1gtXfBwYYVuSqd23YR
	dmCGscOh4VLDhVNDYHi/UiOJl8yp3ZmSnxOkDFjGNQMeDaLIO9ULJ8ozqfMu5DWY
	Ejj0GKi6rro9n75T5ezPQx8V/823K8QLb1FFTlBH9lB60Frynn45/8VaSHgTQx8f
	esHq+BHRCpQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D5E3123552;
	Fri, 17 Jun 2016 14:26:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D92F23550;
	Fri, 17 Jun 2016 14:26:27 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Joey Hess <id@joeyh.name>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 2/4] add smudge-to-file and clean-from-file filter configuration
References: <20160616203259.5886-1-joeyh@joeyh.name>
	<20160616203259.5886-3-joeyh@joeyh.name>
	<xmqqy4643ig1.fsf@gitster.mtv.corp.google.com>
	<20160617131311.GC24025@kitenet.net>
Date:	Fri, 17 Jun 2016 11:26:25 -0700
In-Reply-To: <20160617131311.GC24025@kitenet.net> (Joey Hess's message of
	"Fri, 17 Jun 2016 09:13:11 -0400")
Message-ID: <xmqq60t71xke.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01219496-34B9-11E6-81FA-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Joey Hess <id@joeyh.name> writes:

> Here's a revised version of the documentation that I think takes the other
> suggestions onboard. I emphasise that clean and smudge operate as filters,
> to contrast better with cleanFromFile and smudgeToFile not operating as
> regular stdio filters.
> ...
> This could be extended more, but I think this should describe the config
> settings concisely and point to the more involved discussion of filter drivers
> in gitattributes.

Yup.  This version I can agree with.

Thanks.
