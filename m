Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAEBF20958
	for <e@80x24.org>; Sat,  1 Apr 2017 19:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbdDATNm (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 15:13:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54413 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751804AbdDATNm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 15:13:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2ABB56A35B;
        Sat,  1 Apr 2017 15:13:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CqkerUjYtygmWa/+kTDYXbzCwmM=; b=u02Mcs
        L9FsFWpkokNDLiG+VgRgpOKEXyoUlcGaeOMyBZpiQ4JIW/aflGmapIy1lXzuJjJF
        AGZmPSXjjWLSok1S3vnrsTBNg/y6f5KNjUc3ulM74y5XLVDDjixgOOuBxogcK/DP
        5NItsSG2ykpVuyzvor0wROZNX+e0M1h6bBbW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=shgH30AVxCt+Hm4EmLppc12kgFOe12WU
        Cwf7dXFktMJE6mTZsdytYTDguVJEYYlwKLx+RK3N+4RHYgHlfzjMxIHYg8MrT9NZ
        resLdKMk2ohskUkoCWt6f0kcJ8qeGsX54wAs3kbrGaPAs9oT4dcPzUPEr+4qB3TI
        5DmJpDYGjZc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 231D46A35A;
        Sat,  1 Apr 2017 15:13:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4E3F56A359;
        Sat,  1 Apr 2017 15:13:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Stanca <robert.stanca7@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] [GSOC] show_bisect_vars(): Use unsigned int instead of signed int for flags
References: <20170401153049.21400-1-robert.stanca7@gmail.com>
        <20170401153049.21400-2-robert.stanca7@gmail.com>
Date:   Sat, 01 Apr 2017 12:13:38 -0700
In-Reply-To: <20170401153049.21400-2-robert.stanca7@gmail.com> (Robert
        Stanca's message of "Sat, 1 Apr 2017 18:30:49 +0300")
Message-ID: <xmqqtw68szz1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 50A9732E-170F-11E7-9436-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Stanca <robert.stanca7@gmail.com> writes:

>  As rev_list_info's flag is unsigned int , var flags should have proper type.Also var cnt could be unsigned as there's no negative number of commits (all-reaches)
>
> Signed-off-by: Robert Stanca <robert.stanca7@gmail.com>
> ---

OK.  I would have squashed these two commits into one, though.
