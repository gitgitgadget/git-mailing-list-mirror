Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2BAF1F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 03:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfKPDFx (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 22:05:53 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55781 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfKPDFw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 22:05:52 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AA7E098CCC;
        Fri, 15 Nov 2019 22:05:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ct0g6BDNHUYM37WI7EmhbWy3cIs=; b=r7BxVZ
        olPBOtoVXdszU2pYxrbfX0p7kaEquUhWifl+VVDczK4KkkU7QvaH2DZCUmrtnx9d
        hguk7tCU+ZTFMaZ3WJkfkVdXEgNSEi4CXR2Kv8GNTDbnGOw4ypEXR865AvqdMA1b
        x/SEnOLXPgVoxY2pwUUczfagkvlJ7isW+PEEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SrlZPHGSZbG1BvnYu+j/IAEg5XM/4oME
        fR0Z1MAWNW7hB53rFTpo+iffCMgpGEcUH3FHu5iqEuA58sRGZWFQeiYmodfCmHY9
        qnoRI/UCTZwQOEeNNEVLYMuFKlhoSQw2pGVeMrOyMN+5SnHqkuY2HaTj41Kw7Rw7
        KfdL2cI4CLg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9644A98CCB;
        Fri, 15 Nov 2019 22:05:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B3DAC98CCA;
        Fri, 15 Nov 2019 22:05:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] MyFirstContribution: add avenues for getting help
References: <20191115230637.76877-1-emilyshaffer@google.com>
Date:   Sat, 16 Nov 2019 12:05:45 +0900
In-Reply-To: <20191115230637.76877-1-emilyshaffer@google.com> (Emily Shaffer's
        message of "Fri, 15 Nov 2019 15:06:37 -0800")
Message-ID: <xmqqv9rk4j1y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FCDAFE5E-081D-11EA-AE9C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +[[getting-help]]
> +=== Getting Help
> +
> +If you get stuck, you can seek help in the following places.

Is this list meant to be an exhaustive list of authoritative
sources?  IOW, are we reasonably sure that some of us would be
around and give useful help, and that we do not mind readers to
consider these places "officially endorsed by the project"?

Or is this meant to be a list of reasonably well-known places, but
may include places where the project does not want to be associated
with the quality of answers given there?  

I am (implicitly) assuming that it is the former, but I think it is
better to clarify what this "list of places" is meant to be.

I notice that stack overflow is missing in this list.  Intended?
Not that I visit there at all nor I would recommend it, but I recall
seeing questions asked by more than a few people after getting bad
pieces of advice there.

> +==== https://public-inbox.org/git[git@vger.kernel.org]
> +
> +This is the main Git project mailing list where code reviews, version
> +announcements, design discussions, and more take place. If you fail to receive
> +help via the channels above, you can ask your question here. The Git list
> +requires plain-text-only emails and prefers inline and bottom-posting when
> +replying to mail; you will be CC'd in all replies to you. Optionally, you can
> +subscribe to the list by sending an email to majordomo@vger.kernel.org with
> +"subscribe git" in the body.

Sounds good; I agree with Denton, especially with the mention of
"you must join" on the other mailing list, that it is a good idea to
explicitly say that subscription is optional in this entry.

You can ask questions even if you haven't tried other avenues and
failed, but this entry makes it sound as if an earlier failure
elsewhere is a prerequisite for asking for help here.


Thanks.
