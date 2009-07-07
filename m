From: Junio C Hamano <gitster@pobox.com>
Subject: Re: =?utf-8?Q?Schr=C3=B6dinger's?= diff
Date: Tue, 07 Jul 2009 15:22:48 -0700
Message-ID: <7vfxd89lqf.fsf@alter.siamese.dyndns.org>
References: <279b37b20907062353k34bca06erf035458e80933c8d@mail.gmail.com>
 <alpine.LNX.2.00.0907071316490.2147@iabervon.org>
 <20090707193605.GA30945@coredump.intra.peff.net>
 <7vtz1o9sv6.fsf@alter.siamese.dyndns.org>
 <20090707195406.GA32131@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 08 00:23:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOJ45-0004vI-S4
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 00:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756093AbZGGWW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 18:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755852AbZGGWW6
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 18:22:58 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53598 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754983AbZGGWW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 18:22:58 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7C45625AE0;
	Tue,  7 Jul 2009 18:22:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 863B325ADC; Tue, 
 7 Jul 2009 18:22:50 -0400 (EDT)
In-Reply-To: <20090707195406.GA32131@coredump.intra.peff.net> (Jeff King's
 message of "Tue\, 7 Jul 2009 15\:54\:06 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B87EB0D8-6B44-11DE-BD8D-DC021A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122881>

Jeff King <peff@peff.net> writes:

> Yes, that works fine, but:
>
>   1. It blows away anything unrelated you might have staged.
>
>   2. You have to know to do it (and you get very confusing results if
>      you don't), which makes it very unfriendly for newbies.
>
>   3. You have to know to do it, and it isn't documented. :)
>
> (3) at least is not too hard to address. And perhaps (2) is not a big
> enough issue to care about. This is not a problem we have seen on the
> list a lot. I suspect it is because most CRLF users are on Windows, and
> therefore have it setup before the tree is checked out, and there are
> simply not all that many clean/smudge users.

A much more important reason is that it is a one-time event.  You notice
that you screwed up the configuration to use your peculiar work tree
representation, and you fix it once and for all.  Because not only it is a
one-time event but because it is a big-deal event, I do not think it is
something people even would want to think about doing it while having
local changes, so I suspect #1 is also a non-issue.
