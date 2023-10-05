Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920A0E92726
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 18:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjJESoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 14:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjJESoN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 14:44:13 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C5993
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 11:44:12 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AF9581CECC;
        Thu,  5 Oct 2023 14:44:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=tXOj6FsCdKvoDqTUDkkekAggSTnp8eoGFQnqC2
        FzV3I=; b=Fb7q2FUqtTMvnRmoztOb31bnxlY3K2wJQT03CAVoIkmzMYJWgyY908
        7onsNtKnsvgYU+o5exXe/5PQlT4EMYce6c28UWib9qpsisc7ofsG0N9gpWUrb1du
        TB7dOf6GsnV8sYqg4n28qTIgCdhG7E9m03YLL4LtbTDWL4X8XaF7o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A81B31CECB;
        Thu,  5 Oct 2023 14:44:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 485131CEC6;
        Thu,  5 Oct 2023 14:44:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: js/ci-coverity, was Re: What's cooking in git.git (Oct 2023,
 #02; Wed, 4)
In-Reply-To: <20231005170859.GB975921@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 5 Oct 2023 13:08:59 -0400")
References: <xmqqpm1ulzoh.fsf@gitster.g>
        <20231005170859.GB975921@coredump.intra.peff.net>
Date:   Thu, 05 Oct 2023 11:44:05 -0700
Message-ID: <xmqqh6n4j4ei.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A2D2CB0-63AF-11EE-90FB-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Oct 04, 2023 at 04:45:34PM -0700, Junio C Hamano wrote:
>
>> * js/ci-coverity (2023-09-25) 7 commits
>>  - SQUASH???
>>  - coverity: detect and report when the token or project is incorrect
>>  - coverity: allow running on macOS
>>  - coverity: support building on Windows
>>  - coverity: allow overriding the Coverity project
>>  - coverity: cache the Coverity Build Tool
>>  - ci: add a GitHub workflow to submit Coverity scans
>> 
>>  GitHub CI workflow has learned to trigger Coverity check.
>> 
>>  Looking good.
>>  source: <pull.1588.v2.git.1695642662.gitgitgadget@gmail.com>
>
> I think that has been sitting at "Looking good" for a few iterations.
> IMHO it is ready to progress, with the SQUASH applied on the final
> patch.

Ah, yes, unless I use some magic phrase (like "Will merge to" or
"Expecting") there in the report, entries tend to be left in the
noise.  Thanks for noticing and pinging.  Very much appreciated.
