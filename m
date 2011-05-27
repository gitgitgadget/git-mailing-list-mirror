From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Whitespace and '&nbsp'
Date: Fri, 27 May 2011 15:47:37 -0700
Message-ID: <7vy61rrcae.fsf@alter.siamese.dyndns.org>
References: <BANLkTik7eJ=BC9Bekqu-W1-r0cheCjC+wg@mail.gmail.com>
 <7vzkm9unu0.fsf@alter.siamese.dyndns.org>
 <BANLkTi=hYR4ow1eMR3rHkMuVRsHJ=TFDZA@mail.gmail.com>
 <m262owhyuy.fsf@igel.home>
 <BANLkTimPfN6LQBhWj6rW3Zcm9JHPsMWsjA@mail.gmail.com>
 <7vipswro57.fsf@alter.siamese.dyndns.org>
 <7vboyorm4i.fsf@alter.siamese.dyndns.org>
 <BANLkTinwOr5Yzp_N6BNyNK5Y1FcVtdtbUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 28 00:47:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ5ot-0004B3-Vk
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 00:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146Ab1E0Wrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 18:47:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33127 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499Ab1E0Wrr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 18:47:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 26CA85A96;
	Fri, 27 May 2011 18:49:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9moqUeGaxX2OKBWIWW6V/+dCJiY=; b=kfedon
	LWqqRrj8bDN3RdOBLwjYpV13faKDmEBzTZ7HrPv3kpuTWlUV1bKYQrINuqXVRafR
	vGccuwjuqJ4puhfJRUNEr1ZQFIOag6197A5ahTF31rWcZffN1nSzI2JnktKMqdNM
	OBGOTSKcGCpnT3TEuuuBicaDrLj+/VIFu7XJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aqN10Il05k/cGS0kmfNqxfld999jmXNs
	8rk6BSAyOuIoCkDcB8Fo5/vvPQOvhsqkf5aGIc2dKNWIQG8MZf1BIN7a4a1zhv0f
	ISoheL4tmcBpWtvBBtYRF6nDj6h7Wcc1VhTlrwENWRIBpXJ9rhOzfXBzFpdIW3uc
	Yn0l9bDEXjM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EAD0C5A95;
	Fri, 27 May 2011 18:49:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CA1615A94; Fri, 27 May 2011
 18:49:45 -0400 (EDT)
In-Reply-To: <BANLkTinwOr5Yzp_N6BNyNK5Y1FcVtdtbUw@mail.gmail.com> (Linus
 Torvalds's message of "Fri, 27 May 2011 14:14:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A0C316B2-88B3-11E0-A186-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174650>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Again, I'm not convinced git should really care, but I'm also not
> convinced that sbsp is necessarily all about the git whitespace
> fixups.

I am not convinced git should care, either, but if nobody else helps us,
we need to help ourselves ;-).
