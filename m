Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FAF920193
	for <e@80x24.org>; Mon,  8 Aug 2016 01:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbcHHB7O (ORCPT <rfc822;e@80x24.org>);
	Sun, 7 Aug 2016 21:59:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63540 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751671AbcHHB7N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2016 21:59:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 50FF93487E;
	Sun,  7 Aug 2016 21:59:12 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jCfXVivaWTDTWA4skTB418zxNHU=; b=VJwIhY
	nm8JU1hikPwJtRoH3lOrNB7QQvt89L9daVzxHFDU1tgdzeDRhMhRVqiyIMdD/6AT
	tYRDE8LS02dm+Pt+BK/p7s+RXawPAvu/G/wbwWaomcVddTs/7C+JMlFh6TGGmvL8
	kOeYYTay5fsPgeHLQqI4aXY2c7fx2cofJoPQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=StHXtKgMUU31aOpB+iPNCAddyQj3QRTK
	/z5XcwumVCWcOIBsK8Fm2VN5bWElgElvKvk6nSwAUPtLsPqZFoaGk2SO97DaMMrj
	jN3WOY2r+7wUOiuLYWLUjhK+vpwhJWcEaXvlqL41emFekPNV3QkL0t6bnyEd3LSe
	woli7BQHwl0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 488B43487D;
	Sun,  7 Aug 2016 21:59:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C2A5D3487C;
	Sun,  7 Aug 2016 21:59:11 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] format-patch: Add a config option format.from to set the default for --from
References: <cover.4d006cadf197f80d899ad7d7d56d8ba41f574adf.1469905775.git-series.josh@joshtriplett.org>
	<20160730191111.cd6ay3l4hweyjf7f@x>
	<20160801173847.qph2tora75h6ebsk@sigill.intra.peff.net>
	<20160807225701.ucv2xunq5vs4uedk@x>
Date:	Sun, 07 Aug 2016 18:59:09 -0700
In-Reply-To: <20160807225701.ucv2xunq5vs4uedk@x> (Josh Triplett's message of
	"Sun, 7 Aug 2016 12:57:01 -1000")
Message-ID: <xmqqtwewggwi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3734FD4-5D0B-11E6-AFB5-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> writes:

> I'd actually seriously considered this exact approach, which I preferred
> as well, but I'd discarded it because I figured it'd get rejected.
> Given your suggestion, and Junio's comment, I'll go with this version.

Sorry, but your response is soo delayed that I am not sure what you
are agreeing with and also am not sure if you are planning to reroll
what has already been happily accepted to 'next', which is not quite
welcome.

