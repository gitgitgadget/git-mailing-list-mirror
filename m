Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F1281F991
	for <e@80x24.org>; Mon, 31 Jul 2017 20:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751059AbdGaUen (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 16:34:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59607 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751017AbdGaUen (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 16:34:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 190B8A50B6;
        Mon, 31 Jul 2017 16:34:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Nmxw1EYRBCHgb+hBl72BJ2H4jFQ=; b=n89guA
        cbthDvok0PeZwk10rzbTXPGTmna/H1/prA3Gnpf0qnPeu+EzCRLKd8TGn3QokYy4
        u32tvZ2KeeOgaL5Epi8Wdy6gkjqm6H2t44dlGeb515ZYKI+1q5iTVCIBFsKpNo4k
        QqKmpf9nu47V6pbCvyDSOetqUz3QClc+Sx8oU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eoz1NjnbbvHnIPHPlzONJDCGlLWQ4c0e
        /lMv4lR34C6xJzWGObyVOPgjffBYQ6aJqiZOtsNat6/+X3M85RAgflfD36FcyZ9I
        p7Z97j0FTsvH+eT7vskhMxPnWMwibAlvYfqhkGtHnk+vmHY+TfCr/fHjcJinK+Wm
        iolk0QuWZeM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 10585A50B5;
        Mon, 31 Jul 2017 16:34:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7384BA50B4;
        Mon, 31 Jul 2017 16:34:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] doc: fix small issues in SubmittingPatches
References: <8256C530C7DE43D7BC72BFB327DF4726@PhilipOakley>
        <20170730161816.2412-1-kaarticsivaraam91196@gmail.com>
        <CAGZ79kYg9jQ3kaKnNEJCH9fde=ar1KPiUr7=X+TguNc0Twqdzg@mail.gmail.com>
Date:   Mon, 31 Jul 2017 13:34:40 -0700
In-Reply-To: <CAGZ79kYg9jQ3kaKnNEJCH9fde=ar1KPiUr7=X+TguNc0Twqdzg@mail.gmail.com>
        (Stefan Beller's message of "Mon, 31 Jul 2017 13:23:23 -0700")
Message-ID: <xmqq8tj4ibvj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AE1F8A50-762F-11E7-9CE6-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> Further, remove duplicated space character.
>
> https://en.wikipedia.org/wiki/Sentence_spacing
> seems like a globally controversial thing. (I assumed
> it was some sort of local dialect before researching
> it properly)
>
> I personally do not mind one way or another regarding
> (double) spaces after a period, but I would think we'd
> strive for consistency throughout the project.

I am not sure if that is something we want to encourage newbies to
be doing.  Especially a patch like this (notice the double-space
before "Go back to..." in the pre-context) makes me feel it is
distracting without adding much "consistency" value.

And no, I am not suggesting a tree-wide sweep to make everything
consistent.

>>       spend their time to improve your patch.  Go back to step (2).
>>
>>   (4) The list forms consensus that the last round of your patch is
>> -     good.  Send it to the maintainer and cc the list.
>> +     good. Send it to the maintainer and cc the list.
>>
>>   (5) A topic branch is created with the patch and is merged to 'next',
>>       and cooked further and eventually graduates to 'master'.
>> --
>> 2.14.0.rc1.434.g6eded367a
>>
