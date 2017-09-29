Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD70B20A10
	for <e@80x24.org>; Fri, 29 Sep 2017 01:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbdI2Bxa (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 21:53:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60343 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751914AbdI2Bx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 21:53:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A672CAE1D4;
        Thu, 28 Sep 2017 21:53:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f8iFg5Ms0RSDkX8gfNWGiQ6zkXg=; b=xvmnel
        VLUmHVcaNRR99IfWgwS/8oK5+HFxxa3g3l3JhFYIoU7J3vmddQu8o9V+ah3be+PQ
        xn+qXSXYDgLPll2NiInH5hXdfLh+LGsEDhfnot5KTlhg/pPDeZHDfp94EiB5zdA3
        Gv2RM8+x/Kir03wDAZomqNMTYYY7JekVVuHhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S1geck/Vm4LzktINAaUQqVnUUEpMkpN3
        h3e+is3EWXaPTkaC05iXmPgGTh5YOggOBobUu6tmo0w8jLWPahIPQ6aeACPRfpGA
        ofsYasvhqt4IkWG+9FARwvXJOvFzM4n0jHT0/5EzApFexE+yLhfn/YHwxEVpqik5
        P+wN3OPFIR4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 99E2BAE1D3;
        Thu, 28 Sep 2017 21:53:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EF94DAE1D2;
        Thu, 28 Sep 2017 21:53:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
Subject: Re: [PATCH] doc: correct command formatting
References: <20170928140648.GC9439@dinwoodie.org>
        <70decbc2-093c-9f9a-3661-ee6500cec641@gmail.com>
        <20170928193412.GB174074@aiede.mtv.corp.google.com>
Date:   Fri, 29 Sep 2017 10:53:26 +0900
In-Reply-To: <20170928193412.GB174074@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Thu, 28 Sep 2017 12:34:12 -0700")
Message-ID: <xmqqk20iz2w9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FCC84EDC-A4B8-11E7-B775-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Andreas Heiduk wrote:
>
>> +1, Thanks for spotting.
>
> Thanks for looking it over.  Can we add your Reviewed-by?  (See [1]
> for what this means.)

I would just do "Acked-by: Andreas" after seeing such an obvious
admission of guilt & appreciation for fixing in the exchange.  

Would we rather want to make it more formal like how Linux folks do
the Reviewed-by: thing?


