Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D1311F621
	for <e@80x24.org>; Wed, 27 Jul 2016 20:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758494AbcG0URz (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 16:17:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60483 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758470AbcG0URx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 16:17:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6565D30316;
	Wed, 27 Jul 2016 16:17:52 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6zSq71qQjcUQzjcVJBREJfCFKus=; b=WGGgKJ
	2qvbreChjclhjPw5RPsZowTy76H127dPDPUVGNMUb1tWZYUFo/o/QyjhquIs+k3R
	YIuJJJreH+lICBHXA843WNUJaCDbabgvKiIdsCGDd8joSf9ss1e/ZqEEuMXHoHyF
	1IN6JoFEftFbeQNPcjE2ErbWB5RddExLqKjNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xgsQ3BQ6Pnbg5VWQccwjFI/1UOot75zB
	tlLKGNusLm7e2nv/Q0v78KfKppmOwNZMss/NAePvnZhx+MEEGa2nAqG6sNG+EIe3
	LIYfQLuFrhbTj+jMu4q+hpwYM/8rStXEJvJIAro5wA3JTB5ZLOc9piAbXxRNpsWh
	Hital7CN6vs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BC6230315;
	Wed, 27 Jul 2016 16:17:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF11930312;
	Wed, 27 Jul 2016 16:17:51 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v3 5/6] date: document and test "raw-local" mode
References: <20160722195105.GA19542@sigill.intra.peff.net>
	<20160722195144.GE19648@sigill.intra.peff.net>
	<579343C9.1040902@gmail.com>
	<20160726184746.GA678@sigill.intra.peff.net>
	<5798AA7C.6050107@gmail.com>
	<20160727134441.GB14928@sigill.intra.peff.net>
	<xmqq37mux3mz.fsf@gitster.mtv.corp.google.com>
	<20160727195703.GA8141@sigill.intra.peff.net>
	<xmqqtwfavo21.fsf@gitster.mtv.corp.google.com>
	<20160727201651.GA26984@sigill.intra.peff.net>
Date:	Wed, 27 Jul 2016 13:17:49 -0700
In-Reply-To: <20160727201651.GA26984@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 27 Jul 2016 16:16:52 -0400")
Message-ID: <xmqqpopyvnrm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 31DE1CBA-5437-11E6-8017-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do find this by itself a little hard to parse. Maybe:
>
>   `--date=raw` shows the date as seconds since the epoch (1970-01-01
>   00:00:00 UTC), followed by a space, and then the timezone as an offset
>   from UTC (a `+` or `-` with four digits; the first two are hours, and
>   the second two are minutes). I.e., as if the timestamp were formatted
>   with `strftime("%s %z")`).

I also had trouble with what I wrote.  Thanks for a great help.

