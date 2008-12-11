From: Junio C Hamano <gitster@pobox.com>
Subject: Re: epic fsck SIGSEGV!
Date: Wed, 10 Dec 2008 16:51:54 -0800
Message-ID: <7vwse7wn2t.fsf@gitster.siamese.dyndns.org>
References: <1228867861.14165.19.camel@starfruit.local>
 <7vd4g051ax.fsf@gitster.siamese.dyndns.org>
 <1228903606.4445.53.camel@starfruit.local> <493FAA5A.8070801@viscovery.net>
 <1228949523.27061.20.camel@starfruit.local>
 <alpine.LFD.2.00.0812101523570.3340@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "R. Tyler Ballance" <tyler@slide.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 01:53:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAZo3-0001Lq-7U
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 01:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088AbYLKAwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 19:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752418AbYLKAwI
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 19:52:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50440 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbYLKAwG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 19:52:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E02CC1895E;
	Wed, 10 Dec 2008 19:52:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4BF391894E; Wed,
 10 Dec 2008 19:51:55 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0812101523570.3340@localhost.localdomain>
 (Linus Torvalds's message of "Wed, 10 Dec 2008 15:40:28 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EDD3346E-C71D-11DD-B94E-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102759>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> But we should definitely fix this braindamage in fsck. Rather than 
> recursively walk the commits, we should add them to a commit list and just 
> walk the list iteratively.
>
> Junio?

I think that is a sensible thing to do.  I may take a look at it myself
later in the week, unless somebody else (wants to do / does) this first.
