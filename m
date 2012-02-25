From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-subtree Ready #2
Date: Sat, 25 Feb 2012 01:00:41 -0800
Message-ID: <7vy5rrfft2.fsf@alter.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: greened@obbligato.org (David A. Greene)
X-From: git-owner@vger.kernel.org Sat Feb 25 10:01:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1DUw-000388-Nk
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 10:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196Ab2BYJAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Feb 2012 04:00:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47358 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754415Ab2BYJAo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 04:00:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90D925615;
	Sat, 25 Feb 2012 04:00:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1xESiFomMMUp/aqLFtY06ewplrw=; b=vAc0ui
	KmjG0LQguq9WNOw0Ze+vFi7QVRhEFQ1EfJ7FbRIfyuixficCYALymW1qBWxYIDY6
	q/61Pe8lxiRF8GgRzSLaQ8pd3aPAfU+HTpbkuOnq5NyIvCqGUtgUrIuwJ4qsUfRz
	S7la5kGh7a0nKb9QzRZZSRd2sWz3kby7evrvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qXHskKv1mGiYFq0eBiNIysYdFpeDRQHP
	WtvalGpBw2xKQAeMYRZgRC3z+RIyBCHrut8BHGSDNybpIZPEG4AIk8JtF0GXEuJK
	R0ISwMkCLbKcIq+OL501cEsnRizPhd4GR1PXwGFkd+AsFuhLljRVd4ygPinCtchI
	7TPJbWrGN30=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8722A5614;
	Sat, 25 Feb 2012 04:00:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19E945613; Sat, 25 Feb 2012
 04:00:43 -0500 (EST)
In-Reply-To: <87hayfv75y.fsf@smith.obbligato.org> (David A. Greene's message
 of "Fri, 24 Feb 2012 23:00:41 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 32915330-5F8F-11E1-9694-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191509>

greened@obbligato.org (David A. Greene) writes:

> Avery Pennarun <apenwarr@gmail.com> writes:
>
>> Should we filter-branch or rebase the history first, or just leave it as is?
>>
>> Like I said, since I don't expect there to be any more back-and-forth
>> development, rebasing should be pretty harmless.
>
> Catching up on e-mail.  :)
>
> I'm happy to do either (rebase or filter-branch).  Just let me know.

I would understand Avery's "should we filter-branch/rebase, or is it OK
as-is?", but I do not understand what you mean by "either rebase or
filter-branch is fine".

> I'm about the send the test-lib.sh patch separately...

Thanks, this I understand and should not be a part of git-subtree topic.
