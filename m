Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2C0C001DE
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 15:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237418AbjG1Pmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jul 2023 11:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237405AbjG1Pmc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2023 11:42:32 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0701E4F
        for <git@vger.kernel.org>; Fri, 28 Jul 2023 08:42:31 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F02F71A6AF4;
        Fri, 28 Jul 2023 11:42:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9daOLPEDnXtO5bHN1aJhBKt14A0eTp7778KfRb
        rGjhs=; b=xWAJGD5RAwagPDHeqhIcxylTg/6Xgqbftxbo5gEENNH85x4f3XsO28
        4hRvr3huiZqCYXsd18fMZ++JF5eFJq1QOW1vCWR3I9y565itIlsUUcgge2840Ill
        jUTrfmS8IMliwgXCUe+rQ1GW1uMoqk3aBlYePsimjrTnfvCidBAqA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E6F4F1A6AF3;
        Fri, 28 Jul 2023 11:42:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5321C1A6AF2;
        Fri, 28 Jul 2023 11:42:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re* [PATCH v4] MyFirstContribution: refrain from self-iterating too
 much
References: <xmqq3583uyk0.fsf@gitster.g>
        <20230122071156.367jwwt3d5txvkl4@tb-raspi4>
        <xmqqcz76tv6d.fsf@gitster.g> <xmqqzga9opdu.fsf@gitster.g>
        <20230123175804.2bkcr7yawyz5fhkb@tb-raspi4>
        <xmqq8rbbbzp2.fsf_-_@gitster.g> <owlycz0deykz.fsf@fine.c.googlers.com>
        <xmqq7cqkanm9.fsf@gitster.g> <xmqqmszg987u.fsf_-_@gitster.g>
        <eaky7y2tprkzvhjdcg5vv2asekclywfcthzolpfu5o363423ca@b3p33bsbcqi5>
        <xmqq7cqk8vuk.fsf@gitster.g>
Date:   Fri, 28 Jul 2023 08:42:29 -0700
In-Reply-To: <xmqq7cqk8vuk.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        27 Jul 2023 22:10:27 -0700")
Message-ID: <xmqqa5vg59ga.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C9638B4-2D5D-11EE-8BB6-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jacob Abel <jacobabel@nullpo.dev> writes:
>
>> Speaking as a fairly green contributor to the project, it may be helpful
>> to include some guidance on what is "too long" vs "too short" when
>> waiting to send out the next revision. 
>
> We generally do not want to be too prescriptive, ...
> But as a general common-sense guideline, I would encourage people to
> wait for at least one earth rotation, given that there are list
> participants across many timezones.  I do not know offhand how to
> fit that well in the narrative being proposed, though.

On top of v4, we could do something like this, I guess, but I
realize that this is talking about minimum waiting time to allow
others to even notice-see your patches, while the original is about
them needing time after noticing your patches to process them, and
the latter heavily depend on many factors (like how involved the
patches are, how many people are likely to be interested in).

So, I doubt adding this is a good idea.

diff --git c/Documentation/MyFirstContribution.txt w/Documentation/MyFirstContribution.txt
index 93c9e459fc..440e9ede32 100644
--- c/Documentation/MyFirstContribution.txt
+++ w/Documentation/MyFirstContribution.txt
@@ -1259,7 +1259,9 @@ index 88f126184c..38da593a60 100644
 Please give reviewers enough time to process your initial patch before
 sending an updated version. That is, resist the temptation to send a new
 version immediately, because others may have already started reviewing
-your initial version.
+your initial version. The development community members are across the
+globe and it is a good idea to give them time to see your patches by
+waiting for at least one rotation of the earth.
 
 While waiting for review comments, you may find mistakes in your initial
 patch, or perhaps realize a different and better way to achieve the goal
