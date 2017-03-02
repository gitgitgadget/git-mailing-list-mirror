Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 568B01F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 18:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbdCBS6G (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 13:58:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60044 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751461AbdCBS6F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 13:58:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F3BAE8372A;
        Thu,  2 Mar 2017 13:03:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6G9HgdiBLUkx44+Tujeh03GSbns=; b=dDfS56
        Tu5THuP8GKiJwF2zLUhWJHPbbeQGPc0rrqoFi23rmfs0SrOg8ObtllaUFW7TZwDZ
        Z2x11lmKQVQJs+goHwmRyxbQPSbIteFScDxWy7oYuUDwCs44eA/0AATguYzT3G/l
        NfNmuZ1b0kF/T+cc9rosl+U9nk6p1yA5krGmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gHTacNul2cSd/kENr/UClVZYOvYOKssO
        ebqw/fKmEokd94HvFwc4JoKdVPMqHFk0TewW6FeCjSAzTyzBoeqRyMzkJrgMFyhz
        V9X7KbRBSg8ZqXm5+IZ9vTCdsYVIm+rvpVTOhyM76D0+bvij3Af+BsQF7UeH8Ox8
        8LDQ1ZjvvzM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EBE8883729;
        Thu,  2 Mar 2017 13:03:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C13C83728;
        Thu,  2 Mar 2017 13:03:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
References: <c76a133a57514a332828099d342c9763fd946bfa.1488309430.git.johannes.schindelin@gmx.de>
        <20170302105157.59791-1-larsxschneider@gmail.com>
        <alpine.DEB.2.20.1703021210170.3767@virtualbox>
        <CFA1C4B4-0FDA-424D-87A4-EEE1F9BB3712@gmail.com>
Date:   Thu, 02 Mar 2017 10:03:31 -0800
In-Reply-To: <CFA1C4B4-0FDA-424D-87A4-EEE1F9BB3712@gmail.com> (Lars
        Schneider's message of "Thu, 2 Mar 2017 12:38:47 +0100")
Message-ID: <xmqqinnrd098.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C23A2EE-FF72-11E6-BE69-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 02 Mar 2017, at 12:24, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> 
>> Hi Lars,
>> 
>> On Thu, 2 Mar 2017, Lars Schneider wrote:
>> 
>>> The patch looks good to me in general but I want to propose the following
>>> changes:
>> 
>> I know you are using your script to generate this mail, but I would have
>> liked to see v2 in the subject ;-)
>
> Yeah, sorry. I already had a "D'oh" moment *after* I saw the email in 
> my email client. Now I am wondering... is the next version v2 or v3 :D

Another question is which v3 people mean in the discussion, when you
and Dscho work on improvements at the same time and each post the
"next" version marked as "v3", and they comment on one of them?

Between "v2" and "v3", it would not make too much difference to the
readership, when it is clear that two people are working to produce
competing improvements without much coordination (i.e. lack of "ok,
I'll send a reroll marked as vX in a minite"--"ok, I'll wait and
comment on it" exchange).  People watching from the sideline know
"ah this is v3 from Lars which is the highest numbered one from him
on this topic".  As long as you do not mark your next one "v1",
you'd be OK ;-).
