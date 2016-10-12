Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 223EC215F6
	for <e@80x24.org>; Wed, 12 Oct 2016 20:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934302AbcJLUx6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 16:53:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62021 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934111AbcJLUx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 16:53:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1D2745E9B;
        Wed, 12 Oct 2016 16:53:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tqc9lahQz0FstBsqoHu7pCxoS1k=; b=C651wp
        IlUrrZ1rA/3nNVmw+6tJgY3o5GKZSumM8EuX1FK2ZX0/ooYbJbsN2PlMxm4f2978
        Xugi+D9f2CwdFtBFiyeHGEDz54vecKHeHtJakVfElUpCjVnzo5RxodKWDFda6eOa
        hw/GbOhVEOJo+LEYSwr0/Kj8E62P86GIIa7kM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JURIgD5yjdNcpuxnvAQEoKemXIhpafmA
        t1jzddjC7SrbCoL+L7mYS6Ul4uOCsn91ZKbwuPY5CaRchblm5YIykzFYmBdOLUE3
        rx+8OpooZq4J2vSifZHTU822vLrEQYji4e0Nl26L54HSi3cuW2sNRZBAhLinwLbz
        GtfAbIhKjVs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A60645E99;
        Wed, 12 Oct 2016 16:53:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 13B1B45E97;
        Wed, 12 Oct 2016 16:53:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Jeff King <peff@peff.net>,
        Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
        git@vger.kernel.org
Subject: Re: Formatting problem send_mail in version 2.10.0
References: <41164484-309b-bfff-ddbb-55153495d41a@lwfinger.net>
        <20161010214856.fobd3jgsv2cnscs3@sigill.intra.peff.net>
        <20161010215711.oqnoiz7qfmxm27cr@sigill.intra.peff.net>
        <vpqfuo3l4fl.fsf@anie.imag.fr>
        <45cfc4e5-c30e-19cb-ec3e-407ceb4e3ad5@lwfinger.net>
        <vpq4m4iamfs.fsf@anie.imag.fr>
        <b8f93bf9-bfa5-2405-437e-6bf9abf77c87@lwfinger.net>
        <vpq60oy589b.fsf@anie.imag.fr>
        <5978b674-02eb-59ad-9468-93203533575f@lwfinger.net>
        <vpq8tttr2ps.fsf@anie.imag.fr>
Date:   Wed, 12 Oct 2016 13:53:52 -0700
In-Reply-To: <vpq8tttr2ps.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
        12 Oct 2016 17:45:03 +0200")
Message-ID: <xmqqtwch2srj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD23D154-90BD-11E6-AE0E-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>>> If it's not in the body of the message, then where is it?
>>
>> This point is clarified in the thread
>> http://marc.info/?l=linux-wireless&m=147625930203434&w=2, which is
>> with my upstream maintainer.
>
> Which explicitly states that the syntax is not [$number], but # $number,
> right?

But I do not think that works, either.  Let's step back.

People write things like these

    Cc: Stable <stable@vger.kernel.org> # 4.8
    Cc: Stable <stable@vger.kernel.org> [4.8+]

in the trailer part in the body of the message.  Are these lines
meant to be usable if they appear as Cc: headers of an outgoing
piece of e-mail as-is?

That question has two subissues.

 * Are these RFC compliant?
 * Do real-world servers accept them?

I did a quick test with my e-mail provider, by sending a test
message with the above (with <stable@vger.kernel.org> replaced with
my address, of course) on Cc: and the answer to the second question
appears to be no.

When I send the former, I get this:

    550 5.1.1 <4.8>: Recipient address rejected: User unknown...'
    errormsg='recipient address 4.8 not accepted by the server'

The latter gives me this:

    550 5.1.1 <[4.8+]>: Recipient address rejected: User unknown...'
    errormsg='recipient address 4.8 not accepted by the server'

So even if these were accepted by some servers, it is not sane
to assume that these lines are meant to be copied to Cc: headers
when sending out.  "send-email --cc" needs to salvage these
malformed lines.

For me, it seems that I get correct envelope rcpt-to addresses for
both of them (i.e. "stable@vger.kernel.org" and nothing else appears
on the command line of sendmail invocation), even though I seem to
get a strange Cc: that are visible to humans:

    Cc: "Stable # 4 . 8" <stable@vger.kernel.org>,
        "Stable [4.8+]" <stable@vger.kernel.org>

I seem to have libmailtools-perl 2.12 on my system.

Just like Peff who tried to disable Mail::Address, it seems that
I get complaint on both of them.

"error: unable to extract a valid address from:" is followed by

    Stable <stable@vger.kernel.org#4.8>
    Stable <stable@vger.kernel.org[4.8+]>

which is not ideal.

If I were to issue a decree, I would say that people should stop
suggesting to put RFC-bogus things on the Cc: line.  As you
mentioned, things like:

    Cc: Stable (4.8+) <stable@vger.kernel.org>
    Cc: "Stable 4.8+" <stable@vger.kernel.org>

are perfectly readable alternative that are still RFC-kosher.

Things may have appeared to work by accident, and things may still
work by accident, depending on the vintage and availability of
Mail::Address package (which seems to be the case), but it is not
worth risking random breakages that depends on what other people
use in the first place, no?

That is, even though people seem to expect "send-email --cc" to
somehow be able to judge that " # 4.8" and " [4.8+]" are cruft not
meant as part of a valid address, I do not think it is a realistic
expectation.  How would it know "Cc: Stable <add@re.ss> 4.8, 4.9"
has garbage " 4.8, 4.9" that needs to be stripped, while "Cc: Stable
<add@re.ss> 4.8, torvalds@linux-foundation.org" has two valid
addresses that need to be CC'ed and " 4.8" is the only thing that is
unwanted?

I'd welcome to be proven wrong with a working patch that makes
"send-email --cc" to be hyper intelligent ;-), though.

