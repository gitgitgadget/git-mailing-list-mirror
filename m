Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ACD61FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 17:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755080AbcFPRzZ (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 13:55:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52369 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754602AbcFPRzY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 13:55:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E586F25190;
	Thu, 16 Jun 2016 13:55:22 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ocAW6bXtkNT93OwXtBfSbBJNupM=; b=NmsoUc
	7ebtJ4/YceKor9RfEN7fSH/3vvAIw3IqSxgnwOqUI1OB9lH1Ise+S1hiegLdL5DV
	z1UJblbyIvkPpwiEc60kQoooZ+ip0agNQb1fUDwIktQ3nFBHKF+UXVsdNR4GQrMo
	rO48QRQhWwqFjiiZz9MU0cS+Ej0mCmOykki6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rVix2PWdA+6FvGKv654OPqYejLdjD+DW
	sl1SDuo3x1B9gV2n+51qb5y4Ce2jy4j/ecZtDyONZ4ncL0DdaE1t1Bc/QEN7n/Do
	dFBb/dNX/qDzDimUz0Aep9hCgH7UUGKzFC2+ahw5lVzgfHJ3io7fraHZ3TdnIn14
	kMPAPseYaas=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DD70F2518F;
	Thu, 16 Jun 2016 13:55:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6C34F2518E;
	Thu, 16 Jun 2016 13:55:22 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 0/2] friendlier handling of overflows in archive-tar
References: <20160616043523.GA13615@sigill.intra.peff.net>
Date:	Thu, 16 Jun 2016 10:55:20 -0700
In-Reply-To: <20160616043523.GA13615@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 16 Jun 2016 00:35:23 -0400")
Message-ID: <xmqqfusd588n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F2067CE-33EB-11E6-A798-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Both patches looked good to me. Thanks.
