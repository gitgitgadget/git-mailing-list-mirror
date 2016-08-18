Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A56B21FD99
	for <e@80x24.org>; Thu, 18 Aug 2016 00:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510AbcHRASB (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 20:18:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53282 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753180AbcHRASB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 20:18:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C8843602C;
	Wed, 17 Aug 2016 20:17:59 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bn5nar5I3czkyYtDgWwzn8cq21k=; b=OMk0TB
	4o2Di26F0vvHMdhdvI1ukVI4BJ//DjBdqy3ZCrTzcYxMFYDWjxbZE/7eNb1UjzX1
	4tTEzJKTasw9OlAkmLoNcWBbti0uviuBOVoPrUinD2NOxHoBk48pgwRZYJM6wNRM
	0B74fm9KYmGzlQIWmd5AFKMx9Tyzyb/OEmlOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kxj4FQwmXrxizr/oAwq17bvDMBjIHW5d
	NvVlCgyAYdUyrO4j2j0ScLQ6QYsbzxMTc6Yp0eZIOBYWsHq5mWD6iOhvKUc4Ieto
	Ry8ePcTpQ3SUMvYzu4Hlt75NNW9k4LZvY0eH8+alQKkrBsnr6Eb2ktWRL2bDtoKu
	xUFRGCQQho0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 84F813602B;
	Wed, 17 Aug 2016 20:17:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 064C73602A;
	Wed, 17 Aug 2016 20:17:59 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de
Subject: Re: [PATCHv8 8/8] clone: recursive and reference option triggers submodule alternates
References: <20160817224535.5551-1-sbeller@google.com>
Date:	Wed, 17 Aug 2016 17:17:56 -0700
In-Reply-To: <20160817224535.5551-1-sbeller@google.com> (Stefan Beller's
	message of "Wed, 17 Aug 2016 15:45:35 -0700")
Message-ID: <xmqqziob6ibv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37F77A3A-64D9-11E6-9339-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>  and now with error handling of invalid options. 

Thanks.
