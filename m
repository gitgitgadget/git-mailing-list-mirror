Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A082203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 16:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbcGYQQm (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 12:16:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55263 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751011AbcGYQQl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 12:16:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AF823029D;
	Mon, 25 Jul 2016 12:16:39 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WCeNCNuEok0Eix/v2sn3QTIyZyA=; b=hxIFyE
	xTw3GBb+4Q7yAorgFGRzwbwAiow/Kf2EmqtAhZVt3nuleX48wF+34n+mzp3gpiMW
	pDJUxTkMgs9u3EyLhyiGEvlVnh6ee+59EP7FCMrpltBuH32uWO9iwlkvGhrQMkul
	h/aJIa0OuVTW8yv4vMUmV5XV8f1dwjERcaKsw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tqT7Xp8PSGg1xL+R/T2Zrw1GDf2p7kZX
	Q2dU5BaO/MbQ3A3Bd/q3pX2Y/KHQnExYj/HrM6cKfYfSX45nHtNTfY6Tmg2LsDt1
	kA+ylTHTCtBlZ/mEvgdzMKV19Bq33SezbIpeJHYo6xVxv0pcSadx1yacZT9BUWKe
	toKMO9LASlM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 929F53029C;
	Mon, 25 Jul 2016 12:16:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 095A03029B;
	Mon, 25 Jul 2016 12:16:39 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Eric Sunshine <sunshine@sunshineco.com>
Cc:	Jeff King <peff@peff.net>,
	Richard Soderberg <rsoderberg@gmail.com>,
	Git List <git@vger.kernel.org>
Subject: Re: git-prompt.sh incompatible with non-basic global grep.patternType
References: <CAEvc1UQvXKtQCXvCmt-774A84--bkK-sb94BtFeqDDr0Gsf7qw@mail.gmail.com>
	<20160720134211.GA19359@sigill.intra.peff.net>
	<xmqqwpkgcbp9.fsf@gitster.mtv.corp.google.com>
	<20160720205207.GA578@sigill.intra.peff.net>
	<xmqqr3ala37o.fsf@gitster.mtv.corp.google.com>
	<CAPig+cSw2t36n3ir61BhcMbSVMYoTVrYwbyGVSPcLoGnwR4w2w@mail.gmail.com>
Date:	Mon, 25 Jul 2016 09:16:36 -0700
In-Reply-To: <CAPig+cSw2t36n3ir61BhcMbSVMYoTVrYwbyGVSPcLoGnwR4w2w@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 22 Jul 2016 19:28:22 -0400")
Message-ID: <xmqqshux7kwr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2AA6FBCA-5283-11E6-AC43-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> Later when the grep API was used in revision graversal machinery,
>
> s/graversal/traversal/

Thanks.
