From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Thu, 18 Apr 2013 14:37:53 -0700
Message-ID: <7vvc7j4j0u.fsf@alter.siamese.dyndns.org>
References: <7vd2ttgoyr.fsf@alter.siamese.dyndns.org>
	<87wqs1xi9h.fsf@hexa.v.cablecom.net>
	<7vk3o1f5kb.fsf@alter.siamese.dyndns.org>
	<7vwqs1dnxp.fsf@alter.siamese.dyndns.org>
	<20130417201056.GA2914@sigill.intra.peff.net>
	<7va9owd3d1.fsf@alter.siamese.dyndns.org>
	<20130418172714.GA24690@sigill.intra.peff.net>
	<7vd2tr6833.fsf@alter.siamese.dyndns.org>
	<20130418180017.GA5714@sigill.intra.peff.net>
	<7v61zj66wu.fsf@alter.siamese.dyndns.org>
	<20130418203035.GB24690@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 18 23:38:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USwWm-0007xW-J1
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 23:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048Ab3DRVh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 17:37:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63255 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781Ab3DRVhz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 17:37:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D7441709B;
	Thu, 18 Apr 2013 21:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5l+WLyk21/FvUNebCz4MkXQwQmE=; b=k7SkS9
	aQPFQUEv2edR64u8I1KCwkLDBaiECOAeZiTayDwbp0/I2qvCaLRvFdVXVL56FLXc
	By09WMa5GI7yzJGgpN4+IIjXcJZGa3J+A6McqhacYLq9qxMKPsP4phEKXGgIZxry
	gvvEu0NW4tQVP6xaqjcTES0SZNqofX8odtLNs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PXhoWJm9QTToB6d9IJaQxN5i0MXMTunm
	GDXE7zP9GnPR86TBOMp8apthjOI8Cp/0d9Cndd7Vq6LlRTXWON0RIMLDMEzthAVB
	VGVTiHOEs3AuwSIzUp+M2DTfavYBD7Ey7KHhLHa9VWMEKFAXLALozDZD1cXKKdOa
	Lj1HkTXw/6c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 126EF1709A;
	Thu, 18 Apr 2013 21:37:55 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7539917098;
	Thu, 18 Apr 2013 21:37:54 +0000 (UTC)
In-Reply-To: <20130418203035.GB24690@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 18 Apr 2013 16:30:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A7221F8-A870-11E2-9025-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221695>

Jeff King <peff@peff.net> writes:

>> But I think we are doing users a disservice by listing tons of
>> paths.  Where the difference of versions matters _most_ is when the
>> user has tons of removed paths in the working tree.  Either with one
>> warning per path, or a block of collected paths at the end, we are
>> scrolling the more important part of the message up.
>
> I'm not sure I agree. Even with a handful, it made me wonder why one was
> mentioned and not others. That _could_ be cleared up by rewording (i.e.,
> making it clear that this is an example, and there may be more). But
> somehow listing them is what I would expect. Perhaps because it gives
> the user a clue about what to do next; they ask themselves "did I want
> those updated or not?".
>
> In the orphaned-commit message when leaving a detached HEAD, we collect
> the answer, say "you are leaving N commits", and show the first 5 five
> of them, with an ellipsis at the end if we didn't show them all.  Would
> it makes sense to do that here?

Because this is to help people who are _used_ to seeing "git add"
not take the removals into account, I doubt that "Did I want those
updated or not?  Let me see the details of them." will be the
question they will be asking [*1*].

I dunno.


[Footnote]

*1* "I know I didn't want to include these removals to the index,
but I learned today that in later Git I should make myself more
clear if I want to keep doing so; thanks for letting me know.", or
"I've long been assuming that I have to say 'git add' and 'git rm'
separately, but I learned today that I can say 'add --all', and in
later Git I do not even have to; thanks for letting me know." are
the two reactions I expected.
