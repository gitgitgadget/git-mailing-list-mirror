Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12E32202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbdJBFyf (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:54:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61003 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751104AbdJBFye (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:54:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B81394F89;
        Mon,  2 Oct 2017 01:54:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4JjtR/bsCG1YsxkJWHsUswB01lk=; b=g4siA9
        SMFlmaZcjQffBmxIGg8EFY2Ysv+kVlQY8wiu5DsH8ewwmpXBbWbxjAeCQPeZU66Z
        i1FbdZQlLBSIf9gSPOAcUpT6iadX7jYnSDgrl11sx5p39DRNR9kUQlB0av7AsA8R
        EvOFcv5NafBAoo777Lyhg5WgCSUJHuzuQ4+0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Km6pos0lqnpF9T5Rwh7PfBM6uR2uAmMm
        eISD3kXKTx3RGH3zKeNJOkjNl1flMel0wbspgGqXUeLeLXa+PGNzN1uu+EY8REJT
        MWgdaiiJoS0PDlONe2PpEubLzHQhf9isqKkJ0kFY9aRagipKffoWjrtDEw7FR04E
        YQml936eMBU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6386A94F87;
        Mon,  2 Oct 2017 01:54:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D446694F86;
        Mon,  2 Oct 2017 01:54:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH 0/4] pre-merge hook
References: <cover.1506081120.git.git@grubix.eu>
Date:   Mon, 02 Oct 2017 14:54:31 +0900
In-Reply-To: <cover.1506081120.git.git@grubix.eu> (Michael J. Gruber's message
        of "Fri, 22 Sep 2017 14:04:11 +0200")
Message-ID: <xmqqfub2p014.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29C35F2E-A736-11E7-B68B-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> Now that f8b863598c ("builtin/merge: honor commit-msg hook for merges",
> 2017-09-07) has landed, merge is getting closer to behaving like commit,
> which is important because both are used to complete merges (automatic
> vs. non-automatic).

Just a gentle ping to the thread to see if it is still alive.

I think people agree that this is a good thing to do, but it seems
that the execution leaves a few loose ends, judging from the review
comments that have yet to be answered.

Thanks.
