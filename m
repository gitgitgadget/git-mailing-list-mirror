From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/Makefile: retain cache t/.prove across prove runs
Date: Sun, 20 May 2012 14:18:17 -0700
Message-ID: <7vvcjqa6w6.fsf@alter.siamese.dyndns.org>
References: <1335972712-20621-1-git-send-email-mhagger@alum.mit.edu>
 <20120502160753.GA7193@sigill.intra.peff.net> <4FB7B429.80805@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun May 20 23:18:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWDWD-000123-JH
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 23:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756497Ab2ETVSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 May 2012 17:18:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53119 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756058Ab2ETVSU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2012 17:18:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7098815B;
	Sun, 20 May 2012 17:18:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0Rw3UckZC91khn9yu/9ur+oUXE0=; b=Ztc7Dd
	4NlojVLLTWjv07aX9r0BugY+HnErVnMQP/CXRTLI/V+YkZUD6xLu1EveaOhTYUVa
	EtD8CsGPREoZWZR20ctA2x8UiBWR22CZLmT83i2nVoKJWaBMaTurhGt1H560501J
	3f7lp8UgdlvO+Hcrvqo8RL9fBInTRGo88bN7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DuWmMlyfJZ+YLSFoEt6z6MV+g6mZZ1qb
	E7gWaeaKDNDmthVnaOs4mB8WS5RGFaOyF/gJWbBjQfxx1H6gDGB7xUjG218slsv0
	9ghFXclYcZqy0d2jeHxnZteZflx5Z8In1631HGPWc2/LdHZpTDB6c5UyLThF2iCR
	52aLaaFehLA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADE8F815A;
	Sun, 20 May 2012 17:18:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46CA88158; Sun, 20 May 2012
 17:18:19 -0400 (EDT)
In-Reply-To: <4FB7B429.80805@alum.mit.edu> (Michael Haggerty's message of
 "Sat, 19 May 2012 16:54:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 526BBA9A-A2C1-11E1-AACD-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198071>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I still think my patch makes sense.  The error that Peff pointed out
> was in my commentary, not in the patch itself or in the log message.
> Junio, is there something else keeping you from applying this patch?

No.

I was waiting just in case if anything other than "Ah, that does indeed
not work but it does not mean this patch is wrong" comes out (e.g. "With
the patch it does not work as pointed out, but I made it also work by this
reroll, which also is correct") to avoid the trouble of applying and
replacing.

Thanks.
