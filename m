Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B1E81FF6D
	for <e@80x24.org>; Thu, 15 Dec 2016 17:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755242AbcLORgu (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 12:36:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59737 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753077AbcLORgs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 12:36:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CA7D57357;
        Thu, 15 Dec 2016 12:36:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x5Hb5TM/HxrcBuZVIgwWzavfY04=; b=goWQ53
        qh7/woRm5KWoCDcWUSysrFcbodbiKk2mOGuKqW06kkcpCmD1FWbKroWia4jDum4P
        tGezoVGah3ZdFXtr4scluiRg8O8HdLnrTgu829v1lZeEbXWEo+p110IL/Wn0trLW
        t0qc2oB3M/sU46G9WKiZYET4JCcWqUqSvHXkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nP5U2ggj0uXXNxTrHoNVQqLKV6GaRBQd
        Bz0vTBR7MTQx25cNCj7TffeCI80psNxWgnrKs5rxcwh/05S0FJ4JUTGLZzur28/G
        CeCX6647OmueqiNImCWJpymbI+j7L/AKUM0avRKWaSxrUGLF3fmlNsoWhHV+c002
        X6kAej5zpeg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62F8E57356;
        Thu, 15 Dec 2016 12:36:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D98D257353;
        Thu, 15 Dec 2016 12:36:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Packham <judge.packham@gmail.com>
Cc:     GIT <git@vger.kernel.org>, Markus Hitter <mah@jump-ing.de>,
        Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCHv3 1/3] merge: Add '--continue' option as a synonym for 'git commit'
References: <20161213084859.13426-1-judge.packham@gmail.com>
        <20161214083757.26412-1-judge.packham@gmail.com>
        <xmqqk2b2xu81.fsf@gitster.mtv.corp.google.com>
        <CAFOYHZD_mFMvggq4pedjGCz332i1-VcRKxu30iMzURfB3Mu8Vg@mail.gmail.com>
Date:   Thu, 15 Dec 2016 09:36:17 -0800
In-Reply-To: <CAFOYHZD_mFMvggq4pedjGCz332i1-VcRKxu30iMzURfB3Mu8Vg@mail.gmail.com>
        (Chris Packham's message of "Thu, 15 Dec 2016 20:29:21 +1300")
Message-ID: <xmqqd1gtw0vi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FCB37830-C2EC-11E6-8713-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Packham <judge.packham@gmail.com> writes:

> On Thu, Dec 15, 2016 at 7:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> The last one 3/3 is a nice touch that makes sure that we do not
>> forget what we discovered during the discussion.  Very much
>> appreciated.
>>
>> Will queue.  Thanks.
>
> Did you want me to send a v4 to mark the strings for translation or
> will you apply a fixup your end?

I didn't follow the _() discussion (was there any?)

I do not think lack of _() is a show-stopper and my preference is to
keep what I queued that does not have _(), and receive a separate
follow-up patch that changes "msg" to _("msg") and does nothing
else.

Thanks.
