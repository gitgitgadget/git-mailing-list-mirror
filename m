From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] check-ref-format --print: Normalize refnames that
 start with slashes
Date: Sat, 27 Aug 2011 11:30:26 -0700
Message-ID: <7vty92adv0.fsf@alter.siamese.dyndns.org>
References: <1314418364-2532-1-git-send-email-mhagger@alum.mit.edu>
 <1314418364-2532-2-git-send-email-mhagger@alum.mit.edu>
 <4E58710B.60507@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, cmn@elego.de
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Aug 27 20:50:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxNxE-0002Sl-5U
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 20:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302Ab1H0St6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 14:49:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41529 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974Ab1H0St6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 14:49:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4307639D1;
	Sat, 27 Aug 2011 14:49:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=mbdokqWc9iL49k0gODOMeBaI6Pk=; b=GuW63Wht3AJZn5cE/qEB
	V1bQEg/nOMjmvjXnSMl+nMu5+pZ6I1Tj4NNpyCgoY18wdcHbOMS8O6gP9T1Q0hb/
	wc1Tx/Hh0oi0HGdxqyQp+fjxrxrY30bCGhKjwtnB8TU9mpZoCz8IwqL65UO4EujF
	5m+Nb/I8Uu8ghPLMb15F6SA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=dWM6fuD30pBQwFsMCyopISZ2ZPeEGb73t3kmo211DEEGjp
	I/YOgk4k7942GLTZjgF2qauk14XkC3FGNcKCL3hYcqYYEFtShZw/+d3ogPeop9HF
	VIQ7MKt6pn6FG8qTTQ/GETcL8LOsLyKFlACRYVjJ1I60nKbitxGQ7TuogfXCY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A3B039D0;
	Sat, 27 Aug 2011 14:49:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AEA3139CF; Sat, 27 Aug 2011
 14:49:56 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5BC79412-D0DD-11E0-967C-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180237>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 08/27/2011 06:12 AM, Michael Haggerty wrote:
>> And add tests that such refnames are accepted and normalized
>> correctly.
>
> ...oops, I just noticed that you have committed a this same patch to pu
> already, but with a better log message.  Please retain that version.

Thanks. Very much appreciated.

It sometimes gets frustrating to see a re-rolled submission that ignores
the fix-ups to messages and patches I make locally before queued to 'pu'.

It is easy for me to say that they should fetch 'pu' to see what is queued
before resubmitting, but I've been wondering if there is a better way to
communicate back such differences, so that submitters can easily sanity
check to see if my fix-ups are sensible, and to ensure that the re-rolled
patches do not discard them by mistake before submitting.

I could post what are queued in new topics back to the list as part of
ack, but that would make the list too noisy to read.
