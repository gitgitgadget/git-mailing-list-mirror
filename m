Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85AB61FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 15:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866AbcHQPdP (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 11:33:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65285 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752829AbcHQPdN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 11:33:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 867AC35ACB;
	Wed, 17 Aug 2016 11:33:12 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fZ5kO+X/qL5v
	C7e8azJlpsFTssI=; b=oHCw3jAl5iZnCdIwsqkyEOlWBqaR0FBbzTW11OzEZZQk
	dnqei9D4zNQOJCqginKO0z9Q0lbZf5VkbqLXWVhqsV5ss0uA1YcRDA7baYpHb0EV
	OGwNGp4TttOfvjV5AUlMhS0hDC1uWDb5XSyrP2K+1PIF3htAV9p7ycLVKi3Bpso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vPoAUb
	Lc0x05D6vQbdHxKIxLiEX8ISzEfi3UZ4Lv9y/NxtIYPjDLEvJoiCOCxAMQcsweJK
	kC0D4Jo85BjLjh2d/QA65tj8aW2JspSiTO/UCtqa40RLmCet+yQz/0s4cSk/8vYl
	lmwquQy6pcahMsFaDcDJtRnTtozZztZDFWtDk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F4F835ACA;
	Wed, 17 Aug 2016 11:33:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0A52C35AC9;
	Wed, 17 Aug 2016 11:33:11 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:	git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.10.0-rc0
References: <xmqqfuq7j7cw.fsf@gitster.mtv.corp.google.com>
	<bb0e4f6b-a85a-550e-a971-2a9fabb2f87f@web.de>
	<xmqqoa4uhwcn.fsf@gitster.mtv.corp.google.com>
	<20160817064245.GA5775@tb-raspi>
Date:	Wed, 17 Aug 2016 08:33:10 -0700
In-Reply-To: <20160817064245.GA5775@tb-raspi> ("Torsten =?utf-8?Q?B=C3=B6g?=
 =?utf-8?Q?ershausen=22's?=
	message of "Wed, 17 Aug 2016 06:42:45 +0000")
Message-ID: <xmqq60qzbebt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E838E680-648F-11E6-87D7-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Is this `text=3Dauto` correct ?

Thanks for spotting a typo.  Definitely.

> I think it should be
>
>    used to have the same effect as
>    $ echo "* text eol=3Dcrlf" >.gitattributes

Thanks.

> # In other words, the `auto` was ignored, as explained here:
> +   $ git config core.eol crlf
> +   i.e. declaring all files are text; the combination now is
> +   equivalent to doing
> +   $ git config core.autocrlf true
> +
