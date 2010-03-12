From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not strip empty lines / trailing spaces from a commit
 message template
Date: Fri, 12 Mar 2010 15:13:22 -0800
Message-ID: <7vy6hxnnfx.fsf@alter.siamese.dyndns.org>
References: <4B97C157.4020806@gmail.com>
 <20100311081213.GA13575@sigill.intra.peff.net>
 <20100311083148.GA13786@sigill.intra.peff.net>
 <7vaaueziv8.fsf@alter.siamese.dyndns.org> <4B9A74CA.4080507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 13 00:13:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqE2y-0002RY-7y
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 00:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933529Ab0CLXNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 18:13:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51626 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932279Ab0CLXNa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 18:13:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 70008A1C5A;
	Fri, 12 Mar 2010 18:13:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=14HaxVo6It6pF4qWETAyWVdBspQ=; b=UZzO6g
	j3lRR2tVYvOyWvtCHi+1QEYVj88NXYnF2BZcbbmYsDcXnIlidqpbPBAuhsNYopgj
	y+b/rkosPMcANXfev41ltDAljc7fPij8f6L7L7qE72UqbWj4KtkWqmYRsiKzeC8t
	S1DIqinwJK06ZSu9Gde4oZyrhSTa4oE70FePk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l5O8mQlVSsKPUEGUaZvjwku/grnChPxc
	toXBVoSby3UsRHWwSKZoPHlwPjBOrBtfJCEhOTxOfhU55oCtYTBcgAdP7avxhNUY
	y/fHwS4kyTDCjHrN48EGIlWXd489lZVK7hVilJFql8GbP62Nsj7P5rr+EsnzaARn
	DEbkon3Znkw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D457A1C58;
	Fri, 12 Mar 2010 18:13:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84ADCA1C53; Fri, 12 Mar
 2010 18:13:23 -0500 (EST)
In-Reply-To: <4B9A74CA.4080507@gmail.com> (Sebastian Schuberth's message of
 "Fri\, 12 Mar 2010 18\:07\:22 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DD64BBEE-2E2C-11DF-BA74-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142069>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Anyway, Junio, do you think it would be necessary to introduce a new
> test for this, or can I resend with just your improvements applied?

If you can promise that you will around on this list forever, and that
every time somebody posts patches to builtin-commit.c and the code in
related areas, you will make sure that the changes do not inadvertently
break this feature and respond to the patches that do break it before they
hit my tree, then theoretically we do not need to have any test to make
sure this feature keeps working as advertised.

If you cannot make such a time committment, one alternative that is
presumably easier for you is to have me run the test as part of the
regular patch acceptance test cycle.

Your choice ;-)
