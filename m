From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Regulator updates for 3.3
Date: Tue, 10 Jan 2012 19:03:57 -0800
Message-ID: <7vehv77xeq.fsf@alter.siamese.dyndns.org>
References: <20120109073727.GF22134@opensource.wolfsonmicro.com>
 <CA+55aFyhoh0rT_ujuE1w3RpuR7kqivYFwPpm66VC-xtq1PiGUQ@mail.gmail.com>
 <20120110184530.GE7164@opensource.wolfsonmicro.com>
 <CA+55aFxXb7wqfrpozS6iH0k25y-+Uy8_Tavv59JXMhaWrjXLaw@mail.gmail.com>
 <20120110222711.GK7164@opensource.wolfsonmicro.com>
 <CA+55aFxvQF=Bm4ae6euB_UO8otMCuN9Lv37Zn3TpE-L7JH3Kzw@mail.gmail.com>
 <7vmx9v7z1r.fsf@alter.siamese.dyndns.org>
 <CA+55aFx5NATrpLnkMiV2vAxSAJPK7wkY2vyHbyeZGgT9+jP06w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Wed Jan 11 04:04:17 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RkoU0-0002Ch-Qq
	for glk-linux-kernel-3@lo.gmane.org; Wed, 11 Jan 2012 04:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933302Ab2AKDEC (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 10 Jan 2012 22:04:02 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61515 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756535Ab2AKDEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2012 22:04:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 164E55E52;
	Tue, 10 Jan 2012 22:03:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P1BbhF/VdnUBlWIq0b9gyQrFn0E=; b=uNrB78
	xH+HzsIW231p9c7+27/P4scGGtrJZUto4F483yPyJvE6xA63vHsOeOg7MeaHhLp6
	+n2F+dSgwWSBBy9zkbpcn91HeNX5KcXkBZ1TAI4MxazFT8kVX4sd0w5ULO35frm/
	21x1TL6u7mAOw9gYQXRIk8rRUvYavysVKzG1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NkNiQeYrb4Jn3RY9e06HnhISSE+eLMHe
	gCzoARFFTr2PsHRVhAtj/825uCGac7D99ldlgzwfQqwUq9X4+8ZGURNF32z7d/iU
	mvLuxNhzopw/7upGYHFmeSWOUa8hNGY/oIXnVFgROMtmamfTechtm7IqBn+dnKpe
	3hvXhl12U+c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C3095E51;
	Tue, 10 Jan 2012 22:03:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 872CA5E50; Tue, 10 Jan 2012
 22:03:58 -0500 (EST)
In-Reply-To: <CA+55aFx5NATrpLnkMiV2vAxSAJPK7wkY2vyHbyeZGgT9+jP06w@mail.gmail.com> (Linus
 Torvalds's message of "Tue, 10 Jan 2012 18:47:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7DF31B0-3C00-11E1-A48E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188316>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Jan 10, 2012 at 6:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> It is a non-starter to unconditionally start an editor.
>
> I really wonder. Because not being default will always lead to really
> odd ways of saying "it should have been default, so we'll make up
> these complex and arbitrary special rules" (like the ones you were
> starting to outline).
>
> So I really suspect it would be easier and more straightforward to
> instead just bite the bullet, and say:
>
>  (a) start an editor by default if both stdin/stdout matched in fstat
> and were istty().
>
>  (b) have some trivial way to disable that default behavior for people
> who really want the legacy behavior. And by "trivial" I mean "set the
> GIT_LEGACY_MERGE environment variable" or something.
>
>  (c) have a "--no-editor" command line switch so that scripts and/or
> users that want to make it explicit (rather than rely on the hacky
> legacy workaround) can do so (and a explicit "--editor" switch to
> enable people to use a GUI editor even if they aren't on a terminal -
> think something IDE environment, whatever).

Hrm. Lack of any quoted line other than the first line from my message,
together with (c) above, makes me suspect that you did not read beyond the
first line before composing this message you are responding to.

> Yes, git has been very good about not breaking semantics. But it's
> happened before too when it needed to happen. We've had much bigger
> breaks (like the whole "git-xyz" to "git xyz" transition, for example,
> which broke a lot of scripts).

Yes, I am learning from the experience to be cautious ;-)

I dunno. You just scrapped the plan for 1.7.10; it may have to be called 2.0
instead.
