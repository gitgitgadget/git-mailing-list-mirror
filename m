From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2012, #02; Sun, 4)
Date: Mon, 05 Mar 2012 15:17:13 -0800
Message-ID: <7vsjhmy6x2.fsf@alter.siamese.dyndns.org>
References: <7vk42z32jo.fsf@alter.siamese.dyndns.org>
 <CAFfmPPNWXG2iP4jg0v0EoMuGb6eNoEvFuserc7vtP9EeLFp1CA@mail.gmail.com>
 <7v1up6zmwr.fsf@alter.siamese.dyndns.org>
 <CAFfmPPPa=s8NAYDxoSa5SR91Y_tgRLUVo_bzgViE0wV5g0Ld3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 00:17:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4h9d-0007ZC-J5
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 00:17:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757592Ab2CEXRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 18:17:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51172 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757559Ab2CEXRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 18:17:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B38BD686D;
	Mon,  5 Mar 2012 18:17:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q2no4dVlDVF4ub+L1fAx2VPklfM=; b=GTZ8g7
	92r4u7TxZIuuvvKugCqCKLJdWlHMWQyTo5yv4hMVixKfzrpAOMNo4FY9o0mZ85/z
	x3Xk6OpC3iXZCTyIw8Q4Gt+WlDoOSBIB2beTByxTC7ENDZ5g90XoUhwEHmtugxeU
	FvVJ4HtUf1HTGGndvalLf2qoh2DrkIWxRnKIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZMwYctNxcADtR9eRVAPm2SbjFxlmn+i4
	MVvJXwYzI5lXzJ/fLYWMRQ25ePC2WaIApFxvxdJhs47AMIa/9eW6YMgNAzPH6nJs
	zHKTDZygXiJhVECq6j/snfEfuZGoqxiFv2rBUUPd6drho2aeC3tjsN/gOX+l18DG
	6MrdjsiOjVM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB4CE686C;
	Mon,  5 Mar 2012 18:17:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 449DC686B; Mon,  5 Mar 2012
 18:17:15 -0500 (EST)
In-Reply-To: <CAFfmPPPa=s8NAYDxoSa5SR91Y_tgRLUVo_bzgViE0wV5g0Ld3g@mail.gmail.com> (David
 Barr's message of "Tue, 6 Mar 2012 10:11:35 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5868900A-6719-11E1-AE78-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192284>

David Barr <davidbarr@google.com> writes:

> GitHub has a different mechanism for publishing project content.
> They expect a special named branch, gh-pages.

Hrm, so if they add a mechanism to name what branch to show the
content from, I could set it from gh-pages to master and we will
have an online HTML pages.  Nice.

I wonder if they can also do historical documents (e.g. manual pages
for release 1.7.0) that way.

> I thought it might be of interest that both Google Code and GitHub
> provide git-friendly means of publishing project content.
