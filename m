Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A4E01F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 17:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbcHCRew (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 13:34:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50928 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755698AbcHCRev (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 13:34:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E87552E14D;
	Wed,  3 Aug 2016 13:18:43 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9YCVZZN4SxY6k5vZ60Vch7kxLas=; b=WD7EjU
	Wc4cQeWELXTH4Gn+xf1W2EfzaLVcrZXPVie6w7c+W1+j81DjsNmk2Lyb0Dmlt9VN
	uBKMU/EJedSiVzlq7YfIGmcu5pXFxNQbs5NWdoS61u9FFUM1fccGbgih8xyVIm+g
	8I5ydWdkXRpJx+wErlsb/71S4KhhDL+TvGja8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ldbu2VTGJRtpFJb+/zRDOSCZR2KxcikJ
	cMRFRAD/4yFqrkateOX4mw2ODIg0X9gcKTlHmW2HiVrt7AqtSxs5gX+qfYJVhjJw
	bSP1F64lbCz99ji8ARouSKz4fk03ZtW14iTSylCMf7V9DeyH+uzdVgWk3wFvYaZF
	raiTWu5Hpa8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E05112E14C;
	Wed,  3 Aug 2016 13:18:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 69C1F2E14A;
	Wed,  3 Aug 2016 13:18:43 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Santiago Torres <santiago@nyu.edu>, Git <git@vger.kernel.org>
Subject: Re: [OT] USENIX paper on Git
References: <20160801224043.4qmf56pmv27riq4i@LykOS.localdomain>
	<20160803145830.uwssj4uhqfemhr4o@LykOS.localdomain>
	<20160803171124.yzm5xs67empuka7o@sigill.intra.peff.net>
Date:	Wed, 03 Aug 2016 10:18:41 -0700
In-Reply-To: <20160803171124.yzm5xs67empuka7o@sigill.intra.peff.net> (Jeff
	King's message of "Wed, 3 Aug 2016 13:11:24 -0400")
Message-ID: <xmqq37mlahzi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 543E3242-599E-11E6-96BB-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here are my comments on the work itself. They're critical, but meant in
> a friendly way. :)

A tl;dr version of your analysis seems to me that "you solve it the
same way as the push certificate solves it (including the limitation
the latter has)".

If that is the case, I think the solution presented in the paper is
a good one ;-).
