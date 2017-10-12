Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37D9C20437
	for <e@80x24.org>; Thu, 12 Oct 2017 11:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbdJLLK7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 07:10:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53304 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751350AbdJLLK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 07:10:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E6E997873;
        Thu, 12 Oct 2017 07:10:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r3v+7dmssgT+bQYuYxrGJ1gj6Ck=; b=nCGZV8
        nrsO67wbl4F9lhEKN+YoK7rRbrFiY8CuUxVyJBw3FJywk5hRITFzaTn9WWoqsRaO
        IWSeLDsK4jlGhFb5SBLp8npOk7Vj7OOnSG2H0qMtBdy6Nd2lH0+F7L3SZ8hXH7Ix
        qE28zWhqYy/Zo3BmlibZLovMoqY1zAHFlmK1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Shm+clWyZJWDTosz7lbJs5oLg8t4xgc/
        4ejM5xUNsXFapJxiv61VrKg1UQ/YovxKMzKfvAsqBMMwrrBANH7B5rw9ImkQaUhC
        Nk5edUfDcwUVINsAXMOo27C42OR0TN2675K6IOQXU1Le8kFkvWGRM2uOcRHC1SOR
        HAg1eugTZ8c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 046D797871;
        Thu, 12 Oct 2017 07:10:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7277897870;
        Thu, 12 Oct 2017 07:10:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     "W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>
Subject: Re: [PATCH] Documentation/merge-options.txt: Add -S/--gpg-sign
References: <406769a31421cb26a0e1bcf6e15bcf7ab48617c8.1507798709.git.wking@tremily.us>
        <20171012104459.GA31559@alpha.vpn.ikke.info>
        <20171012104622.GB31559@alpha.vpn.ikke.info>
Date:   Thu, 12 Oct 2017 20:10:56 +0900
In-Reply-To: <20171012104622.GB31559@alpha.vpn.ikke.info> (Kevin Daudt's
        message of "Thu, 12 Oct 2017 12:46:22 +0200")
Message-ID: <xmqq376ozkn3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0598DDEE-AF3E-11E7-B1D7-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

>> > --S[<keyid>]::
>> > ---gpg-sign[=<keyid>]::
>> 
>> Shouldn't the options self be removed here too, not just the
>> explanation?
>
> You can ignore this, it was just my mail client that colored the diff
> wrong, confusing me.
>
>> > -	GPG-sign the resulting merge commit. The `keyid` argument is
>> > -	optional and defaults to the committer identity; if specified,
>> ...

;-) Very understandable confusion.  Thanks for reading patches
  carefully.
  
