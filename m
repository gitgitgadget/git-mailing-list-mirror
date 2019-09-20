Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00ACD1F463
	for <e@80x24.org>; Fri, 20 Sep 2019 19:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfITTWJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 15:22:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63997 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfITTWI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 15:22:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DF0DA97E57;
        Fri, 20 Sep 2019 15:22:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fmz5qBdlS6G24wobateUuSVQY7U=; b=EsxK5e
        HGuY8Tq3nIlPsqA8yuNWr8/2MaopF4IZMWjW5BH9Xt/0ijVJ4X7NvRflQIc2YuDa
        RPQBtuM6cZiXVCvArIoV8HYxPXrwKIVT+d3BR9ZYc/jyYeAaC2vKF3wzpDHeZKHy
        TqREuHx21pxxFqQJJdUNIzu9ob23aDePARPYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Hj/gvh0/Wukx0PlfrO0ZGttY6+maX1Cg
        qIVj+n2MrWMym9qbwHu8Q/cYsQoQVmjUcQSgk3qHOdYFlEP0Ug7jTWQLbc1tBmNB
        kw96uBVQqXct3UoutPa0knQ7yUzQ0b06DFP/aGsqC6nDh3hyzJlVK+4NKL6liDlA
        KFMzYVK6eXo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D812497E56;
        Fri, 20 Sep 2019 15:22:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 11BDC97E55;
        Fri, 20 Sep 2019 15:22:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2019, #02; Wed, 18)
References: <xmqqy2yl44lw.fsf@gitster-ct.c.googlers.com>
        <20190920170811.GA62895@syl.local>
Date:   Fri, 20 Sep 2019 12:22:01 -0700
In-Reply-To: <20190920170811.GA62895@syl.local> (Taylor Blau's message of
        "Fri, 20 Sep 2019 13:08:11 -0400")
Message-ID: <xmqq36gqvkme.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED875920-DBDB-11E9-A915-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> commit-graph files on all repositories hosted on GitHub, and some
> corrupt repositories triggered the behavior.
> ...
> We've been running this patch since a few days before I submitted it to
> ...
> This one has a similar origin story, and has also been running at GitHub
> for a few weeks. ...
> ...
> A previous version of this series is running at GitHub, too, and also
> without issue.

Thanks for a follow-up.  Very much appreciated.

