Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0A5320899
	for <e@80x24.org>; Wed,  2 Aug 2017 16:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbdHBQBT (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 12:01:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54706 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752436AbdHBQBR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 12:01:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF4F69ABC9;
        Wed,  2 Aug 2017 12:01:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bUXeEjtZMqGLRdw/Yg5vAnobgY0=; b=bztH68
        tl0ZC7Z08p5HiqdxbXayr5FL304i4oaSU7eFbT4wxGmB6R8vQJ9nXm/6Nd3BoWr+
        MEhzCB+wR6s6Xk0VW4rTs0aemWWeIpLrqfeBg1t8yuskq0HhzreABgKqB+jy6RuS
        YPlg96Wm78ub747BUuG2bkUsUMtTB5CkPHK3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dWHiDB3hiJc2AHUpSZW7Shm8tfErIUrd
        7PfHWUM9t7Zev5jomH1okiDk2o9YWuO/o4s6QiciTMrsdDzzh+u2NKmV8lyddYM/
        JdHtxdWWoWEolO3abuGT6Uvl+U3nsdnn7HG+G30QC3mzQj6NF25z7jEbVDaanO/K
        jjZpFdSFXow=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3DEC9ABC8;
        Wed,  2 Aug 2017 12:01:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0788E9ABC6;
        Wed,  2 Aug 2017 12:01:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] doc: add another way to identify if a patch has been merged
References: <CAGZ79kYg9jQ3kaKnNEJCH9fde=ar1KPiUr7=X+TguNc0Twqdzg@mail.gmail.com>
        <20170801160539.5587-1-kaarticsivaraam91196@gmail.com>
        <20170801160539.5587-2-kaarticsivaraam91196@gmail.com>
        <CAGZ79kZgV1=2HcYeXyoCy2Jk6v__trvTh_-rH+kbFX7fgWziyw@mail.gmail.com>
        <1501677122.1957.8.camel@gmail.com>
Date:   Wed, 02 Aug 2017 09:01:13 -0700
In-Reply-To: <1501677122.1957.8.camel@gmail.com> (Kaartic Sivaraam's message
        of "Wed, 02 Aug 2017 18:02:02 +0530")
Message-ID: <xmqqini6dkmu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D08A9270-779B-11E7-8280-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> On Tue, 2017-08-01 at 10:46 -0700, Stefan Beller wrote:
>> Actually I am slightly negative on this one, because of
>> occurrences like [1].
>> 
>> Our SubmittingPatches is already considered *too long* for most people
>> who just want to drop a drive-by patch.
>> 
>> Adding more knowledge (which btw is about general git usage and not
>> specific to our development workflow; you'd find the same tip in the
>> kernel community).
>> 
>> I wonder if we need a document that describes workflows.
>> (Oh, look we have 'man gitworkflows'! I did not know)
>> 
>> So maybe we want to cut a lot of workflow related commendatory from
>> the SubmitingPatches and then encourage to read such man page?
>> 
> That's right. Maybe Documentation/SubmittingPatches needs a revamp to
> be one-time contributor friendly? Maybe introducing a "gist" for people
> who do not have the time to read the whole document, might be of help?

First of all, I do not think lack of one-time contributor is
something we should consider to be a problem.  Supporting new
contributors so that they will be involved more in the development
process is a lot more important issue.

A new contributor will get something wrong no matter what the
documentation says.  One-time contributor's intention is "I am
sending a patch this time, but I have no plan to get involved
further---I do not have time for this".  It ridiculous to ask for a
patch that adds an 's' to the end of a third-party-singular verb in
the present tense to be rerolled only because the title had an extra
full-stop at the end.  Practically, a patch like that by a "one time
contributor" will always have to be fixed before committing it.

I think the exchange Stefan cited was an example that we want to
have more of.  The contributor is indicating that, even though the
patch could be a drive-by patch by one-timer from whom we will never
hear again, it is not--the contributor is willing to learn the way
things are done here, and showing that it is worth _our_ time to
explain the things so that the future patches will take less effort
to accept on our side.

Because we do not have a group of dedicated volunteers, it is done
by more experienced people around here but that can be done only
when they have time.  I view it as a more severe problem than any
documentation.  An abbreviated version of the documentation to
invite more new people means that we must be prepared to give more
high-touch onboarding help to them.




