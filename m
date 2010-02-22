From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH] Add `[decorate]' configuration section.
Date: Sun, 21 Feb 2010 21:52:03 -0800
Message-ID: <7vk4u53ji4.fsf@alter.siamese.dyndns.org>
References: <16c38171fc04cee7bdc607bb4c6586925b15278c.1266394059.git.sdrake@xnet.co.nz>
 <7vd403vhrn.fsf@alter.siamese.dyndns.org>
 <20100220171732.GA15561@book.hvoigt.net>
 <201002201849.03656.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Steven Drake <sdrake@xnet.co.nz>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 22 07:12:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjRDU-0001E4-7W
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 06:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991Ab0BVFwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 00:52:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38651 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab0BVFwS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 00:52:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D6FF59B413;
	Mon, 22 Feb 2010 00:52:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=008hv6OksM8jsUBSdyJ8IHHYWK8=; b=ucV8NE
	4mSYg6K3Pmc7gCSl9q4nYE3J19fhsa4WNpCXow5BBuqcGjZP+Z4nF1k6EaeMIXEa
	+n8NtT2BuFdLK/wiPcJFT8Os3ob5y4k0NQSUulavbVNf6Oj4iGXkgzMPCbAUppOU
	42L07Vj8Yb/yXNa4n7hoFef2tYBvJFgKJQOrY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HCf26TmBSYcRk5lIF2wgyrkcDA59kJci
	N+dyRBF4H0nBd7t/MOWs/mPzHXU1AXwQ+R8eEBMcfz28x1N9Tvla3zXj1uHODtjO
	dZnJFOQ3PMiPmCGD0vgTZuAKSg+lQRtbB5BZ+eyE1CUOozwN0CQgEJE0PDhaRVvC
	4bLyg/xIV/s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C5E89B412;
	Mon, 22 Feb 2010 00:52:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 813999B40E; Mon, 22 Feb
 2010 00:52:06 -0500 (EST)
In-Reply-To: <201002201849.03656.trast@student.ethz.ch> (Thomas Rast's
 message of "Sat\, 20 Feb 2010 18\:49\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6C115818-1F76-11DF-A03D-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140615>

Thomas Rast <trast@student.ethz.ch> writes:

> Since 66b2ed0 (Fix "log" family not to be too agressive about showing
> notes, 2010-01-20), git log --pretty=... doesn't show notes.  Perhaps
> at least the 'raw' format should also implicitly disable other user
> configuration, including this?

Sounds like a reasonable suggestion.
