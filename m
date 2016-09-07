Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E63BA1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 16:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754723AbcIGQQ3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 12:16:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51110 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752586AbcIGQQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 12:16:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 066C93AA5B;
        Wed,  7 Sep 2016 12:16:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7eF4xT1pGu2m
        GCKj2A3jZmCqNuY=; b=DQl8xez7UMIchH+2BL8KodLK6yg2Oh7WbjkpXFwF65JG
        SCzG4+cE2cvrk1pDKF9W3rNGWd/P7GDAnMrE3esVUBNyCfDxAJA96OprSnh7aDoP
        ryyS6UI4CaNvVIYuIPT/PPNrPftFEF8fqlNGDYXdGXawmvDJdDLOakYbrxUJVYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nY5IH5
        x6fU1tRdUYq90nh4ffdfQ7k2EV9NuCRj4QAklYp3ipdgwzjkWL0wz6d8G/hnXsAk
        JgSHapH+sGfj7ZfE819g36mzp6ahhObGEnINer5k3wDrZ3VTmQIQFTBvp5FaKbmj
        nu21sghStn/wtHIUd8rqmAGvTkwF/OCAR3Ha4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8EE23AA5A;
        Wed,  7 Sep 2016 12:16:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6AF073AA59;
        Wed,  7 Sep 2016 12:16:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: A note from the maintainer
References: <xmqqmvjpsp5h.fsf@gitster.mtv.corp.google.com>
        <77c9288d-4b4d-fda8-a1eb-dab4b5056b1d@gmail.com>
Date:   Wed, 07 Sep 2016 09:16:24 -0700
In-Reply-To: <77c9288d-4b4d-fda8-a1eb-dab4b5056b1d@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Sat, 3 Sep 2016 12:26:11 +0200")
Message-ID: <xmqqd1kfptwn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6D47AC4E-7516-11E6-AAA8-F7BB12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> W dniu 03.09.2016 o 04:17, Junio C Hamano pisze:
>
>> Please remember to always state
>>=20
>>  - what you wanted to achieve;
>>=20
>>  - what you did (the version of git and the command sequence to reprod=
uce
>>    the behavior);
>
> I wonder if it be worth adding to not use aliases (or expand them).  I =
have
> seen quite a few such questions on StackOverflow...

    - how others can reproduce what you did (the version of git and
      the command sequence);

perhaps?

>>=20
>>  - what you saw happen (X above);
>>=20
>>  - what you expected to see (Y above); and
>>=20
>>  - how the last two are different.
