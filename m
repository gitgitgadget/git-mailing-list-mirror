Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F06172018E
	for <e@80x24.org>; Mon,  8 Aug 2016 18:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbcHHSBy (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 14:01:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63487 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752243AbcHHSBx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 14:01:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 016B132650;
	Mon,  8 Aug 2016 14:01:52 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DEtLCtIa/vZhpGNd1BJZJ4fxGeI=; b=bKIIPp
	IHXwoXUgHUuNEE9vrND0/aXwiWylguHgKiEGWZexHtqlH3F8d99DzXHz9Qo2UleN
	4FH76u39YY8SoyLv7Hy3u6l0Mp7+QMj7S2AEi/iZVG24KtO/2INcaiamCNfOYz8W
	FotRUjQ43X5cF02Nz/AAMWRgFpvi7qe7uHGpM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oMxWitcNaIszygVfsFMzMjZyoR3Baciv
	lngHSpbuolFtiMw7rIRrtcaqRVLDjKK8DA6hWf2NozwHynRWXZjfAQYfTgBzk8Bz
	Lkzn8TA2eqazYHwivSmyKtZAO+7kxAyYa1FjD4B11b91aGGuyUsZZtuYYgpsLhSB
	Oa/rrGDh2uA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ECB633264F;
	Mon,  8 Aug 2016 14:01:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 778543264E;
	Mon,  8 Aug 2016 14:01:51 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] format-patch: Add a config option format.from to set the default for --from
References: <cover.4d006cadf197f80d899ad7d7d56d8ba41f574adf.1469905775.git-series.josh@joshtriplett.org>
	<20160730191111.cd6ay3l4hweyjf7f@x>
	<20160801173847.qph2tora75h6ebsk@sigill.intra.peff.net>
	<20160807225701.ucv2xunq5vs4uedk@x>
	<xmqqtwewggwi.fsf@gitster.mtv.corp.google.com>
	<20160808043458.jrgkoy2i65hxsaeo@x>
Date:	Mon, 08 Aug 2016 11:01:49 -0700
In-Reply-To: <20160808043458.jrgkoy2i65hxsaeo@x> (Josh Triplett's message of
	"Sun, 7 Aug 2016 18:34:59 -1000")
Message-ID: <xmqqa8gnf8c2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2EE91316-5D92-11E6-AD5E-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> writes:

> I didn't realize you had already taken the patch series into next; I'd
> assumed from the various comments that you expected me to reroll it
> before you'd take it.
>
> Would you like me to write something up for the release notes regarding
> plans to change the default?

Given that we are at week #8 and -rc0 is coming soon, I suspect that
that note will happen not in this release but in the next one.

The patch in question (1/2) is merely a new convenience feature that
does not have to say anything about the future default, so we are
good with 1/2 as-is (not v2 version of it, but the original one
without enum), I think.




