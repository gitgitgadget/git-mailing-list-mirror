Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E89C52018A
	for <e@80x24.org>; Tue, 28 Jun 2016 22:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbcF1WMX (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 18:12:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50203 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752508AbcF1WMW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 18:12:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9374C27102;
	Tue, 28 Jun 2016 18:11:15 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nA4FBTuVxFKsObB8qHwCmSfe43w=; b=O5hNxY
	WxXvsG8xhaPKWp0h9CBYt057ISVQvBHkzbBS26D6TAcXP9OWyOtucPzNWaYAqCk7
	H39imXP/huzDQT4D+Ap+A/YmjqaeXamvkBqk46/D2asVUSZ2oShdCsanStAiFQJC
	wIb0We9cfa7eU5juVFeDHUoTDoVcSDr/lx7RI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EXZFdYQf6toYwi7X/+eyCvM9dd0j53Zj
	5b/xi0uQCt3vTmmISvB9VaW+M54wvq+MT/pLMsxjFRU/3490TpvDKVa4M8cUERaw
	WTq0fjy14qQDkgmF0x976WgLKz/nOCzO4fW1FmwzHLOVufk74QcB8TzrGCH0y67h
	3ypzuE3F0z4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A72927101;
	Tue, 28 Jun 2016 18:11:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0FAC827100;
	Tue, 28 Jun 2016 18:11:14 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, Jeff King <peff@peff.net>,
	sschuberth@gmail.com
Subject: Re: [PATCH v2 0/2] Config conditional include
References: <20160626070617.30211-1-pclouds@gmail.com>
	<20160628172641.26381-1-pclouds@gmail.com>
Date:	Tue, 28 Jun 2016 15:11:13 -0700
In-Reply-To: <20160628172641.26381-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Tue, 28 Jun 2016 19:26:39 +0200")
Message-ID: <xmqqk2h96k1q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3AF5569A-3D7D-11E6-AF20-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Honestly, I'd really prefer to see those with topics in 'pu' that
has seen reviews but not yet updated to go back to and polish them
to help move things forward, with the goal to have them in 'next'
sooner so that we can have fixes and features that are sufficiently
vetted and tested in the next release, before starting yet another
new topic that will be left hanging in 'pu'.

In your case, I am talking about nd/icase, nd/fetch-ref-summary, and
nd/connect-ssh-command-config topics.

Thanks.
