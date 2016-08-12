Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCBD11F859
	for <e@80x24.org>; Fri, 12 Aug 2016 22:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbcHLWIi (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 18:08:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751372AbcHLWIi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 18:08:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BF4F3588C;
	Fri, 12 Aug 2016 18:08:37 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mLTbOggaisCaiLAHfuG6Pt3LeSw=; b=cCn0di
	Ma0TgtgKUIMEDOnGTvgld/Qe/9qSV+T4CX3XFwNWlL/fl5//b10nWlahFNUxO0Py
	dD3xjp3NMP2CaM6n15jcWm0mdMh/tKhYGz0t0Q/EHBpO3iEIYbmh4tRWvbC+zaML
	ZPFaKXZ2IAzIFxGABUiZ1ogkDs9voM9tY3sUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZSIQYDWCBynRCroFkN6wjs9H/KjW792f
	E3E9z+Kj4AlUDP3CI8xb1zq092OGOxZZ0zZ32A6P1eBc/sT/G5ocQzbRWa8B6INb
	BK2u4qADPROodyspCfpj/zGAUqjRkB5XPLR/SJc1fgrdoWn8eTZj+jGO4qf8rcAj
	Vq8DWI3OzBc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0400C3588B;
	Fri, 12 Aug 2016 18:08:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 83B4B3588A;
	Fri, 12 Aug 2016 18:08:36 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff Hostetler <git@jeffhostetler.com>
Cc:	git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v8 0/9] status: V2 porcelain status
References: <1471016692-35828-1-git-send-email-git@jeffhostetler.com>
Date:	Fri, 12 Aug 2016 15:08:34 -0700
In-Reply-To: <1471016692-35828-1-git-send-email-git@jeffhostetler.com> (Jeff
	Hostetler's message of "Fri, 12 Aug 2016 11:44:43 -0400")
Message-ID: <xmqqfuq9vdwd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 510F401A-60D9-11E6-A74E-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> This v8 patch series addresses the remaining feedback
> about the unit tests from the v6 and v7 series.

Thanks, will re-queue.

I didn't spot anything glaringly wrong in the last patch, and all
the ealier steps looked good in the previous round, so I think we
are getting there.
