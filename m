Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E8052018E
	for <e@80x24.org>; Fri,  5 Aug 2016 20:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423312AbcHEUyM (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 16:54:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51145 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760568AbcHEUyI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 16:54:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CA1F931A9B;
	Fri,  5 Aug 2016 16:54:06 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HAcfqmNwMXlX6wxXO+Op4KGnAdY=; b=tLDSCM
	ugBRSUMru1wlhgrEUWmeJVxPWhjW1vAtSKaB7UA5xyowBXpwSvHxHZsrWUcj8k8Q
	1umbJ1TTn+CPMfXnFQ0jAliYRsdsYs19DV9uN8+ZzTQQB6CRgFQ0V/I3Lym91A3B
	d2mfogdWKPdsuAEostab/pLfUUV91XBotCQrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sgWhuFQQxgE2H0XC2Y0sXNPgL7pRraQ7
	l/nTJQdbX62WICrifJtMrjlLZUsvgXFQhL+g6Pc0MT6YNF+UzN+gAC6/JkmQk6vW
	ep/D329C9axoJTnNAvAK1tDVRTlDhHOEJgAPQsRClTrzfBvKVXAoxUU6Z9o740xJ
	Mglc6A3nbOI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C0B5E31A9A;
	Fri,  5 Aug 2016 16:54:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4656C31A99;
	Fri,  5 Aug 2016 16:54:06 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, mst@redhat.com, Jens.Lehmann@web.de
Subject: Re: [PATCH 3/6] submodule--helper module-clone: allow multiple references
References: <20160804195159.7788-1-sbeller@google.com>
	<20160804195159.7788-4-sbeller@google.com>
Date:	Fri, 05 Aug 2016 13:54:04 -0700
In-Reply-To: <20160804195159.7788-4-sbeller@google.com> (Stefan Beller's
	message of "Thu, 4 Aug 2016 12:51:56 -0700")
Message-ID: <xmqqa8grvswj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BFB0A382-5B4E-11E6-B056-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Allow users to pass in multiple references, just as clone accepts multiple
> references as well.

As these are passed-thru to the underlying "git clone", this change
makes perfect sense to me.

Will queue.

