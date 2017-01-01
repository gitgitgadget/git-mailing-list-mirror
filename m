Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86ACE20441
	for <e@80x24.org>; Sun,  1 Jan 2017 00:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754874AbdAAAza (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 19:55:30 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50709 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754861AbdAAAz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2016 19:55:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD3935D4E2;
        Sat, 31 Dec 2016 19:55:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vgmu88MdWDiBT3s/aN4OpffcHmY=; b=o6o/oI
        uMQ2m/L0S9e75W7K6Vk1wOq4VHzZW2Bvd27tzdpzGfRcs464zdy4eTUBGIxj1G4i
        p7JsTE01LLT8GM22b/7QCzvWsgtBZuUqrQ3asaS6BDkEEZhQg9c9+3iejebk7IFm
        7kAwGZJPf5gL+fDZxvLoco1UmRRhlwNl6+Io8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=duYH8wj0S0oSGi+Luu1zasM9lL4sLD/l
        zFk4N4JbbNXX93zI//3reMsOwLkvt4YKC+U8e1QWYUlm1WulJNtW4r6dQu8mkj5f
        uDeUs4uZ8u7WfPayZOsMBC6fg0rnXsY/wD38EUFZDJzCli+vA4SBxG1rK9H2Hgl2
        7TReQC0W2Fs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B50105D4E1;
        Sat, 31 Dec 2016 19:55:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2E8DC5D4DD;
        Sat, 31 Dec 2016 19:55:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        jvoss@altsci.com, "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: [PATCH] contrib: remove gitview
References: <20161228064255.f4akjdsq24r2hqn7@sigill.intra.peff.net>
        <20161228172837.24395-1-sbeller@google.com>
        <20161229015918.jyiqd42z4htjibul@sigill.intra.peff.net>
Date:   Sat, 31 Dec 2016 16:55:26 -0800
In-Reply-To: <20161229015918.jyiqd42z4htjibul@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 28 Dec 2016 20:59:19 -0500")
Message-ID: <xmqqlguv61kx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC1ED4D2-CFBC-11E6-B512-06F112518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Dec 28, 2016 at 09:28:37AM -0800, Stefan Beller wrote:
> ...
>>  2 files changed, 1362 deletions(-)
>>  delete mode 100755 contrib/gitview/gitview
>>  delete mode 100644 contrib/gitview/gitview.txt
>
> Thanks for assembling the patch. This seems reasonable to me, though I'd
> like to get an Ack from Aneesh if we can.

Likewise.
