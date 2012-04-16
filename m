From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] fetch: Use the remote's ref name to decide how to
 describe new refs.
Date: Mon, 16 Apr 2012 10:59:35 -0700
Message-ID: <7vy5pvv9q0.fsf@alter.siamese.dyndns.org>
References: <20120416150036.GA15009@sigill.intra.peff.net>
 <1334591542-25136-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Mon Apr 16 19:59:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJqDH-0005yA-4L
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 19:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719Ab2DPR7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 13:59:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59326 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209Ab2DPR7h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 13:59:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3238075A1;
	Mon, 16 Apr 2012 13:59:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M1UD1gjLkfB6a3ECBbtvOR0d3j0=; b=HImKQo
	pws3Jo5ZMJI/mOyE3DaPJzujNaFQyDHMxNld7BkPq4QLSLrIVjw5d6PxCCZ/egn1
	b6S0fmZKsPnz99QBkHtHHLTVHC8bwkw4e8Ai5Rz126RRrwD/JHZI5TaR3Rrktxdy
	E/Ewd07b+Ug6QL6Df5w5+srwXmten8MWTi0TY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rhbwd1eEbKqY2ABCCcBNaGLpjIuXWMdP
	j7ayO3OZeJRygIIalWOc1i00Ududo8AvQAppXRGmoyuHITddzmMUSKKq45zBiVP2
	dpbSEisDVzWZPJUoHSNOs1PJdInYlsOhenarRyUt5EQHO6Kv+HD7B1nHHR4SUjJd
	Xbz+ZoxKy70=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2800875A0;
	Mon, 16 Apr 2012 13:59:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4585759F; Mon, 16 Apr 2012
 13:59:36 -0400 (EDT)
In-Reply-To: <1334591542-25136-1-git-send-email-marcnarc@xiplink.com>
 (marcnarc@xiplink.com's message of "Mon, 16 Apr 2012 11:52:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EDFB564E-87ED-11E1-B2A4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195674>

marcnarc@xiplink.com writes:

> Re-rolled to work with the remote's ref names.
>
> As before, this is atop of Jens's submodule-recursion fix.

Thanks; will queue.

As Jonathan mentioned, it would probably be a good idea to protect this
with a new test or two, but I am fine if it is done as a separate patch.
