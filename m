Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A182C3B1AF
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 17:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2730E22314
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 17:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S5n0V27N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbgBNRg1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:36:27 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64691 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387419AbgBNRgT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 12:36:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3DB0AB6669;
        Fri, 14 Feb 2020 12:36:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ET0i+LewH3s2+YAb8Guhfq8Jfpg=; b=S5n0V2
        7NDIIPrbltFPhoXQVFccCugvmsbYV4CebHwc4n8Coypxc/XieeS87QEJg5R1/rSU
        QPpvU9wrhJGGWm+OCc76O5qGczB2gQqPjKFzgETHt+hpZ33Vu+A4B8hUCSO//xA6
        Dz2EW/oDjwj+8HFGFMfhqxAmG53zrRPB3ilzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h1I5+zyaHNvWMULefb0knkON57wSH9Xu
        MDUey02LXFLiup0YGAZ75co/G3spjiynzCDwf6usB/rlELDfVQYipRhnX1fB3ksb
        YGBkrnhp01v0WkgeIqI42ROE8KhUka5tryz7GUryRd74eREG/0fkX1HAUdBjPOVy
        8yHv+ezWTP4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 352CCB6668;
        Fri, 14 Feb 2020 12:36:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 57672B6667;
        Fri, 14 Feb 2020 12:36:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] MyFirstContribution: rephrase contact info
References: <xmqqh803fzf1.fsf@gitster-ct.c.googlers.com>
        <20200214020359.17463-1-emilyshaffer@google.com>
        <20200214021027.GA191976@google.com>
Date:   Fri, 14 Feb 2020 09:36:12 -0800
In-Reply-To: <20200214021027.GA191976@google.com> (Jonathan Nieder's message
        of "Thu, 13 Feb 2020 18:10:27 -0800")
Message-ID: <xmqqr1yxnkab.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F86803E-4F50-11EA-AF30-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Emily Shaffer wrote:
>
>> Make an effort not to discourage new users from mailing questions to
>> git@vger.kernel.org, and explain the purpose of the mentoring list in
>> contrast to the main list.
>>
>> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
>> ---
>>  Documentation/MyFirstContribution.txt | 29 +++++++++++++++------------
>>  1 file changed, 16 insertions(+), 13 deletions(-)
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks for tying up this loose end.

Thanks, both.  Let's merge this to 'next' and down to 'master', if
we do not hear a better suggestion while waiting for a couple more
days.
