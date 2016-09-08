Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA5881F856
	for <e@80x24.org>; Thu,  8 Sep 2016 21:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754791AbcIHVYt (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 17:24:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61531 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751143AbcIHVYt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 17:24:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 945F93D23B;
        Thu,  8 Sep 2016 17:24:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LTwKKUO8d1ZrDf8jfy3ZMO1BrtY=; b=j3QwKJ
        +knYukYUq6cZrtC51zeZmviHv0DHekIGldI/S7jaSr4BqbI8Uk0kITZMYHz5a9wO
        Uk4aOcbgdFOr+0/U0T5hUitoJSM8hzBRYOsGRsG2+9CKsMexsZnY+/UDfPDweCQ4
        ELUj49/EBJP1gMEwRjjcqY9DFj+nAzXm0IKvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tk+S02fuPsUOsWd/9JHs1Q4G7AIZKAdZ
        FuB3vJqUtIRx4Hh7rUU1Pw8RxLRM16XxTq7OuoY2gtEcVXj61ZCmbLdrOWQuJE3z
        4PWShyPP6rZ44WOpO0nEBGQOgbNFzM4b5Q6Hhu8hOXMFa8jCfdB4Tr5ZmLh5R9gR
        j/ouR/BzqYo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C16C3D23A;
        Thu,  8 Sep 2016 17:24:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C91073D239;
        Thu,  8 Sep 2016 17:24:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
Subject: Re: [PATCH] Move format-patch base commit and prerequisites before email signature
References: <20160908011200.qzvbdt4wjwiji4h5@x>
        <xmqqshtags0o.fsf@gitster.mtv.corp.google.com>
        <20160908185408.5qtfnztjbastlrtw@x>
        <20160908200819.pkg7jqcvxjpdqr3a@sigill.intra.peff.net>
Date:   Thu, 08 Sep 2016 14:24:42 -0700
In-Reply-To: <20160908200819.pkg7jqcvxjpdqr3a@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 8 Sep 2016 16:08:20 -0400")
Message-ID: <xmqqd1kef5k5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AAC83364-760A-11E6-AFE5-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Sep 08, 2016 at 11:54:08AM -0700, Josh Triplett wrote:
>
>> > your problem description
>> > looks perfect.  I am still not sure if the code does a reasonable
>> > thing in MIME case, though.
>> 
>> It *looks* correct to me.
> 
> Hmm. It looks correct to me, too; ...
> ...
> So this is actually fixing a bug,...

Yes, I actually wanted to hear that from Josh and have that in the
proposed log message ;-).
