Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB001C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 22:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F93A20826
	for <git@archiver.kernel.org>; Thu, 21 May 2020 22:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vi0S90nG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbgEUWTI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 18:19:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55584 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbgEUWTI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 18:19:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8066D6AF0C;
        Thu, 21 May 2020 18:19:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g2dkqM8gRffvRXmPnj1SKQYbMb8=; b=Vi0S90
        nGbhNixj9tS15hou9Tqwo5TI17w43uYXsdgTSq2vtZO3TRhxoYMxZUEkvFAzIqe3
        QQMOCxXOPsJJHl490CXHOzQtiBNMryLQD9HSClNdtxtdFY+tVcViF+f3obY5gjq1
        OzvEGaIckFvusfxLAT6+D0gNTUxUTQ8l3T2I8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x3lupXkdzjAZX9pebrzZWiA06CUvloJ5
        geRkG8mo6Ogfdc3NDlOkBRMWae4GddLQuapn8202YVnkwTKlzx8WqDIVCbx80048
        pq2rOH34TWdxclPQmSoHMg+jB/oKoFZaocNtluXP7LVM6b99k5ly0P7zRyz6GDNm
        x4A7TuQj5T0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77D236AF0B;
        Thu, 21 May 2020 18:19:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C8D7F6AF0A;
        Thu, 21 May 2020 18:19:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: How do Git on Linux users launch/read the user-manual?
References: <8142f64b-9b5e-3637-21a2-3671dd65a42e@iee.email>
        <xmqqtv0athz5.fsf@gitster.c.googlers.com>
        <6dd15666-1e3e-e9b2-d98b-396d58f241cd@iee.email>
        <xmqqpnaytb31.fsf@gitster.c.googlers.com>
        <ecac8516-e536-80e8-fc72-098406592fd5@iee.email>
Date:   Thu, 21 May 2020 15:19:03 -0700
In-Reply-To: <ecac8516-e536-80e8-fc72-098406592fd5@iee.email> (Philip Oakley's
        message of "Thu, 21 May 2020 22:29:35 +0100")
Message-ID: <xmqqzha1q6co.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 142F7DBA-9BB1-11EA-BEBA-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

>> Or are you asking something else?
>>
> I was more coming at the question from the other direction, that is,
> about accessing, normally, the git manuals, and discovering the desired
> information, both for existing and new users.
>
> In your example, you needed to include the extra -w option, specific to
> this 'special' manual, while all the other hundreds of man pages would
> be accessed without it (even on Windows, as the config is set by default).

For those who have help.format set to html, it is no "extra" thing
required.  I said "git help -w" so that people would understand what
I meant regardless of their personal settings are.

Or are you saying that nobody on Linux uses the html format?  I
should stop keeping the git-htmldocs.git repository up to date,
if that is the case, but I suspect it is not.

> We do have the advised `git help -g` to list the concept guides, but
> that doesn't advise about the user-manual, which surely we should
> mention to those asking for help (without them needing a long journey of
> discovery). The list does include `git everyday`...
>
> I appreciate that, for some, there is a view that new users are other
> peoples problems and that knowledgable users already know, roughly,
> which command they wish to use and thus then peruse the appropriate
> reference manual to confirm the correct form for their command. I'd
> rather we direct uncertain users to their appropriate guide quickly,
> using their expected viewer method. Hence the question.

Or are you volunteering to update the mark-up (if necessary) so that
user-manual would become part of "man" ("man git-user-manual",
perhaps) suite?  That would be an excellent suggestion.

Whatever proposal/volunteering comes from you after your question is
answered would be quite interesting.  Hopefully that would be one
that is beneficial to the project as a whoel ;-)

Thanks.

