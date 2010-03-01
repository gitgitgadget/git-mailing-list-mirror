From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/12] add --ff option to cherry-pick
Date: Sun, 28 Feb 2010 19:49:12 -0800
Message-ID: <7v3a0kg0qv.fsf@alter.siamese.dyndns.org>
References: <20100228222038.2260.25016.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Mar 01 04:49:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlwdW-0004Rk-Jf
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 04:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817Ab0CADtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 22:49:33 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41502 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab0CADtc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 22:49:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EE0F69E7C6;
	Sun, 28 Feb 2010 22:49:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BxGPaYgzFEjrjBTy8oYbV6WdEIQ=; b=HpUZtG
	FIALOTnr7pR3DKb+LuthlsnsLrgoXQ4dddRVNT2lV9ceEmHOqtkpcfcoJbqlkI5K
	lgTHfy5wrfpQ14NMI1WFFd/fcDhjs4aoOflPD/UPwC0WfCT0F6OdE1q/BXIV/n1o
	4LWqFmnZfpHGKEYEQypL/57MUCpWBudWHVVag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DeIqCCRlNw0qtl32dRrVARuL8QgnXWp3
	rrLBfF8pnlOUdKP0QgP1GG9C4nXLF2VjTkQWb6ubo33Jc+7S9Z2i/OaXHSkY0reo
	TpWena7pQQMpFZBZ41jEDxVEKQVuFsPZIBZ3XyG7U8pVjHP9+/bRjfBO1iHGlTFD
	h8cLHcqjuiI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 593449E7C5;
	Sun, 28 Feb 2010 22:49:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27AB29E7C1; Sun, 28 Feb
 2010 22:49:14 -0500 (EST)
In-Reply-To: <20100228222038.2260.25016.chriscool@tuxfamily.org> (Christian
 Couder's message of "Sun\, 28 Feb 2010 23\:21\:55 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6CA27BA8-24E5-11DF-AC9E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141296>

Thanks, but this seems to conflict with too many things in flight (it
applies cleanly on top of 'pu' but not on top of 'next').

Given that "rebase--interactive", which is the sole in-tree user of
cherry-pick, has its own fast-forwarding logic to skip call to it, it
seems to take too much time out of me to deal with the code churn for
dubious benefit---the series does not seem to solve any real problem.

After other topics have either graduated to 'master' or dropped out of
'pu', things might look differently, though.
