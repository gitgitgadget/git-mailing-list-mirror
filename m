Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9D472036D
	for <e@80x24.org>; Wed, 22 Nov 2017 04:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751471AbdKVEje (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 23:39:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61797 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751434AbdKVEje (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 23:39:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5684BB1BC8;
        Tue, 21 Nov 2017 23:39:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k5I4VtnUbM6OnHLGzX5um9IleQg=; b=ZSTue2
        64qJgMT0cu1ic3tTN2rBvHOCjrNAMI+NeYhPg4l7f7iCzEoJnHr+9zbV51ZtX5UW
        RHZWI3ZK5ViXQD5XL6q7VMS9uWaBR+PqC3U7YVwB0GlKEubmBkPZ7iTtlNjNh6Tq
        duWbTufT/mldhw+6ex2F81cse4bya0F3jvDVY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y4KwXxm+gs8Pj6zQzrrSjs7OdJRhQeFH
        7S9+REoG2VV22v3pq0DJJDQB6n9QpOv85oWSmFWhA7Ev7TfWtmqxtcwz0eOxFkVW
        z+29JOkADYD6v4+s68bvJ7BDUzjAUo3B4CJ9KpJVIqQMliTZdXV9Tgku2vf8T4uz
        v+HK0H7r+6w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D422B1BC7;
        Tue, 21 Nov 2017 23:39:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B9913B1BC6;
        Tue, 21 Nov 2017 23:39:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: doc: prefer 'stash push' over 'stash save'
References: <CABURp0pxYiwrpvT9E_jpvZKDMOUVA9e7dUhARfKEQymWzUwtiw@mail.gmail.com>
        <20171121232113.GK3429@aiede.mtv.corp.google.com>
Date:   Wed, 22 Nov 2017 13:39:31 +0900
In-Reply-To: <20171121232113.GK3429@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Tue, 21 Nov 2017 15:21:13 -0800")
Message-ID: <xmqqlgizudto.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 228F0C90-CF3F-11E7-9C1F-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Phil Hord wrote:
>
>> Although `git stash save` was deprecated recently, some parts of the
>> documentation still refer to it instead of `push`.
>>
>> Signed-off-by: Phil Hord <phil.hord@gmail.com>
>> ---
>>  Documentation/git-stash.txt | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Thanks.

Heh, this does not even apply to 8be661007 that it claims to apply
on top of, which is contained in fd2ebf14 ("stash: mark "git stash
save" deprecated in the man page", 2017-10-22).

I've wiggled it in, so there is no need to resend, but next time
please be careful when sending the patch and also when sending a
reviewed-by.
