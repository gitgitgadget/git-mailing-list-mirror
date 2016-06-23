Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1C891FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 19:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbcFWTDt (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 15:03:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51308 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750876AbcFWTDt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 15:03:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 21911268DA;
	Thu, 23 Jun 2016 15:03:48 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jnEXfdKcqM28K3UtngvikxAtcqE=; b=oMQ2vp
	gsLKS5D6SFPNIe8QZHAzev4t51nHNey+pzudgpzEqqiYLEqoWV1wKy4tKjinDDod
	jBYJkoQyCjEWt/8IO4IE77iLnWlUlYbnyV1eZokYL5jOj2hsLsw27KPPVo/3Tmpa
	W4YBSkPGQKyy2F4j1gCYYHo1NsMZkeYrDeaKA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bSS4DOUEhcuHm43wdRt41RS+GuVIaR5u
	VyzmMtr9bWL3HOeMyXuS3lbI+3xgnyrwjNCSGbwTG1OJuvaXZ+3l8DvRCjNiQFfY
	XvQG9EaTwFSav6ioeILlOhin69dk6ta4xfeFfjErmFD0Y+wSxt0lyVSCsnhUethu
	oaZdFAvMOzY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A4D1268D9;
	Thu, 23 Jun 2016 15:03:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 96B9A268D8;
	Thu, 23 Jun 2016 15:03:47 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	git@vger.kernel.org
Cc:	Jeff King <peff@peff.net>, Simon Courtois <scourtois@cubyx.fr>
Subject: Re: [PATCH v2 7/7] color: support strike-through attribute
References: <20160623173048.GA19923@sigill.intra.peff.net>
	<20160623174015.GG15774@sigill.intra.peff.net>
	<xmqqpor7iwgo.fsf@gitster.mtv.corp.google.com>
	<20160623183907.GA32368@sigill.intra.peff.net>
	<xmqqlh1vivp8.fsf@gitster.mtv.corp.google.com>
Date:	Thu, 23 Jun 2016 12:03:45 -0700
In-Reply-To: <xmqqlh1vivp8.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 23 Jun 2016 11:52:51 -0700")
Message-ID: <xmqqh9cjiv72.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36E42FA6-3975-11E6-96A1-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> What is sad for me is that I usually work in GNU screen, displaying
> on either xterm or gnome-terminal.  Without screen, strike shows but
> inside it I cannot seem to be able to get strike-thru in effect.

... which unfortunately is expected.

https://www.gnu.org/software/screen/manual/screen.html#Control-Sequences
(look for a string "Negative Image" that appears only once)
indicates that 9/29 are missing.

Not fun X-<.
