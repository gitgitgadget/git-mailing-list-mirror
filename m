Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE4C01F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 17:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753004AbcI1R7K (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 13:59:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53181 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752625AbcI1R7J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 13:59:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2162B420E9;
        Wed, 28 Sep 2016 13:59:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+YXEtrVa7/EpTUDl8HkFoR6eny0=; b=lJCTDt
        mFiwoe4m3TCeh6s4BaDkMyxWWIskRfmVrbUk6xCUclAU4z19pivWw1vyPaG55q72
        BUBa1uhZhSZjxzQQyecvhRL3/OzV1/QmLVVUz/hZBh9Qm1Pvd73V/Wd0ZFbo1ZVq
        +EH1zEGCy1V3HPe9Hx4wN+7vxidIm63m2I1JY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D7LxVN1X70EV1sLFf/qAV36X3ZRoNq6Q
        g7ZfXDkof/uqYP2MSkuWGh2YZzDgKZ+f+iKDOjXZaZECc/LUjjRVc/l8VKj9YW8x
        7+k3AuCs3w333+q0d+eWBFA6/drhUVjlUHEzzEpMI4Jt4QSG9apkE9PewU8K0PAF
        x3CR9OqUaB4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 19C5D420E7;
        Wed, 28 Sep 2016 13:59:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 81962420E4;
        Wed, 28 Sep 2016 13:59:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric S. Raymond" <esr@thyrsus.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] docs/cvs-migration: mention cvsimport caveats
References: <20160922072350.ivjrfuedodd2rezn@sigill.intra.peff.net>
        <20160922072628.rs47hfiowtobw46s@sigill.intra.peff.net>
        <20160922131526.GB6320@thyrsus.com>
        <20160923035601.f5czdieouzvm3ptz@sigill.intra.peff.net>
        <20160928001108.GA9120@thyrsus.com>
Date:   Wed, 28 Sep 2016 10:59:05 -0700
In-Reply-To: <20160928001108.GA9120@thyrsus.com> (Eric S. Raymond's message of
        "Tue, 27 Sep 2016 20:11:08 -0400")
Message-ID: <xmqqlgybkis6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 404088FC-85A5-11E6-B5B5-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric S. Raymond" <esr@thyrsus.com> writes:

> Jeff King <peff@peff.net>:
>>               I am not qualified to write on the current state of
>> the art in CVS importing.
>
> I *am* qualified; cvs-fast-export has had a lot of work put into it by
> myself and others over the last five years.  Nobody else is really
> working this problem anymore, not much else than cvs2git is even left
> standing at this point.

It sounds like you, as a better qualified person, would be in the
best position to send an update to the documentation to tell people
not to use older and unmaintained ones and guides them instead to a
newer and better tool.

    ... ah, I notice that peff said the same already.

I'd be fine with reviewing and applying such a patch.

Thanks.
