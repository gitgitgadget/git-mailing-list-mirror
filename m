From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-subtree Ready #2
Date: Mon, 27 Feb 2012 13:06:02 -0800
Message-ID: <7vobsk56md.fsf@alter.siamese.dyndns.org>
References: <877gztmfwy.fsf@smith.obbligato.org>
 <8739acra5j.fsf@smith.obbligato.org>
 <20120215050855.GB29902@sigill.intra.peff.net>
 <87sjicpsr1.fsf@smith.obbligato.org> <87ty2ro1zf.fsf@smith.obbligato.org>
 <20120220205346.GA6335@sigill.intra.peff.net>
 <7vd399jdwc.fsf@alter.siamese.dyndns.org>
 <CAHqTa-2s1xbAfNvjD7cXBe2TBMs1985nag1NOYVfE+dATvfEWA@mail.gmail.com>
 <7vobsox84l.fsf@alter.siamese.dyndns.org>
 <CAHqTa-1fbi5W7R2fLu3bp7Yuv_ZB9nxhgjHkLGuU8-V4016+JA@mail.gmail.com>
 <87hayfv75y.fsf@smith.obbligato.org>
 <7vy5rrfft2.fsf@alter.siamese.dyndns.org>
 <87ty2ft0tm.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: greened@obbligato.org (David A. Greene)
X-From: git-owner@vger.kernel.org Mon Feb 27 22:06:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S27ls-0006zI-KF
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 22:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755099Ab2B0VGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 16:06:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60493 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754992Ab2B0VGF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 16:06:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E85D56B05;
	Mon, 27 Feb 2012 16:06:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GFIZVWHuXTFPVHA4b61rX73XW7A=; b=htqsce
	nra7Z/6GgFdjQTSYkSczCitaK24lyVBvIU8GsSb6xtaRIpHya0HWaIyiHfjvAAhi
	fdN4GfmawjKM+dd4/ZJiGytzHTV66F9i9w5B4rvks7hwJa+ZxqDuyCVBsmlsr9P4
	VbzEVN9001+WI+oEzwq/V/nc+LwpAmE3mRRiY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uc8l9jjFt2vbfAfLOmLljat05WwK6sX2
	0y7zxgrkupIxjbGyUlsPbP5+DeYUt6dfHT8V1mio/wMTS8nhFT/ctYmw+J3brbes
	O9KC3t9OPdczUQr1rIXRlOMl7rp1QAWwzTLBxrYHdgnRV3tyBn2sB7yQOfW5JpY3
	iv0Pe/tNEMI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFF0D6B04;
	Mon, 27 Feb 2012 16:06:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4794C6B02; Mon, 27 Feb 2012
 16:06:04 -0500 (EST)
In-Reply-To: <87ty2ft0tm.fsf@smith.obbligato.org> (David A. Greene's message
 of "Sat, 25 Feb 2012 09:00:37 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC0B4288-6186-11E1-8FA4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191671>

greened@obbligato.org (David A. Greene) writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> I'm happy to do either (rebase or filter-branch).  Just let me know.
>>
>> I would understand Avery's "should we filter-branch/rebase, or is it OK
>> as-is?", but I do not understand what you mean by "either rebase or
>> filter-branch is fine".
>
> Sorry, got mixed up there.  I'm not that familiar with filter-branch.
> Now I understand you do both.  :)
>
> So have we decided to keep the history?

I think the discussion so far was:

 - Peff suggested to keep the history with a true merge;

 - I said the history before the final commit in Avery's tree did not look
   so useful for future archaeology; and then

 - Avery corrected me that there are contributions by other people and the
   credits will be lost if we discarded the history;

and everybody (including me) now favors to have the history.

So the answer to your question is yes, but I do not think we heard opinion
from anybody regarding the question by Avery yet.  I personally do not see
how it would help us if the old history is rewritten at this point.
