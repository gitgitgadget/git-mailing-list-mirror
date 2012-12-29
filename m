From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use longer alias names in subdirectory tests
Date: Fri, 28 Dec 2012 19:42:18 -0800
Message-ID: <7vsj6pfrs5.fsf@alter.siamese.dyndns.org>
References: <1356735786-24001-1-git-send-email-aaron@schrab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 04:47:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TonOh-0008FL-8r
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 04:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111Ab2L2DmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 22:42:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35174 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891Ab2L2DmV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 22:42:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FF86AE2A;
	Fri, 28 Dec 2012 22:42:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EzGLyhQtFqgdZPUfQH//qMTZCa4=; b=BkijUO
	z+e0s6iE2BpPWXSQ7Aa8bdDEjjYE43nZ51AVy1fHZPTEY/eEkMc1OECuuSFRHPr1
	ArhzRmt0QrEd3Ycg8r1ONTJp8U+8aEnVsAM3btX8R7k8F8NB29ClkMIwhZUYnA/O
	Qe2B1e8IMWhb/GYdw2rxsk5RNYVW37NBOqFJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c/K77+eOvNS7DivnZ6F7lgUyFuNLlehR
	/krCzmCKR6i+NYbRLCrQ3SyEc1Zgmc7OVdE7n/R1kblYSCFYNAwM/orqDv71WppU
	upea+h8s/c8Qc9m3mew6LP9vnNTkqH6w+kblsurn9j9VPSNMm5LDUHj5Y5qAyma6
	WVdck+3eztc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D809AE29;
	Fri, 28 Dec 2012 22:42:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8712BAE28; Fri, 28 Dec 2012
 22:42:20 -0500 (EST)
In-Reply-To: <1356735786-24001-1-git-send-email-aaron@schrab.com> (Aaron
 Schrab's message of "Fri, 28 Dec 2012 18:03:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BFC9783C-5169-11E2-A003-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212286>

Aaron Schrab <aaron@schrab.com> writes:

> When testing aliases in t/t1020-subdirectory.sh use longer names so that
> they're less likely to conflict with a git-* command somewhere in the
> $PATH.

Thanks.

In the longer term we might want to rethink the way we run the tests
so that random $PATH the user has has less chance of interacting
with our tests (we had a similar topic around completion output
recently), but until that happens, I think this is a good change.
