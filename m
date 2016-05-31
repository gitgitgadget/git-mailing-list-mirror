From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0005: ksh93 portability workaround
Date: Tue, 31 May 2016 16:17:01 -0700
Message-ID: <xmqqwpm924ya.fsf@gitster.mtv.corp.google.com>
References: <xmqqinxt3kwq.fsf@gitster.mtv.corp.google.com>
	<20160531230301.GB4585@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 01 01:17:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7suN-0005t4-Fi
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 01:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbcEaXRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 19:17:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60064 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750730AbcEaXRG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 19:17:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 34EBE20354;
	Tue, 31 May 2016 19:17:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CL7FSYPqa9FQGhkovMKhRFZjf9k=; b=e0VMBf
	XTuNn5svtwAYdofLT/8tbycFvtbcNxoN5kFbk2aMYRHqvWEz9Qa880nGxN0yHXNv
	CSlmVC3xG+7ihS0HHO2ZSa2BiPzvEkH823pa6oLXMfkA41h+2gzgn6kmpQNMGQaL
	uGTerJHkTQ3lSc/DxaCbw9/ggrFf6fh0ALJ8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DSWljrs4LcNs9WkKhDiN/Ue/7WCqHAYG
	tFmhxHjChKlQFr9T6qbehKeQtcJbg3wq35/Pa43VpQRCkOMhOi1ntFkU/2d8XmPe
	53IdqE6L+oRi0DS7yP0Ipnddu3bP1UWisrdc6mrEepQH0ygHsvT+RFxWn5B0MV2v
	XKVEtDW+y9o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D4AE20353;
	Tue, 31 May 2016 19:17:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A644620352;
	Tue, 31 May 2016 19:17:03 -0400 (EDT)
In-Reply-To: <20160531230301.GB4585@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 31 May 2016 19:03:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C8F366FC-2785-11E6-BAA6-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296036>

Jeff King <peff@peff.net> writes:

> Hmm. We discussed these back in:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/268657
>
> but I thought we decided not to do anything about them (according to
> that thread, I found a bunch of other ksh93 oddities, but maybe we've
> since fixed them?).

OK, I completely forgot about that topic.

Sorry for the noise.  Let's drop it.

Thanks for reminding me of that thread; I would have been stumped
with the "cd ../.git/objects" thing and wasted a lot of time.
