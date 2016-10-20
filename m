Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78A0B1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 22:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933640AbcJTWHu (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 18:07:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55596 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932469AbcJTWHt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 18:07:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5507048DA0;
        Thu, 20 Oct 2016 18:07:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s4bm3QpWJlZ0nfaAYYGTZ+kAzwM=; b=jyHX+l
        BpYzqH3qzy0qSSMzjhngmbH5NlJ1DAMXTISREwvdxEr8Pdx5ur+e/6M9wVjqF38d
        AeLA6jl3h+bcX+G5RcHm3sgA+GhMibfzDmEzlGT9ctZFpMGSa7mfCTztnn49K911
        x+wxyb0gzM4nd+gZxulNh7YvXKGBAmvSQXWL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W2/an1ChLqAk0rWxEBuDXX/0t6M35wSH
        FkqvooQqp7N51PX5hgV9ppoJzQi1dSR4d/5RecjZ0QXqrN27//LB8+t/i/WRz9gB
        mrBTtUZj4asVjjy1gyW5/43Zqx7TkqSbh14na6fvbn+yy0HzQmFvmBpkLQfrHmHD
        qnMt5F6uyPo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4CBB648D9F;
        Thu, 20 Oct 2016 18:07:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A1D8248D9C;
        Thu, 20 Oct 2016 18:07:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Fwd: New Defects reported by Coverity Scan for git
References: <580893d5a4736_4ed37b53181837@ss1435.mail>
        <CAGZ79kabVPhp0_z-e_4jJOFq+jzSE2SsgmFuY-2RUgrEviGKyA@mail.gmail.com>
        <xmqqshrqhpua.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYTwsWy+oxnPKghWKGLEaO9qWZbrQOOejeEBOe0c-o0Pg@mail.gmail.com>
        <20161020214213.juoxbspa7pba5vsi@sigill.intra.peff.net>
Date:   Thu, 20 Oct 2016 15:07:45 -0700
In-Reply-To: <20161020214213.juoxbspa7pba5vsi@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 20 Oct 2016 17:42:14 -0400")
Message-ID: <xmqqzilyeksu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A26EE960-9711-11E6-9887-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Oct 20, 2016 at 10:58:39AM -0700, Stefan Beller wrote:
>
>> > By the way, do you know who is managing the service on our end
>> > (e.g. approving new people to be "defect viewer")?
>> 
>> I do it most of the time, but I did not start managing it.
>> And I have been pretty lax/liberal about handing out rights to do stuff,
>> because I did not want to tip on anyone's toes giving to few rights
>> and thereby annoying them.
>
> I also do this, though I admit with more urgency when I recognize the
> name as somebody who has showed up on the git list.

Well, then huge thanks to both of you.
