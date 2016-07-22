Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67F5D203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 19:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563AbcGVT2Y (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 15:28:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62292 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754168AbcGVT2X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 15:28:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 29FCD2C885;
	Fri, 22 Jul 2016 15:28:22 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JhngGq9lEtIyI0RvX1DGSn9q+f4=; b=afVItu
	j5JD6Grb+qAZyLXRtE5z583c6vhuqn9g8MLUc4sfVR+Jyx9eEq22ujg53VFmAUYA
	EgupWCuk+Nu9Rv7DgkiRQKxvVZ3UylIzYcJdTRdIPVXzqU/Tv4ftW1NcBQlFq4Yu
	KbM/imNwmScDsI7a1fpOxX8N09MZ0HJScfb8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nRYUI0jWqu1xsY+WID4Kt602FqEe+lwk
	NTP1+jIKBtJ6nuO9wtbZ+q2lQki2+zlmvBL92aqOeyaqqO3ZkiAzJiUVhDed4KEa
	mEIMg1eQ3NE7KaMEu227EwF8dHEJkg7KsIfpIRKNw19otDtQyTlage2yZIn1Az25
	3quvcv4Ld8E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 219092C884;
	Fri, 22 Jul 2016 15:28:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A16D02C883;
	Fri, 22 Jul 2016 15:28:21 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	git-for-windows <git-for-windows@googlegroups.com>
Subject: Re: [PATCH ew/daemon-socket-keepalive] Windows: add missing definition of ENOTSOCK
References: <28dbe3b0-7a16-1b87-3d59-b8c981fead7c@kdbg.org>
	<alpine.DEB.2.20.1607221020520.14111@virtualbox>
Date:	Fri, 22 Jul 2016 12:28:19 -0700
In-Reply-To: <alpine.DEB.2.20.1607221020520.14111@virtualbox> (Johannes
	Schindelin's message of "Fri, 22 Jul 2016 10:21:19 +0200 (CEST)")
Message-ID: <xmqqmvl9a2wc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7378D26C-5042-11E6-9386-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Hannes,
>
> On Thu, 21 Jul 2016, Johannes Sixt wrote:
>
>> The previous commit introduced the first use of ENOTSOCK. This macro is
>> not available on Windows. Define it as WSAENOTSOCK because that is the
>> corresponding error value reported by the Windows versions of socket
>> functions.
>
> Thanks for catching this early.

(is that an acked/reviewed-by?  it is OK if it is not).

Yeah, thanks, both.
