Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D879F2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 15:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937878AbcJ1PQC (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 11:16:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64557 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932873AbcJ1PQC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 11:16:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D0D646C74;
        Fri, 28 Oct 2016 11:16:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sIQqoTOuILewKNUExD/G2FhtFMs=; b=x4ZvAt
        a3zki2reO3paHEP8MjYL9DldQ9/pT4EvqgyHDZOtCnjGT0OV8qeJGVkfvpkKHgff
        5tFPoSgXY39bQXgFWo/P9mWLdfDZFNB4XWiIEC4ttNgnOvojF58fTbXdkhsGSKqV
        ypF8RtXIHRK6v8qmb+/hwXTdhR7JCbuZ5Fy3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A52eQpyYo2z5ecvlD1sNK6URSp+NoHGf
        l7ZCxAv9E2AHYe9HYzgdzvdu5tCdnW7gNJCOhE25P2mOBXqCVDrnO5LxddOtCseB
        5/9ASewgmxYE9v6vHDmHtyAzPSmB9LKIuBhHqCe5jBOgZFWAMWWvpDNXQW9P9zFh
        qFh8beMF/nY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 51BEC46C73;
        Fri, 28 Oct 2016 11:16:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B462646C72;
        Fri, 28 Oct 2016 11:15:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Christ <contact@stefanchrist.eu>, git@vger.kernel.org
Subject: Re: [PATCH] Documenation: fmt-merge-msg: fix markup in example
References: <1477648886-12096-1-git-send-email-contact@stefanchrist.eu>
        <20161028110820.a46ttxjicq2k5xdk@sigill.intra.peff.net>
Date:   Fri, 28 Oct 2016 08:15:57 -0700
In-Reply-To: <20161028110820.a46ttxjicq2k5xdk@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 28 Oct 2016 07:08:20 -0400")
Message-ID: <xmqq4m3w33o2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6EAB211E-9D21-11E6-805F-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Oct 28, 2016 at 12:01:26PM +0200, Stefan Christ wrote:
>
>> diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
>> index 6526b17..44892c4 100644
>> --- a/Documentation/git-fmt-merge-msg.txt
>> +++ b/Documentation/git-fmt-merge-msg.txt
>> @@ -60,10 +60,10 @@ merge.summary::
>>  EXAMPLE
>>  -------
>>  
>> ---
>> +---------
>>  $ git fetch origin master
>>  $ git fmt-merge-msg --log <$GIT_DIR/FETCH_HEAD
>> ---
>> +---------
>
> Thanks. Asciidoc generally requires at least 4 delimiter characters to
> open a delimited block (including a ListingBlock, which is what we want
> here). There is one exception, "--", which is a generic OpenBlock, which
> is just used for grouping, and not any special syntactic meaning (so
> that's why this _didn't_ render the "--", but did render the contents
> without line breaks).
>
> So looks good, modulo the typo in the subject that somebody else pointed
> out.

Thanks, both.  I queued with a bit more enhanced log message while
fixing the typo.

-- >8 --
From: Stefan Christ <contact@stefanchrist.eu>
Date: Fri, 28 Oct 2016 12:01:26 +0200
Subject: [PATCH] Documentation/fmt-merge-msg: fix markup in example

Use at least 4 delimiting dashes that are required for
ListingBlock to get this block rendered as verbatim text.

Signed-off-by: Stefan Christ <contact@stefanchrist.eu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-fmt-merge-msg.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 6526b178e8..44892c447e 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -60,10 +60,10 @@ merge.summary::
 EXAMPLE
 -------
 
---
+---------
 $ git fetch origin master
 $ git fmt-merge-msg --log <$GIT_DIR/FETCH_HEAD
---
+---------
 
 Print a log message describing a merge of the "master" branch from
 the "origin" remote.
-- 
2.10.1-791-g404733b9cf

