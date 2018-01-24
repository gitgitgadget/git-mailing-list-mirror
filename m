Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C0E71F404
	for <e@80x24.org>; Wed, 24 Jan 2018 22:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932745AbeAXWBw (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 17:01:52 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59554 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbeAXWBv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 17:01:51 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B307CF130;
        Wed, 24 Jan 2018 17:01:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=zsA3epkjOWJ4CfYKw7dbu9P/Kv4=; b=iAGaXm6
        tOtaL88xbfJB4qqF+jM64Us1YtjcoYSYMxhXv4KQcL7EJc7YRLRNs8Kuf4xBJuD/
        RTyPUFT3eH68nG0UIrmahUS3VqZfmRmWUHRL7mKYQGnj8tRKOMCxzy5B5h8vvq4B
        gRisSGNyN922h1JJArVj+KcvB4VSySdYw3Ac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=KsJxdBdPYTnWNY3npBqz+O/Pj3apSYRJh
        hnkP9wuelZaVJxFaoMdJ7oDYSfCqBqIAX7GIHWMT8t4wetB21FRSnH5yRPAg01VY
        +J63X5R+FR06RByjBRGon8PfcYj2Xpl8S3d2ChhofNtLsh/HuJv1cSeNnW9wfDgZ
        Ei5782nsM4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02AA1CF12F;
        Wed, 24 Jan 2018 17:01:49 -0500 (EST)
Received: from zaya.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 444BECF12D;
        Wed, 24 Jan 2018 17:01:48 -0500 (EST)
Date:   Wed, 24 Jan 2018 17:01:46 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     randall.s.becker@rogers.com, git@vger.kernel.org,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v4 1/4] Add tar extract install options override in
 installation processing.
Message-ID: <20180124220146.GI1427@zaya.teonanacatl.net>
References: <20180121234203.13764-1-randall.s.becker@rogers.com>
 <20180121234203.13764-2-randall.s.becker@rogers.com>
 <xmqq607rdmka.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq607rdmka.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Pobox-Relay-ID: 2CAD472E-0152-11E8-A7BE-575F0C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> randall.s.becker@rogers.com writes:
>> +# Define TAR_EXTRACT_OPTIONS if you want to change the default behaviour
>> +# from xvf to something else during installation. The option only includes
           ^^^
Shouldn't this be xof?

>> +# "o" as xf are required.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Wisdom has two parts: (1) having a lot to say and (2) not saying it.

