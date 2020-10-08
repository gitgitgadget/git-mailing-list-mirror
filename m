Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F146C433DF
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 18:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E276208C7
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 18:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F6urZOWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgJHSsq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 14:48:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50247 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgJHSsq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 14:48:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ABE507F36C;
        Thu,  8 Oct 2020 14:48:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YN0RvXEDoAtak9VQNLoqYxgE0yM=; b=F6urZO
        WQNg69Dnhd9J0XHiVKF+nV/jYgeWQHkZrxIiEv+xySoVBU+0FsS74wd5Q2SDRteZ
        kHUgDZhOZx3TTK2XJQfMniiv/SIiKl9qp2vjSfRZc0AnymGGh+IuxaOrSL4euznJ
        YnrTZG06w+jkWf/kCSBA/AfrL5Jdt6ZrR3Esc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xBZny23KFcUhi4yywes7AqT4Aw12cgMe
        191Kn8GnvHVMSp10h2BESbHGbtDdaFrfV7czeMgcJGVitSHE1XVdiF7YupiNLW61
        ghceqG4Caea4xNWLVLj11vloBPpEUKUPbpcJz8y7W1W0GLK5Vvdqd/F0KrXo3SGP
        +mKkD9IgmTw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A3A877F36A;
        Thu,  8 Oct 2020 14:48:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 30B847F369;
        Thu,  8 Oct 2020 14:48:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] contrib/git-resurrect.sh: indent with tabs
References: <cover.1602139448.git.liu.denton@gmail.com>
        <5f5f1763043e80cbae6f9d4286aa5ba1960d32e0.1602139448.git.liu.denton@gmail.com>
        <xmqqa6wwy66x.fsf@gitster.c.googlers.com>
Date:   Thu, 08 Oct 2020 11:48:44 -0700
In-Reply-To: <xmqqa6wwy66x.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 08 Oct 2020 10:32:22 -0700")
Message-ID: <xmqqsgaowo37.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4BB57DA-0996-11EB-A2FF-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Denton Liu <liu.denton@gmail.com> writes:
>
>> In the git-resurrect script, there are a few lines that are mistakenly
>> indented with spaces. Replace these lines with tabs.
>>
>> Signed-off-by: Denton Liu <liu.denton@gmail.com>
>> ---
>>  contrib/git-resurrect.sh | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/contrib/git-resurrect.sh b/contrib/git-resurrect.sh
>> index 8c171dd959..57a77c03f9 100755
>> --- a/contrib/git-resurrect.sh
>> +++ b/contrib/git-resurrect.sh
>> @@ -27,7 +27,7 @@ n,dry-run            don't recreate the branch"
>>  
>>  search_reflog () {
>>  	sed -ne 's~^\([^ ]*\) .*	checkout: moving from '"$1"' .*~\1~p' \
>> -                < "$GIT_DIR"/logs/HEAD
>> +		< "$GIT_DIR"/logs/HEAD
>>  }
>
> Unless this is done in preparation for a more meaningful change
> (like not reading from on-disk logs/HEAD and instead reading from
> "git reflog" output in order to help our future migration to the
> reftable backend), I do not think the reviewers' time is worth it
> for cosmetic changes on this script.
>

OK, so the "meaningful" part is to prepare for SHA-256 world.  That
sort-of makes sense.

But don't we want to remove the SP after the redirection operator
on the same line, while we are looking at it?


>>  search_reflog_merges () {
>> @@ -41,9 +41,9 @@ _x40="[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]"
>>  _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
>>  
>>  search_merges () {
>> -        git rev-list --all --grep="Merge branch '$1'" \
>> -                --pretty=tformat:"%P %s" |
>> -        sed -ne "/^$_x40 \($_x40\) Merge .*/ {s//\1/p;$early_exit}"
>> +	git rev-list --all --grep="Merge branch '$1'" \
>> +		--pretty=tformat:"%P %s" |
>> +	sed -ne "/^$_x40 \($_x40\) Merge .*/ {s//\1/p;$early_exit}"
>>  }
>>  
>>  search_merge_targets () {
