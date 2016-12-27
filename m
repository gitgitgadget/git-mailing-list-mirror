Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98ABC1FF76
	for <e@80x24.org>; Tue, 27 Dec 2016 01:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755822AbcL0BOP (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 20:14:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61678 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751171AbcL0BOO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 20:14:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 142B85B442;
        Mon, 26 Dec 2016 20:13:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wfRJ+SDCBIAUTGs4/BYfsc+59RU=; b=VZkASO
        SF507uCbyiOIpY1K0zfpAVVj9sBsGlWCuyXMMTRRSxbbr0ewyoiDRR5dLllOjEop
        4fm81gfd1gb+Fh+R1903hLfWrhDNrT/krejiRXhHDt1w1Oz4gnnJ4eT797iF0S1n
        Rwpt7CjiJhCnxzsaOrPk9o73wGHGnSmqu4rak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FYCg4ThmHUiRkDE2vNqq/47Mb63P6aS2
        BX0xsH9Hp9JybporvsEZul37lrDBW+y1M8WZHeFYXgTyIDuApY7AqlWm0KhNZQLy
        XpWP2wNQh0xprohJFqmHKN4TF0rkWZdAliAUl3NTSsc0YrTvyOaRlvkcAnn7Hnzv
        cqT/p5cmIPM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BE895B441;
        Mon, 26 Dec 2016 20:13:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7ADE65B440;
        Mon, 26 Dec 2016 20:13:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, David.Turner@twosigma.com,
        sandals@crustytoothpaste.net, j6t@kdbg.org
Subject: Re: [PATCHv5 1/4] submodule.h: add extern keyword to functions
References: <20161220232012.15997-1-sbeller@google.com>
        <20161220232012.15997-2-sbeller@google.com>
Date:   Mon, 26 Dec 2016 17:13:53 -0800
In-Reply-To: <20161220232012.15997-2-sbeller@google.com> (Stefan Beller's
        message of "Tue, 20 Dec 2016 15:20:09 -0800")
Message-ID: <xmqqinq6cgxa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC10EFB8-CBD1-11E6-B58D-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> As the upcoming series will add a lot of functions to the submodule
> header, let's first make the header consistent to the rest of the project
> by adding the extern keyword to functions.

This may be the right thing to do in the longer term but a patch
like this adds a lot of unnecessary work on the integrator when
there are _other_ topics that are in flight.  I'll see how bad the
conflicts are while merging the topic to 'pu'.

Thanks.
