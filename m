Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B58520899
	for <e@80x24.org>; Wed,  2 Aug 2017 16:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752164AbdHBQ2w (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 12:28:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65068 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752146AbdHBQ2v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 12:28:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 25BA29B3AA;
        Wed,  2 Aug 2017 12:28:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5rvXbCNwh9W6xr51R8wHJBDqGz4=; b=Tu/8TX
        hKz7Exq0ofCHmDvs6TFWIfh+hhwa6FLARPC3/VyaqGlgyXe6fPg8cC6aV71qRMz4
        fqX+kw5eMxHMr3+PPRX1acIoCiUicbiYOQOuTq9VHweOijhLSKf9MUlol9fipLZU
        BDxw6kl2r1359DujHXgAyVkWGrCG/fR6j45hE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lVUhH5apYYYyhnzCVhhCXNJr1Zh5tHUV
        pvreEsgalgfFbCIAFWJBTIfVdX1pw2dExomocWn7KIXN6OxtA8SjchKQCq+BPpS7
        eZ26EIml71HxHQZ6QDNV93e+zCGQznt3HNqjxLPRwD1oeutXXg7qekaGMkcQ4TTa
        GLRekoNzDk4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C90D9B3A9;
        Wed,  2 Aug 2017 12:28:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 858449B3A6;
        Wed,  2 Aug 2017 12:28:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] doc: add another way to identify if a patch has been merged
References: <CAGZ79kYg9jQ3kaKnNEJCH9fde=ar1KPiUr7=X+TguNc0Twqdzg@mail.gmail.com>
        <20170801160539.5587-1-kaarticsivaraam91196@gmail.com>
        <20170801160539.5587-2-kaarticsivaraam91196@gmail.com>
        <CAGZ79kZgV1=2HcYeXyoCy2Jk6v__trvTh_-rH+kbFX7fgWziyw@mail.gmail.com>
        <1501677122.1957.8.camel@gmail.com>
        <xmqqini6dkmu.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 02 Aug 2017 09:28:49 -0700
In-Reply-To: <xmqqini6dkmu.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 02 Aug 2017 09:01:13 -0700")
Message-ID: <xmqq60e6djcu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AAB55950-779F-11E7-BA41-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I think the exchange Stefan cited was an example that we want to
> have more of.  The contributor is indicating that, even though the
> patch could be a drive-by patch by one-timer from whom we will never
> hear again, it is not--the contributor is willing to learn the way
> things are done here, and showing that it is worth _our_ time to
> explain the things so that the future patches will take less effort
> to accept on our side.
>
> Because we do not have a group of dedicated volunteers, it is done
> by more experienced people around here but that can be done only
> when they have time.  I view it as a more severe problem than any
> documentation.  An abbreviated version of the documentation to
> invite more new people means that we must be prepared to give more
> high-touch onboarding help to them.

Just to make sure there is no misunderstanding, I am not saying "do
not update the doc to have an abbreviated version, because we will
get more clueless newbies".  I am saying that it is not a good idea
to add an abbreviated version _before_ we are prepared to handle
more patches from new people that require high-touch help.

If you are volunteering to coordinate and form the onboarding
helpers group, that would be great.

Thanks.
