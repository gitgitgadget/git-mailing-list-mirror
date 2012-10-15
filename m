From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Patch 3/5] Create html documents for all files in
 Documentation/RelNotes
Date: Mon, 15 Oct 2012 13:49:12 -0700
Message-ID: <7vhapvwjef.fsf@alter.siamese.dyndns.org>
References: <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net>
 <343092834.269729.1349538958985.JavaMail.ngmail@webmail08.arcor-online.net>
 <20121006192105.GA17895@sigill.intra.peff.net>
 <7vmwzyovg3.fsf@alter.siamese.dyndns.org>
 <507BF806.1030709@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Thomas Ackermann <th.acker66@arcor.de>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 15 22:49:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNrbL-0006SU-1w
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 22:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812Ab2JOUtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 16:49:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46088 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754634Ab2JOUtP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 16:49:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 619478921;
	Mon, 15 Oct 2012 16:49:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PVAOPnkkiHZYDit43C3BjgFyBOo=; b=jX3jEN
	HmB3fKLk2+TIzNklX7hUORq3F4LrjXDUIW337K/JHzmFdEjtdT0ChjRFaFM0WI4S
	qwhRqPuSkFDuQkxOPxxiIyE1fQYQvY2B9ZGxxR2j0VF8grs7a0nkYOzZwP9G76zk
	vWL53cm+6B/06ZHvCqNz1+OqplYTvnQEW0RgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eyf50sumVf2Xo/+sQ90SCTsYa3PNgsMk
	iUdQDRW6tC9XqaiEXfyeuUy+tFaauaIaH1tR9cINq8CJKo945pPpRy4ONvom/NCb
	Jm3GghCCXohq33KZcx9E56gpyNTJ5tB4hlh8Fp6q+ayDK4w6i8P+jYwyNe6Fskh1
	yz3nLhvCKfY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F9E48920;
	Mon, 15 Oct 2012 16:49:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6D19891F; Mon, 15 Oct 2012
 16:49:13 -0400 (EDT)
In-Reply-To: <507BF806.1030709@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon, 15 Oct 2012 13:48:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C721EF3C-1709-11E2-90C9-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207777>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 07.10.2012 22:53:
>> Jeff King <peff@peff.net> writes:
>> 
>>> [1] I would not be surprised if they do not actually format all that
>>>     well. Though they are written in an asciidoc-ish style, they have
>>>     not traditionally been formatted, and I suspect there are many small
>>>     errors (like improper quoting of metacharacters) in them.
>> 
>> They aren't even "errors". As far as I (who writes the release
>> notes) am concerned, they are straight text without any asciidoc
>> or markdown mark-up.
>
> I'm wondering: If it's neither markdown nor markup then what is it:
> marklevel, markeven or markstraight?

They are called plain text.

> On a different note: Is pdf really the format of choice for mobile
> platforms? I'd expect something that is "formatted" (markup) but can
> reflow text intrinsically, not only by making your pdf reader jump
> through hoops. HTML?

Yeah, I've been wondering if epub or something might be a better
target myself.
