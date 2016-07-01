Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4F912018A
	for <e@80x24.org>; Fri,  1 Jul 2016 20:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbcGAUaS (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 16:30:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55698 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751992AbcGAUaR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 16:30:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9442C27D12;
	Fri,  1 Jul 2016 16:26:22 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oANDW+n8R3TVQ208dVmtilV2En4=; b=HvY5QI
	VabhN8cbtwkJtOXwLGVxdio7vc6V0C+HVsHvo2MyAU1XcIq2NaDOLofFPfuF3K8K
	f9RrXdNXP3mdWSBShVwZ2Pvhd6PM1jiN0J6yppdjSVxSIiRheS4i3Vc/pxVJ57e7
	zkJxs14/4woOuU2rnxWGn+YPUG61y5POzVJAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YUL+ja4+7QSbWIHy7iah38+gr+V1E9BA
	hE9bE+fTYPglt4fNxClo/9JSVxGHePOxOqITjueQRzTx8JlFNbURJ9q0y271xDcm
	0BnnixE21Ih0Lqles0OkzPfmZtNBKzzYg4/EcSvilJVSsHD4iJ82gopTGjVAKnMf
	zIqeLVrl/F8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D6F827D11;
	Fri,  1 Jul 2016 16:26:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 15BFC27D10;
	Fri,  1 Jul 2016 16:26:22 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Charles Bailey <charles@hashpling.org>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/3] Grepping with intent to add
References: <20160630101348.15665-1-charles@hashpling.org>
Date:	Fri, 01 Jul 2016 13:26:20 -0700
In-Reply-To: <20160630101348.15665-1-charles@hashpling.org> (Charles Bailey's
	message of "Thu, 30 Jun 2016 11:13:45 +0100")
Message-ID: <xmqqy45lw1eb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 134B1784-3FCA-11E6-B3E9-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Charles Bailey <charles@hashpling.org> writes:

> So I've got back around to this topic again.
>
> I've applied fixes to the tests as suggested by Eric and Junio.
>
> I came up with a test case that demonstrates a difference between the
> additional fix that Duy suggested and the alternative that Junio
> suggested.

Thanks, will queue.
