From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] SubmittingPatches: Document how to request a patch
 review tag
Date: Fri, 04 Jan 2013 13:47:58 -0800
Message-ID: <7v4niwtyb5.fsf@alter.siamese.dyndns.org>
References: <7vy5gb33f9.fsf@alter.siamese.dyndns.org>
 <1357333116-6971-1-git-send-email-jason.k.holden.swdev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jason Holden <jason.k.holden.swdev@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 22:48:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrF7m-00061N-Jl
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jan 2013 22:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519Ab3ADVsD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2013 16:48:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57119 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755254Ab3ADVsB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 16:48:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D5A0BDF7;
	Fri,  4 Jan 2013 16:48:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UIBHKsn1uUv/aHT/tkW8bwLDBXs=; b=jhWoex
	milGUGadjRxsPXyttTHrcj9iUEpP9jqKHWh4uxfEQ4mdKM1U+A+V1rSTx0iWpqPh
	NQiDegF2Wg6tn9/D4nAXhi+qcMyc6jcrVKxs+1USw1YomV1b9Q2eJBKodDGMG30r
	o28ACupPtp1x2A3tTCJHHxdGGU9qoTKCBi/Ro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LjC+wzT1vaX13FkKoZo0/0Vlz2UlWGQN
	KGhEM9+OXMz8OQXW3J3k0GOGxg3YUlOqltr6jSvrYynp0b48FY3LEQ7r8IVRpk2r
	q51fbwCwz8fvKbbscJ5Ud4wqaWRZ7qtnt/Atrm1h+CuK2pTAaQitZSFs07agNVNw
	2ULUp6hPA1s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09477BDF6;
	Fri,  4 Jan 2013 16:48:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 306F7BDF4; Fri,  4 Jan 2013
 16:48:00 -0500 (EST)
In-Reply-To: <1357333116-6971-1-git-send-email-jason.k.holden.swdev@gmail.com> (Jason
 Holden's message of "Fri, 4 Jan 2013 15:58:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 688519B0-56B8-11E2-B4C8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212646>

Jason Holden <jason.k.holden.swdev@gmail.com> writes:

> A very similiar question was asked previously in:
> http://thread.gmane.org/gmane.comp.version-control.git/185564/focus=185570

"Reviewed-by" is for those who are familiar with the part of the
system being touched to say "I reviewed this patch, it looks good",
and Michael indeed was involved in recent updates to the refs.c
infrastructure, so as he said in his message "it looks like I should",
it was the right thing to do.

I do not think Michael was asking if that was the standard _thing_
to do; I think the question was if there was a standard _way_
(perhaps a tool) to send such a "Reviewed-by:" line.

> This will apply on top of your last tweak to SubmittingPatches
>
> Please add my reviewed-by to the rest of the patches in this series.

I do not think you "own" anyting in SubmittingPatches document,
though; at least not yet.
