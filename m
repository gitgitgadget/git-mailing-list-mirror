From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Should "log --cc" imply "log --cc -p"?
Date: Tue, 05 Feb 2013 07:46:52 -0800
Message-ID: <7vsj5avk43.fsf@alter.siamese.dyndns.org>
References: <7vmwvl6lj9.fsf@alter.siamese.dyndns.org>
 <510F95D7.6010107@drmicha.warpmail.net>
 <7vfw1c3ujo.fsf@alter.siamese.dyndns.org>
 <20130205093307.GC24973@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 05 16:47:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2kjw-0008Gc-Ng
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 16:47:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150Ab3BEPq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 10:46:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57424 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858Ab3BEPq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 10:46:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1BD5BE82;
	Tue,  5 Feb 2013 10:46:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l116gTg49K+lERZl+3Bb5VyM1Ks=; b=aLDl74
	rrBk6xticzhCGZZvK/aVtFDn90Ehh5OAzbrf5ODHpZkCzegtyR5hHapSc6E+JwAQ
	K164wvXE73aH0G2Js+Nh9tXvpfxwkdB9N6+U5EbXqUL4VE2UW9ZWZYzr5cTxhx7I
	78NVPlzCz55fFMuffjfrane+dYWfd7Sa3/8bc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kmix1ia+VWhK6RtBSXgIJUJRvdN4Duwy
	wYN8IoU8692TpDfMwMMHeXGiLONYOsgC5ktRvohpYB/B5FFIbyQx7ByE86hAj7Pq
	Z5p6x7RpjxZCU/TqEJHQjLhYGpCn8YfWK5DrAu6Qq6emKfLenZGIjS45gILko7Gz
	/3uhmEUxGF4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 950A0BE81;
	Tue,  5 Feb 2013 10:46:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 02DA4BE7D; Tue,  5 Feb 2013
 10:46:53 -0500 (EST)
In-Reply-To: <20130205093307.GC24973@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 5 Feb 2013 04:33:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 43AF80F6-6FAB-11E2-93E0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215506>

Jeff King <peff@peff.net> writes:

>   git log --cc --stat
>
> the "--cc" is significant. So I don't think it is right for "--cc" to
> always imply "-p". But if the rule kicked in only when no other format
> had been specified, that might make sense.

Yes, it was my mistake that I left it unsaid.  Obviously the
description of the "minor irritation" must be qualified with "unless
no other output options like --raw, --stat, etc. are given".

Thanks.
