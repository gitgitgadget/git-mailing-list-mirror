Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 887C2208DB
	for <e@80x24.org>; Wed, 23 Aug 2017 01:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753046AbdHWBKM (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 21:10:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60513 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752628AbdHWBKL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 21:10:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 82A7D949E1;
        Tue, 22 Aug 2017 21:10:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qIObbs5/7LPD9D2VrbjIBB63UZQ=; b=YpXtwX
        x6TFfNKLfSJAVO6NyqlhkSPv4oxEuqUDCI0W6AfB/Dwt+cZgEjhYJzn0vkTP/N+a
        sNOhw6gTbsKl3eAof6fTdA7V1gYkz9W/9+vsoNlDNi2Th4FdeUs/3ygX0evR03GC
        NcGYcpSmhx7KeqGUQaOkyrQmx2UaDUP3sl/98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QLaB08gNyMn5OtIX3rhMvWAk7k4aqIbe
        ZWv9HyYqGpYiPYIDVZI6+m2LvQCr9zsbKnSB3nwPUjpDkHYdwPxHn9bnPNvzx2vi
        LlR3NxksTU6OsmOmXzca86hqf6RfTRfOSmmoIjzx/5LV4MR8xs/QCUk0wKnv8Skg
        ZyXJfLcq+Iw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 733DD949E0;
        Tue, 22 Aug 2017 21:10:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C300B949DB;
        Tue, 22 Aug 2017 21:10:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] vcs-svn/repo_tree.h: remove repo_init declaration
References: <20170822213501.5928-1-sbeller@google.com>
        <xmqqmv6r1c26.fsf@gitster.mtv.corp.google.com>
        <20170822234553.GC13924@aiede.mtv.corp.google.com>
Date:   Tue, 22 Aug 2017 18:10:06 -0700
In-Reply-To: <20170822234553.GC13924@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Tue, 22 Aug 2017 16:45:53 -0700")
Message-ID: <xmqqa82r1441.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDAA6DBE-879F-11E7-9CCA-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
> ...
>> It looks to me that this is a reduced duplicate of what brian posted
>> yesterday.  The first two patches in the 6-patch series that you
>> commented on, I think, covers what this change wants to achieve and
>> probably a lot more.  I've merged those two already to 'next' and
>> was about to push the result out.
>
> I just sent
> https://public-inbox.org/git/20170822233732.GX13924@aiede.mtv.corp.google.com/
> to fix this more thoroughly.  I can rebase on top of bc/vcs-svn-cleanup
> if that is helpful --- just say the word.

Yup, as I merged those two preliminary clean-up separately to 'next'
already, it would be more efficient to build on top.  I do not know
what you are planning with the other patches (I only saw Stefan's
one, not your series) so do not yet have suggestion on how to work
well with Brian's series that builds on his two clean-up patches.
Hopefully they are orthogonal?

Thanks.
