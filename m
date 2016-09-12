Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1700C207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 20:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbcILULw (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 16:11:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58657 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751092AbcILULv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 16:11:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B38F3D491;
        Mon, 12 Sep 2016 16:11:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gDqY5FN1CMjmScJB5pyTTPYDgBk=; b=HKQ+su
        idIvxbOBUDVvU05E9DidtYP0FYoIWkVBxZpWhl0nwQTGxdljp5TIEhLMIy25C91G
        qvD0umXi1bcAB2lWaZ+wyD1PoQY2t6rIu5iW9ozLRrQymL/jQ9Cry3LQNW1wX5ZP
        eJzBNPDsYVcbFz6Dmq69k0HDMxPScXGMAoZKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FIxXYHMHFvvcFxtjxTC/tACqhQ+g/yaT
        HyOQ0JAloUBeieGqwDWW25WyVIY5cRo4+pi5TacslCzKWkYiY1Z63XLhq1yZ1EPX
        97L1XFNhm59wRf0ikJ+eqv4fTl+dD5SQlIWuIAwcwj8YuLICMB9bXRFO56hNviw+
        3+cmy0DWAXc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 944923D490;
        Mon, 12 Sep 2016 16:11:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 155113D48F;
        Mon, 12 Sep 2016 16:11:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jon Loeliger <jdl@jdl.com>
Cc:     David Bainbridge <david.bainbridge@ericsson.com>,
        Jeff King <peff@peff.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Miniconference at Plumbers
References: <E1bhKNo-0005m2-5z@mylo.jdl.com>
        <20160912004233.qh6uf35v5ylrboz6@sigill.intra.peff.net>
        <E1bjRLd-0005k0-Vb@mylo.jdl.com>
        <DB5PR07MB1448B5EDFE2E2D84C42A8AFCE2FF0@DB5PR07MB1448.eurprd07.prod.outlook.com>
        <E1bjVfp-0006sG-89@mylo.jdl.com>
Date:   Mon, 12 Sep 2016 13:11:47 -0700
In-Reply-To: <E1bjVfp-0006sG-89@mylo.jdl.com> (Jon Loeliger's message of "Mon,
        12 Sep 2016 13:09:41 -0500")
Message-ID: <xmqqeg4o27zw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23195B3C-7925-11E6-BB18-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jon Loeliger <jdl@jdl.com> writes:

> So, like, David Bainbridge said:
>> Hi,
>> 
>> The subject matter of the conference looks really interesting but I am
>> unlikely to be able to attend, unfortunately.
>> 
>> The subjects being covered like the current State of Git and the
>> Future of Git, for example, deserve much wider exposure, and I would
>> certainly appreciate hearing the thoughts of Junio and others.
>
> Indeed.

You do not need to go to NM to _hear_ that.  Basically, I want us
not to have "big" plans that come from the top.

Now, you heard it ;-)

There are areas that we as Git community would want to address for
some audience that were discovered over the years, and that "some
audience" might even be a large population of Git users, but if that
does not have overlap with Kernel Plumbers, the Plumbers mini-conf
may not be a suitable venue for even mentioning them.  E.g. the
enhancement of the submodule subsystem to allow more end-user facing
commands to recurse into them; rearchitecting the index and redoing
the "sparse checkout" hack so that we can do narrow clones more
properly; supporting "huge objects" better in the object layer,
without having to resort to ugly hacks like GitLFS that will never
be part of the core Git.  These things may all be worth talking
about in wider Git setting, but some of them may be waste of time to
bring up in the Plumbers' venue.

The future of Git is shaped largely by end-user itches.  From my
point of view, Git people are going there primarily to find what
Kernel Plubmbers' itches are, and help assessing the workflow
improvements around Git the Plumbers are wishing for or designing
themselves by being there, because we are at the best position to
tell what kind of enhancement to Git is feasible and what is
unlikely to happen in the near term.
