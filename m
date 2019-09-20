Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 330E41F463
	for <e@80x24.org>; Fri, 20 Sep 2019 18:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405712AbfITSwL (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 14:52:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65446 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405643AbfITSwL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 14:52:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4B138DA0B;
        Fri, 20 Sep 2019 14:52:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SCkLqXHMPQ0SKUWWAW/UrXYwT34=; b=lacvIT
        rd8879sl0Ace9Uk7ZwjvP1tKSTrP3nfUXPUnKvEY9qX6+SVMDrqsui523M5df0p8
        hWblB/OEJWclxfVVvmH6XKyRPlbWjvOefziMMt8FKpR4N7GVialhbVFxUxp4J/hD
        MBPy8SJqjn+q750QkfpUa7OtZxjocGW4d/qi8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yeYZddeJlWLodjOKACt6AZma8ScUNQFN
        JsihpIS+/pvTpQYQNjzfKpSTNtjc4j5P5S9akX10jW6q7y1K38Ve02Xus+J9fvo4
        qOUnHoOffXTfSoSH0cF6rT7GyEe40Wyx2StzMCMq20cmf9mgUCv4gbAyTuNvu7J5
        8hHz9ZlK994=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DD5F18DA0A;
        Fri, 20 Sep 2019 14:52:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 11A6A8DA09;
        Fri, 20 Sep 2019 14:52:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        garimasigit@gmail.com
Subject: Re: [DISCUSSION] Growing the Git community
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
        <xmqqsgoqvp6s.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 20 Sep 2019 11:52:03 -0700
In-Reply-To: <xmqqsgoqvp6s.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 20 Sep 2019 10:43:23 -0700")
Message-ID: <xmqq7e62vm0c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDD639E8-DBD7-11E9-9F77-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Growth and the world domination may come as a consequence, and I
> would not reject it when it happens, but we should not be actively
> seeking it.

I realize that it was my mistake that I did not explicitly say this,
but I do appreciate many of the things the document proposed.  They
are measures to make the community a better place for its members.
I want to see it labeled as such.

After all, this project is not an evil corporation with aspiration
for world domination, even though some of us may work for such
companies ;-)

Thanks for starting the discussion.
