From: Junio C Hamano <gitster@pobox.com>
Subject: Re: =?utf-8?Q?Schr=C3=B6dinger's?= diff
Date: Tue, 07 Jul 2009 19:54:04 -0700
Message-ID: <7v8wizanqr.fsf@alter.siamese.dyndns.org>
References: <279b37b20907062353k34bca06erf035458e80933c8d@mail.gmail.com>
 <alpine.LNX.2.00.0907071316490.2147@iabervon.org>
 <20090707193605.GA30945@coredump.intra.peff.net>
 <7vtz1o9sv6.fsf@alter.siamese.dyndns.org>
 <20090707195406.GA32131@coredump.intra.peff.net>
 <7vfxd89lqf.fsf@alter.siamese.dyndns.org>
 <279b37b20907071717r71f982b6u7333ff10fadfc39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 04:54:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MONIa-0006QG-K2
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 04:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756276AbZGHCyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 22:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755799AbZGHCyN
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 22:54:13 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54108 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110AbZGHCyN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 22:54:13 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 150192595C;
	Tue,  7 Jul 2009 22:54:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 042AD2595A; Tue, 
 7 Jul 2009 22:54:05 -0400 (EDT)
In-Reply-To: <279b37b20907071717r71f982b6u7333ff10fadfc39@mail.gmail.com>
 (Eric Raible's message of "Tue\, 7 Jul 2009 17\:17\:21 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9CE03EB6-6B6A-11DE-B5BA-DC021A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122885>

Eric Raible <raible@gmail.com> writes:

> So what's the best way of "fixing once and for all" a repo infected with
> carriage returns when you want to use autocrlf=true moving forward?

Didn't "rm -f .git/index && git reset --hard HEAD" work?

> And a hopefully less annoying one:
>
> Would you accept a patch explaining how "git reset --hard" doesn't
> actually rebuild the index from scratch,...

Absolutely.

> ... and how "git read-head" might
> be recommended in some weird situations?

I am less certain about that; people may have easier-to-read solution than
the one with read-tree, I would suspect.
