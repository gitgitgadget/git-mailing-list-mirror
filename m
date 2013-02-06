From: Junio C Hamano <gitster@pobox.com>
Subject: Re: CodingGuidelines Perl amendment
Date: Wed, 06 Feb 2013 08:29:30 -0800
Message-ID: <7vvca5mmmt.fsf@alter.siamese.dyndns.org>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
 <7vvcafojf4.fsf@alter.siamese.dyndns.org>
 <20130130074306.GA17868@sigill.intra.peff.net>
 <7v7gmumzo6.fsf@alter.siamese.dyndns.org> <87pq0l5qbc.fsf@lifelogs.com>
 <20130131193844.GA14460@sigill.intra.peff.net> <87k3qrx712.fsf@lifelogs.com>
 <20130203194148.GA26318@sigill.intra.peff.net>
 <87sj5cvxnf.fsf_-_@lifelogs.com> <7vk3qo2dsc.fsf@alter.siamese.dyndns.org>
 <87k3qoudxp.fsf@lifelogs.com> <7vvca7291z.fsf@alter.siamese.dyndns.org>
 <87lib3uats.fsf@lifelogs.com> <7v7gmn1xqi.fsf@alter.siamese.dyndns.org>
 <871ucto4vj.fsf_-_@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 17:30:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U37sk-0005wE-AO
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 17:29:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757597Ab3BFQ3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 11:29:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37512 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754132Ab3BFQ3e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 11:29:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABC15CC94;
	Wed,  6 Feb 2013 11:29:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vla2tlseC/vixLB+7RMVwhiMgVU=; b=PZr7/4
	6j0AilEBCdqwhucSbcsfz/NUWJZAUVj/ndSvi7v3PwMmF4NZeDGVED6BnednDQRZ
	8GA/FOrRoWnYO9AAC6mKLSgIUgUaWBp2KpH1Vk2jl8tHn85hpgrsZOMkIk9hN+I6
	PtUuutcbGCAuSyX0uTUKueDDKeXNvYnZnvqyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DaIOJ3RluLXzSPxYGO+qKjK8HSR3+sAR
	GtJjEb+z7kSj8q1iSaxv53zpkTL8Dub785fFMOugMPtvmoPglMDOAA7AQUJiFYDv
	1oWxFcsT6WrHvQrHKz3Gu18kL/hXngfvQcU4l5eeOtkgmAv4DDxIMpAzOnmp2ViE
	KcpvkiCd/70=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FED1CC93;
	Wed,  6 Feb 2013 11:29:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7AAACC91; Wed,  6 Feb 2013
 11:29:32 -0500 (EST)
In-Reply-To: <871ucto4vj.fsf_-_@lifelogs.com> (Ted Zlatanov's message of
 "Wed, 06 Feb 2013 10:10:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 634E1C72-707A-11E2-BD05-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215596>

Ted Zlatanov <tzz@lifelogs.com> writes:

>  - As in C (see above), we avoid using braces unnecessarily (but Perl
>    forces braces around if/unless/else/foreach blocks, so this is not
>    always possible).

Is it ever (as opposed to "not always") possible to omit braces?

It sounds as if we encourage the use of statement modifiers, which
certainly is not what I want to see.

You probably would want to mention that opening braces for
"if/else/elsif" do not sit on their own line, and closing braces for
them will be followed the next "else/elseif" on the same line
instead, but that is part of "most of the C guidelines above apply"
so it may be redundant.

>  - Don't abuse statement modifiers (unless $youmust).

It does not make a useful guidance to leave $youmust part
unspecified.

Incidentally, your sentence is a good example of where use of
statement modifiers is appropriate: $youmust is rarely true.

In general:

	... do something ...
	do_this() unless (condition);
        ... do something else ...

is easier to follow the flow of the logic than

	... do something ...
	unless (condition) {
		do_this();
	}
        ... do something else ...

*only* when condition is extremely rare, iow, when do_this() is
expected to be almost always called.
