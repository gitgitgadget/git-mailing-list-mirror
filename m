From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1410: fix breakage on case-insensitive filesystems
Date: Sun, 09 Nov 2014 09:48:29 -0800
Message-ID: <xmqqtx28b6z6.fsf@gitster.dls.corp.google.com>
References: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com>
	<20141109014354.GA23883@peff.net> <20141109015918.GA24736@peff.net>
	<CAO2U3QiNYCWF_otPnR43gHNA22otR62aC2g8b0CnxVz3rjp7kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 18:48:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnWbN-0000qD-07
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 18:48:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbaKIRsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 12:48:33 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58554 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751274AbaKIRsc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 12:48:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DB251AE32;
	Sun,  9 Nov 2014 12:48:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qkJuHWG2eke0dMEyQuVJ4vfLfzg=; b=n1smuj
	YlbEuSfGkjKk/Ow7QWkj8vXDn5e73J6McN1r/EOmb+D86kIXj10yVlWYz3cZmfmc
	O1G9QpeG3eYjxTqvjEJg0FnzU1hrxTfEf6kv1C3xl1jMFOJ5sWJ/ftMzpu1HPNrK
	yja6qBP3hNPh+L04bY1qmpqRfX2bpCexVH1D8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r4ncURtsMJYQztVqD5EN3SgCIsptXrsj
	NM2ae3wZ0NqCR49HJtuFUrxgxJcbyGjDH1dvYEYX3o3wYDAkRJIFClFEAorn0s8w
	d9a6LuKFaAmW3Qf1sWB1HtUiVECxE0kWwTDbeyn/4c2DpvohkWVvVJaTelQSDH9u
	LLXRJHdNqWE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 33FDF1AE31;
	Sun,  9 Nov 2014 12:48:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C20401AE30;
	Sun,  9 Nov 2014 12:48:30 -0500 (EST)
In-Reply-To: <CAO2U3QiNYCWF_otPnR43gHNA22otR62aC2g8b0CnxVz3rjp7kQ@mail.gmail.com>
	(Michael Blume's message of "Sun, 9 Nov 2014 09:34:34 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9E1BB46A-6838-11E4-A70F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Blume <blume.mike@gmail.com> writes:

> Works for me, thanks =)
>
> I'm curious now, is there an automated build of git running on a mac
> anywhere? There's a mac mini running jenkins in my office and it's
> possible I could convince someone to let me set up a git build that'll
> e-mail me if there's a test failure.

I am not aware of a Macintosh person who regularly runs tests, but
if there were, we hopefully will hear from them soonish ;-).

Thanks for the offer, we would definitely want to take you up on
that, if there is nobody doing that already.
