From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] cvsserver: make the output of 'update' more
 compatible with cvs.
Date: Wed, 30 Dec 2009 22:47:43 -0800
Message-ID: <7vfx6rzlkg.fsf@alter.siamese.dyndns.org>
References: <87zl5z4y0w.fsf@osv.gnss.ru> <87bpibdonj.fsf@osv.gnss.ru>
 <20091230224115.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Sergei Organov <osv@javad.com>,
	git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Dec 31 07:48:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQEpP-00030U-EW
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 07:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbZLaGr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 01:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbZLaGr7
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 01:47:59 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48421 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbZLaGr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 01:47:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C9EB9ABCF3;
	Thu, 31 Dec 2009 01:47:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AJ7/owOU83o808FdTN4F38cibvA=; b=ncjnOP
	qRgHtMl7aqLXO7XmblttFen0suggO9LU3Gp57moCI0X9kX7h9OrLs0EkdUAOIywe
	zwL5jC+jUnf+JD8F2fMU1IDMHmaJ7WaCJ3aZ9yDNqHEDNe7sRWlS7X3bwHlAPWwp
	45PVHxUEa+xt2RZJTbH3dtvP2S8fl3M5qB1OA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PhBpCHIQnK8YlMxF50YUgamBKOo9YHcd
	e3LPe2r4XweE9diitUo2koC6pZFBB9rmf9HUFkbCP/TWmV9MVvEk/bHAnWzj+SxR
	qSuzLl7RYJCsXmm+Hpy63tX5wyhvYJVf20fKch+AVS6mohAQxoF46cEyiyoQ+AOV
	+pxtxeKogzI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9A5C5ABCF2;
	Thu, 31 Dec 2009 01:47:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 360A3ABCF1; Thu, 31 Dec 2009
 01:47:44 -0500 (EST)
In-Reply-To: <20091230224115.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Wed\, 30 Dec 2009 22\:41\:15 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 69E2B798-F5D8-11DE-9EE3-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135933>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Junio, could you tell us what happened to this thread?

Well, since I don't use cvsserver myself, but this v2 was done with
improvements based on some review suggestions, I was waiting for a
response or two from people who know better and care more about cvs server
emulation than me, which unfortunately didn't happen.

Thanks for reminding; I can queue it to 'pu' or perhaps 'next' and see if
anybody screams by getting hit by an unintended side effects.
