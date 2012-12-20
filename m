From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Python version auditing followup
Date: Thu, 20 Dec 2012 10:30:31 -0800
Message-ID: <7vobho60fs.fsf@alter.siamese.dyndns.org>
References: <20121220143411.BEA0744105@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: esr@thyrsus.com (Eric S. Raymond)
X-From: git-owner@vger.kernel.org Thu Dec 20 19:30:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlktR-00034U-1W
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 19:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675Ab2LTSag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 13:30:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32993 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750875Ab2LTSae (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 13:30:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64D0F9E21;
	Thu, 20 Dec 2012 13:30:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yM6D+4Nr2PPNMJ6ep3vtz0sxsHs=; b=LPBeN4
	rXH4I7onDpYwJMX5HSpuM2YyezV5E4r0hG3WikmT3Yv3thrsgvv7kEvzuJb0RDve
	dMHxGewviVQFnhkEpuDApxrisk2oP5VCwKA1xdsb+uZPDQaXE/RNei/M9ehtGnxD
	w6wpvbfHHEQ8OrHgUhcadALmb80RNGBRo9N10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dqLFBNf+bbeT3T+jctQyv3v0yHGmUJx1
	6EYkUKrCgCkQcUXPZO7kMhEca1aAHPslDbFSnJ3sqBKV01yuj/BW4k0dITkn84jz
	XW+NzfX3URSCHmcoUOKAVtlq2us0t5PK3t2Cbq+/qbDHawjW7HcUqMtxVn7lA/m6
	PKl1Odl74NE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EFB69E1F;
	Thu, 20 Dec 2012 13:30:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BCC8A9E1C; Thu, 20 Dec 2012
 13:30:33 -0500 (EST)
In-Reply-To: <20121220143411.BEA0744105@snark.thyrsus.com> (Eric S. Raymond's
 message of "Thu, 20 Dec 2012 09:34:11 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 574DDCF4-4AD3-11E2-B178-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211913>

esr@thyrsus.com (Eric S. Raymond) writes:

> That was the first of three patches I have promised.  In order to do
> the next one, which will be a development guidelines recommend
> compatibility back to some specific version X, I need a policy
> decision.  How do we set X?
>
> I don't think X can be < 2.4, nor does it need to be - 2.4 came out
> in 2004 and eight years is plenty of deployment time.
>
> The later we set it, the more convenient for developers.  But of
> course by setting it late we trade away some portability to 
> older systems.
>
> In previous discussion of this issue I recommended X = 2.6.
> That is still my recommendation. Thoughts, comments, objections?

I personally would think 2.6 is recent enough.  Which platforms that
are long-term-maintained by their vendors still pin their Python at
2.4.X?  2.4.6 was in 2008 that was source only, 2.4.4 was in late
2006 that was the last 2.4 with binary release.

Objections?  Comments?
