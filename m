Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EA8A1F404
	for <e@80x24.org>; Thu, 14 Dec 2017 20:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752755AbdLNUrS (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 15:47:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55190 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752153AbdLNUrR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 15:47:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92A45C935D;
        Thu, 14 Dec 2017 15:47:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eDIoZo4hywnamgBNsluk0KbJe4E=; b=aq6vQX
        /T3MARj+5Vl1IUYn4IFTL+XR1ZJt+1CmiyVK58AcYzrV8QY7nUVQ4pCapB8T3NNc
        Dd0DqSVMaEYNg1fSIDZwgHL6jhuNqvgNXX27gF3d/VktmY4qqGplXiRglAqcIo/T
        KOIWz/kKxm48KJrl757IwrS6/tPR7tzUJKGAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xPa1KumoIu2EgOQY9BcNl6h5gwOr7HyE
        pXj435N9t56T/RsZbzIYGIzBG7Qjre37+Ram8oQ03wA0W6CEvhSiE0vzMIpx4ves
        1wTSjmgInavXvVGiYzPhwbIRBZBq/qzQkks2WBa94V7TI0bhmq4I/sf2bMwdKiyb
        winjDU3EGNo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 89DFAC935C;
        Thu, 14 Dec 2017 15:47:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ECA05C935B;
        Thu, 14 Dec 2017 15:47:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Cc:     BENSOUSSAN--BOHM DANIEL p1507430 
        <daniel.bensoussan--bohm@etu.univ-lyon1.fr>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jordan DE GEA <jordan.de-gea@grenoble-inp.org>,
        ALBERTIN TIMOTHEE p1514771 
        <timothee.albertin@etu.univ-lyon1.fr>,
        PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>
Subject: Re: [PATCH v2] doc: add triangular workflow
References: <1512034932-14499-1-git-send-email-timothee.albertin@etu.univ-lyon1.fr>
        <9a0556ac403845f39a564bbc55df5b3a@BPMBX2013-01.univ-lyon1.fr>
        <1547311095.1194033.1513263844281.JavaMail.zimbra@inria.fr>
Date:   Thu, 14 Dec 2017 12:47:14 -0800
In-Reply-To: <1547311095.1194033.1513263844281.JavaMail.zimbra@inria.fr>
        (Matthieu Moy's message of "Thu, 14 Dec 2017 16:04:04 +0100 (CET)")
Message-ID: <xmqqbmj1t4tp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F80E05E2-E10F-11E7-AF41-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <matthieu.moy@univ-lyon1.fr> writes:

> I don't think you should talk about "Git contributors", which can be
> read as "contributors to the git.git codebase". "Git users" would make
> more sense, or perhaps you meant "contributors to Git projects". But
> actually, I don't think this kind of documentation should focus only
> on new users. I think many reasonably advanced Git users do not know
> about remote.pushdefault for example.

Thanks for a careful review.

>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>> index 2ab6556..c3e98c7 100644
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -10,6 +10,7 @@ OBSOLETE_HTML =
>>  MAN1_TXT += $(filter-out \
>>  		$(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
>>  		$(wildcard git-*.txt))
>> +MAN1_TXT += git-triangular-workflow.txt
>
> git-*.txt is reserved for actual Git commands. Other tutorials use
> git*.txt (e.g. we have gitworkflows.txt and not git-workflows.txt).

Yeah, it probably is worth mentioning that MAN1 is for commands.
Unless we have "git triangular-workflow" subcommand, this shouldn't
be listed on MAN1_TXT list.  Perhaps in MAN7 next to tutorial and
workflow would be a better place.

>> +This workflow is commonly used on different platforms like BitBucket,
>> +GitHub or GitLab which provide a dedicated mechanism for requesting merges.
>
> As a user, I find it terribly frustrating when reading documentation
> telling me that "there's a dedicated mechanism" for something without
> telling me actually how to do it.

Also I think the description is backwards from end-user's point of
view.  It's not that it is common to use the workflow on these
hosting sites.  It's more like people use the workflow and adopt use
of these hosting sites as one building block of the workflow.

>> +In a triangular workflow the rest of the community or the company
>> +can review the code before it's in production. Everyone can read on
>> +**PUBLISH** so everyone can review code before the maintainer merge
>> +it to **UPSTREAM**.  In a free software, anyone can
>> +propose code.  Reviewers accept the code when everyone agree
>> +with it.

The above hints that the workflow covers wide range of development
circles from open source to proprietary, but the description in this
paragraph does not seem to show how the workflow achieves that goal
very well.  Not all environment allow "everyone" to read "publish"
(it is common to see siloed source repositories in commercial
settings), and not all projects require unanimous agreement for
inclusion.  Also, "anyone can propose code" may be true for any
project, not limited to "free" ones, as long as the code to base
your changes on is available, but if the project would not take
external contributions, being able to "propose" alone does not mean
that much to the proposer.

>> +If **PUBLISH** doesn't exist, a contributor can publish his own repository.
>> +**PUBLISH** contains modifications before integration.

I am not sure what this really means.  Isn't it the norm to create a
place to publish your work (and only your work) for your own use?
IOW, the above two lines solicit questions like "So... what happens
when publish does already exist??? and where does that publish
repository come from???"

