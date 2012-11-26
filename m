From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/11] alternative unify appending of sob
Date: Mon, 26 Nov 2012 14:00:47 -0800
Message-ID: <7v1ufgqb1s.fsf@alter.siamese.dyndns.org>
References: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 23:01:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td6jl-0001ow-6T
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 23:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757295Ab2KZWAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 17:00:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61713 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755563Ab2KZWAu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 17:00:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F93B909B;
	Mon, 26 Nov 2012 17:00:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H18bcPzsQ8JX2RhJ6mvNZjqBpW0=; b=r/wB64
	t2XKpJz96BJAeYrI1rzSPi0JvBf5CnY+XeUVT1ymWJ3PwwcBAiMZ5/1WpJ1gqYOC
	Jd4wVJ9GpP+6Vbr9E7AljSIVnS4k/jcI0URqFl22FcF6a6Nzc6y3vCEr//L+za4d
	CcOQXZ8+7gqsrmHNcZRnVplhdq/kM/JLCEcOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dhKL0wh5rl1CPirvCddt5XTgifOmZnlO
	x8F7ymYvjxLnqi4JM0qZiAUudp2K7FNbK9pveeVZJHPWM9U8KJ6PhefxjqH7Q+HT
	Ukhj7w9NwO77O42N8mmsJjdQGqaVAvy+6ACvv7+hs5b4LKcceFU2PSmKunDbqYf2
	IM5vc8ubn+0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A0A09097;
	Mon, 26 Nov 2012 17:00:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 788109092; Mon, 26 Nov 2012
 17:00:49 -0500 (EST)
In-Reply-To: <1353894359-6733-1-git-send-email-drafnel@gmail.com> (Brandon
 Casey's message of "Sun, 25 Nov 2012 17:45:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BCF22E56-3814-11E2-BCB7-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210503>

Brandon Casey <drafnel@gmail.com> writes:

> So, this series should result in s-o-b and "(cherry picked from...)" being
> appended to commit messages in a more consistent and deterministic way.  For
> example, the decision about whether to insert a blank line before appending
> a s-o-b.  As discussed, cherry-pick and commit will only refrain from
> appending a s-o-b if the committer's s-o-b appears as the last one in a
> conforming footer, while format-patch will refrain from appending it if it
> appears anywhere within the footer.

Sounds sensible; we may want to fix format-patch later, but with
something like this series, it is just the matter of flipping one
bit.

Will queue. Thanks.
