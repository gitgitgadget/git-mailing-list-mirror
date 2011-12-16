From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: brush up obsolete bits of git-fsck manpage
Date: Fri, 16 Dec 2011 12:40:11 -0800
Message-ID: <7vy5ucgsic.fsf@alter.siamese.dyndns.org>
References: <20111216113310.GA16601@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 16 21:40:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbeZn-00014n-2M
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 21:40:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760682Ab1LPUkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 15:40:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56903 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355Ab1LPUkN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 15:40:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED06D5A76;
	Fri, 16 Dec 2011 15:40:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J/95UT3gg34wgLMOexRDgRdrg/U=; b=XXd84E
	grfeYxiNrnXD5JF16HrJee8VVz/wVWF8jzkYqSAT/dqPLG+Dn8kVeqWlgwjSvXYs
	hqQ4PZfkcngSAe8VxuZUhZchJuh7/zN0JhzVFoYJyioAIDd3Z7w08OurN6cpGztH
	3p3JjwiTem0ion5YOhodCBq3oBUdSl5OvPV7A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N3QdouC/oUOsB6BnOgWum0R1UAGV3LFn
	WiLCLfNKYVVJGXMGBnxxJGXETYLqUd2a154D4kJoGWVHsPEnhBJeQdDfDds4HOLj
	J6IfP3ouAJyP3TlusSQz3KtmuejtjL41UYfDI2w+TK9ZkZVgU8F3qzELOfpoHxEa
	6fchpKHltO0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4A705A75;
	Fri, 16 Dec 2011 15:40:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61C425A74; Fri, 16 Dec 2011
 15:40:12 -0500 (EST)
In-Reply-To: <20111216113310.GA16601@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 16 Dec 2011 06:33:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 26E31A50-2826-11E1-8099-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187317>

Makes sense; thanks.

By the way did you hand-tweak your patch in any way?

I am not complaining that it does not apply (it does), but I am curious
how you got the line that begins with "corruption it finds ..." neatly in
preimage and postimage; it could become a common line but doing so makes
the patch unreadable and that is what I am getting from "git show" after
applying the patch.
