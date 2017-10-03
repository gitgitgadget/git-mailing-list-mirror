Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 386DD20281
	for <e@80x24.org>; Tue,  3 Oct 2017 04:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750846AbdJCEQY (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 00:16:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62943 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750767AbdJCEQY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 00:16:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A264A7BD0;
        Tue,  3 Oct 2017 00:16:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lpmd1s3C/AAos8exySa8hD4EUXY=; b=ubb8y6
        jyZ/Ik6YgmMBoGhc6KqiHOTJNanbBIuzmSxD9Hsr0W4+V0EUdZHM+m0vU0o6rZL/
        1/4yhoI66Io11EpUm9M43DBIEZuNpN6OAOscNCqKBTosxX9jrAOVtYpWqbwqJyxt
        tOaykjOwKrHZTvy6YHbQOEzC+fWhmhJs5fip0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sLxhrLOfA118Ledvc+J301SN54nef6l2
        rYswjoLhMJGLDIYkTm8LxQqtr1sAe7ArwE0W+cuRRmiWVjRIgnDi1GMszZEb7B+e
        AruymSFiIgoclwrh8CQMayhoYsTCpmO8IiVbp88m0S2tlAJQNZnYQ8fT8ow2XLzp
        N9OCLjXb5aI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71ACFA7BCF;
        Tue,  3 Oct 2017 00:16:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6722A7BCE;
        Tue,  3 Oct 2017 00:16:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, git@jeffhostetler.com,
        sbeller@google.com
Subject: Re: [PATCH v3 1/5] test-list-objects: List a subset of object ids
References: <20170925095452.66833-1-dstolee@microsoft.com>
        <20171002145651.204984-2-dstolee@microsoft.com>
Date:   Tue, 03 Oct 2017 13:16:21 +0900
In-Reply-To: <20171002145651.204984-2-dstolee@microsoft.com> (Derrick Stolee's
        message of "Mon, 2 Oct 2017 10:56:47 -0400")
Message-ID: <xmqq1smklvca.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D817A70-A7F1-11E7-BC45-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> Subject: Re: [PATCH v3 1/5] test-list-objects: List a subset of object ids

Style nit: s/List/list/;

>
>     Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

This should stick to the left hand side.

No need to resend, only to fix these two, as I'll tweak them when
queuing.

