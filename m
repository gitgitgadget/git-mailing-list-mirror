From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] diff: disable compaction heuristic for now
Date: Fri, 10 Jun 2016 14:46:42 -0700
Message-ID: <xmqq8tycemyl.fsf@gitster.mtv.corp.google.com>
References: <20160610075043.GA13411@sigill.intra.peff.net>
	<20160610083102.GA14192@sigill.intra.peff.net>
	<xmqqvb1hf35y.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZLT8AfmWTrrW+a-v7aXw5sm68P2H=vT7QZr2hj4Z2gDA@mail.gmail.com>
	<CA+P7+xp=bTPiwRRTH=h7v5pV8+=he4+789_3PNz227mv1387MA@mail.gmail.com>
	<xmqqeg84gbex.fsf_-_@gitster.mtv.corp.google.com>
	<20160610203026.GA21464@sigill.intra.peff.net>
	<xmqqoa78epmt.fsf_-_@gitster.mtv.corp.google.com>
	<xmqqk2hwepcq.fsf@gitster.mtv.corp.google.com>
	<20160610210516.GC22470@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 10 23:47:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBUGb-00023Z-Gw
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 23:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbcFJVqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 17:46:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50806 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751354AbcFJVqq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 17:46:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 93C8324ACF;
	Fri, 10 Jun 2016 17:46:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U8RGyoIjh0KCNcqeo8kZVTwvOCw=; b=mj17KP
	CCT2n6SW7l8DMx8bsQmSEmkDBeXPQvMgfdcWRuH0OlmCC1hdQ/iPtlMau8GXQYD/
	UO9v6tly7q+qV3bftQnkJJ+GLwC0kYaA8Qcbs3a4u+zG/H1R3qOMkQ+jlEOEPWE3
	MHBUx2KFwjfp3MkTR9vZmbrn30wByJmtbjh6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HPJmJU7pzv5ocqs+9CH6ex1nHNxxliJb
	TtUyI8mmNzuAV4CFK1IB8pRzuI3mAJgVoMeSJ43DmM+Hx2YyZmLU3RhbSYmo90/e
	2IINDJC+C04yCRIXJ9PLUHPTEJSbW/Td8kGDGxzUXsZLEEf+EvEFnTrhNN/G0PIO
	LWgKyndnu1g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8701624ACE;
	Fri, 10 Jun 2016 17:46:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F225424ACD;
	Fri, 10 Jun 2016 17:46:44 -0400 (EDT)
In-Reply-To: <20160610210516.GC22470@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 10 Jun 2016 17:05:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D34AD780-2F54-11E6-838D-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297077>

Jeff King <peff@peff.net> writes:

> Looks good.
>
> I think your calendar calls for release 2.9.0 on Monday. Are you going
> to bump the schedule for this? I don't think it's very high risk, and
> wouldn't need to.

I didn't plan to.
