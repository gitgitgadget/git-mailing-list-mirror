Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5783E1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 21:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758214AbcHCVfT (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 17:35:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63009 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755188AbcHCVfR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 17:35:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 597F831623;
	Wed,  3 Aug 2016 17:28:20 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pXLvzYKw7CDU8s1kCsauywfMls4=; b=r1Nr6M
	iXKmis1PneCZYZuWwi/X+jB8NgXfnC3JPzKIZT8Lw5GvFwoz5Z51RxPrfAUAH32B
	BcpL0TFxLq61sg+8JuAs8XtgRXV5YS6yVgBsyhDVPm7ZhFnGFfhJitC6QkmbiXqc
	j3CVWAYcWdY4pGChKgjT+NvzWEekNxUEAcA4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JJXUPr179aKb6xPUmd3t5qu0PYl5dY+o
	mAAVwUJ9c8djamMoQXMPaHC103aIVIBqxa8Hn7hkMwHloHggKV9hNLwp4TYPcjMR
	hj/RhMNFVOVyAKSsgihE65GHxfQ/+pQ/z9jdAPqwdWFXLIcWGIWV9ugaajh+clyU
	FP8J8QbVr+A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 51A0531622;
	Wed,  3 Aug 2016 17:28:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CF6BC3161B;
	Wed,  3 Aug 2016 17:28:19 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff Hostetler <git@jeffhostetler.com>
Cc:	git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 1/8] status: rename long-format print routines
References: <1470147137-17498-1-git-send-email-git@jeffhostetler.com>
	<1470147137-17498-2-git-send-email-git@jeffhostetler.com>
Date:	Wed, 03 Aug 2016 14:28:17 -0700
In-Reply-To: <1470147137-17498-2-git-send-email-git@jeffhostetler.com> (Jeff
	Hostetler's message of "Tue, 2 Aug 2016 10:12:10 -0400")
Message-ID: <xmqqvazh7dam.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32E1DFA4-59C1-11E6-88C7-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Renamed the various wt_status_print*() routines to be
> wt_longstatus_print*() to make it clear that these
> routines are only concerned with the normal/long
> status output.

We tend to write "Rename the various...", as if you the patch author
is giving an order to "become so" to the codebase, or "make it so"
to the maintainer.

Other than that, this step looks straight-forward, and I agree with
the hope that this will reduce confusion that readers may have while
reading a future version of this code.

> This will hopefully reduce confusion as other status
> formats are added in the future.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Jeff Hostetler <git@jeffhostetler.com>

Hmm, are these physically the same people?  If so, which one do you
want to be known as?

Thanks.
