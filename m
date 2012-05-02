From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/18] do_for_each_reflog(): use a strbuf to hold
 logfile name
Date: Wed, 02 May 2012 13:06:58 -0700
Message-ID: <7vwr4ugxel.fsf@alter.siamese.dyndns.org>
References: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
 <1335479227-7877-9-git-send-email-mhagger@alum.mit.edu>
 <xmqqaa1y6poq.fsf@junio.mtv.corp.google.com> <4F9A5FE6.40409@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 02 22:07:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPfpO-0001gS-Mb
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 22:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756892Ab2EBUHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 16:07:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55716 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756196Ab2EBUHB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 16:07:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 091F47CFD;
	Wed,  2 May 2012 16:07:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1li4t7dVW9alevnxDKhmudTzWMY=; b=KFJ9ij
	qYN2rYBGCkr1tY7wD06OgjgMfaVXi9zmgkjEMYvM8B+WrH9pcPANV7ZQfv/WBkdh
	R2K7zMHZam7s92lcp6FSzRo+9IrSk6JCOkb1MJvsdzDRJKFL27BENg67iO2xSy94
	13/xfi3fBnidXxObN/JwpiwspUHEK2Z29s7cw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DV3hG8Syh/UPdRQPTORbGBcHsBV4+97c
	KrCgvIywCUhb5nTlNAuHjqHGYrr0NgTo7KD7fX5vW91zmd0GAllrag4DAPEdz5Q0
	RiYGWKDZI8WhjKeWNBsSyi5p4X5VcpgtOnwRxryMvB3UKkYI5HV9q3NwCLAnTt8P
	nVPPpWpfG+E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDC4A7CFB;
	Wed,  2 May 2012 16:07:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 660B97CF8; Wed,  2 May 2012
 16:07:00 -0400 (EDT)
In-Reply-To: <4F9A5FE6.40409@alum.mit.edu> (Michael Haggerty's message of
 "Fri, 27 Apr 2012 10:59:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6098D0E0-9492-11E1-8543-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196859>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 04/27/2012 01:25 AM, Junio C Hamano wrote:
>> Please write this like this:
>>
>> 		if (...) {
>> 			; /* silently ignore */
>> 		}
>>
>> to make the "emptyness" stand out (I amended the previous round when I
>> queued them to 'pu', but I forgot to point it out in my review message).
>
> OK.  A similar construct is in patch 2 of the same series.  I've fixed
> them in my repo and will use the fixed versions if there are any
> future re-rolls.

OK.  Has there been any re-roll I missed, or is what I have in 'pu' with
fixups ready for 'next'?
