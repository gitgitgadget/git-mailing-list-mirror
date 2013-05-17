From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Fri, 17 May 2013 09:22:17 -0700
Message-ID: <7vobc91squ.fsf@alter.siamese.dyndns.org>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com>
	<7v7gj77nt9.fsf@alter.siamese.dyndns.org>
	<CAMP44s1HDp+ojGK0UhKHF=1iDu5_E9Z0VrK-JtMked1mtH_2gQ@mail.gmail.com>
	<CAMP44s3J8YpULYenDoYhyRJXSXL3b8-vpMbW2c4LcjK43Xidng@mail.gmail.com>
	<7vwqqy7v8g.fsf@alter.siamese.dyndns.org>
	<CAMP44s17aD_ryeGWQazTcJ3nrhe6C9TLhKHhrUnys=Yj_ATa0A@mail.gmail.com>
	<7vzjvu6faq.fsf@alter.siamese.dyndns.org>
	<CAMP44s3c1vdCn43S=nSzfj=znZ9L_7jH9-+EOY0+SZNnSBTVbw@mail.gmail.com>
	<7vfvxm6biv.fsf@alter.siamese.dyndns.org>
	<CAMP44s2QcFStPtE8cSbH7jWvUOUVRSgGNYNVoDN6exRdW6xNYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 18:22:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdNQN-0002cl-KB
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 18:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756207Ab3EQQWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 12:22:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42145 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756191Ab3EQQWU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 12:22:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CAFA1FA7A;
	Fri, 17 May 2013 16:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kFMwniHDe7z4QEmNNqc89CtZ+e8=; b=F4J+49
	11jvILt0SFEi+G1UjAP0Fyv0YEDFB8rNfCX/PSvn6IM7RE/UUvWCar+jhZZz1tKy
	R03a7ZLLCagtmMA52/UO3syPEPumrVytNf0r+YBXa64+gRG/haDTI1hQ2rpOxkVL
	g/D4zXOq/VYfMP+K6JSclQ/cFQgbrvs22cG7k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aeARrI8UeUwWJiVPs7qikqtcW/45CdyZ
	1OBg8vBuPrXdFCSdzOpKEVionYU+1GW/wsjsSldSAHCVxPzA7x4R4o2m492MWo6M
	6d5e9otruIiH78KHHkSqXApYlKCtNTUDez4SoqbUS9K1+z64lhRngXNTt3gop8KT
	cZ8FrCjfKUw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82ED71FA79;
	Fri, 17 May 2013 16:22:19 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E664D1FA78;
	Fri, 17 May 2013 16:22:18 +0000 (UTC)
In-Reply-To: <CAMP44s2QcFStPtE8cSbH7jWvUOUVRSgGNYNVoDN6exRdW6xNYA@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 16 May 2013 18:54:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1F7688E-BF0D-11E2-B2F6-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224698>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> *You* are telling my that; it's *your* opinion and nothing else. It's

I saw a review comment that points out that the continuation lines
do not align, and you refused to say "ah, thanks for spotting" and
reroll [*1*], so even I do not want to do so in general, I had to
play the role of the arbiter.

My take on these style issues is this:

 * People made mistakes in the past while doing real work.  Big
   news: contributors and reviewers are not perfect.

 * They survived to this day because we do not do tree-wide "style
   fixes" for the sake of style fix, in order to avoid clashing with
   real work in flight.

 * Existing mistakes are not an excuse for adding new mistakes of
   the same kind, especially when they are pointed out during the
   review (this is not limited to "style issues").

I do not think I would reject a patch with minor style bugs like
unaligned continuation lines, if it were a patch that does real
work.

But a "style cleanups" patch that introduces new instances of style
breakage is a different matter.  It is clear that the original
(picked randomly):

        die ("Encountered signed tag %s; use ",
             "--signed-tags=<mode> to handle it.",
             sha1_to_hex(tag->object.sha1));

wanted the opening double-quotes of two lines and the "sha1" at the
beginning of the third line to align.  I see that is the local style
a "style cleanup" change should follow.

A patch that cleans up styles in preparation for a real work (like
this one) is a rare and precious occasion for us to really clean up
accumulated wart.  I do not want to see existing mistakes from other
unrelated parts of the codebase that have not been cleaned up as an
excuse to waste that rare occasion to do a good job of cleaning up.

So that is the arbiter's decision.  Call it *my* opinion or whatever
you like; it does not change anything.


[Footnote]

*1* That would have ended this thread without wasting everybody's
time.
