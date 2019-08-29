Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6FD41F461
	for <e@80x24.org>; Thu, 29 Aug 2019 03:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfH2Dqc (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 23:46:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60509 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfH2Dqc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 23:46:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AC81C86B7D;
        Wed, 28 Aug 2019 23:46:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ItMTyVbxNhhpZa0iiAzvC6Nf0/c=; b=JC/Khu
        mt1+uw5whss8ZU4iM5y8ARQXrL/r2Qh7bwg9h/BPru+0+GLdPv1bGVmHP8X6pqBp
        +DM5lbuYkOhzMxEgyiWqAesavej4/rSi2RD7wa0UsioqzmYhWClvUTEzftpVvSju
        9hVJwg1mUFdjjCr2CayGuf0jxwAM51kNTBO3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ddFFKJpgcYIw4D/0VqtqMcBqgReJmnRf
        ChcvA2t+Xpz69vA6ShnmZiU5J1Y+Z7162Md4miMn1zpXoSH8QCNfxpDG05mbpSwy
        7wZfYNZS4983l1EHpFsYEpIGBOnzpJWpMSQ3Ihh0g1Q20anyqH4CY4BIbmFjX0PJ
        CVxAQwdMzoE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A528F86B7C;
        Wed, 28 Aug 2019 23:46:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D4E6C86B7A;
        Wed, 28 Aug 2019 23:46:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gitk: Make web links clickable
References: <20190826221444.GB7402@blackberry>
        <xmqqimqi2vtt.fsf@gitster-ct.c.googlers.com>
        <20190829005011.GA3297@blackberry>
Date:   Wed, 28 Aug 2019 20:46:25 -0700
In-Reply-To: <20190829005011.GA3297@blackberry> (Paul Mackerras's message of
        "Thu, 29 Aug 2019 10:50:11 +1000")
Message-ID: <xmqqy2zczl9q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94A7DBFA-CA0F-11E9-A5F5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Mackerras <paulus@ozlabs.org> writes:

> I was expecting some comments and suggestions, so I didn't push it out
> yet.  One suggestion which seems reasonable is to match any http or
> https URL anywhere in the commit description, not just with Link: or
> BugLink: at the start of the line.  What do you think of that?  It's
> quite easy to do.  Also it should stop at whitespace rather than going
> to the end of the line.

Yup, that's a quite good suggestion, without little chance of false
positive these days, as we do not have to worry about anything but
http:// and https:// ;-)

In case I forgot to say in my previous message, it's been a while
since we heard from you the last time.  Welcome back ;)

