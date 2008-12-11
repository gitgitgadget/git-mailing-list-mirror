From: Junio C Hamano <gitster@pobox.com>
Subject: Re: epic fsck SIGSEGV!
Date: Wed, 10 Dec 2008 23:33:11 -0800
Message-ID: <7v63lrupxk.fsf@gitster.siamese.dyndns.org>
References: <1228867861.14165.19.camel@starfruit.local>
 <7vd4g051ax.fsf@gitster.siamese.dyndns.org>
 <1228903606.4445.53.camel@starfruit.local> <493FAA5A.8070801@viscovery.net>
 <1228949523.27061.20.camel@starfruit.local>
 <alpine.LFD.2.00.0812101523570.3340@localhost.localdomain>
 <alpine.LFD.2.00.0812102031440.14328@xanadu.home>
 <alpine.LFD.2.00.0812101854230.3340@localhost.localdomain>
 <alpine.LFD.2.00.0812101930590.3340@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	"R. Tyler Ballance" <tyler@slide.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 08:34:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAg4O-0001QW-0H
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 08:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbYLKHd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 02:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbYLKHd1
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 02:33:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59544 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbYLKHd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 02:33:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 96273189A8;
	Thu, 11 Dec 2008 02:33:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5ACDD189A6; Thu,
 11 Dec 2008 02:33:16 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0812101930590.3340@localhost.localdomain>
 (Linus Torvalds's message of "Wed, 10 Dec 2008 19:44:37 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FE72248C-C755-11DD-8149-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102784>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I dunno. I like this patch better. It's a bit larger. I think it's a bit 
> more clearly separated (ie a "mark_object_reachable()" _literally_ just 
> puts the object on a list, and the whole traversal is a whole separate 
> phase), but I guess it's a matter of taste.

... which happens to match mine in this case ;-)

I'll consider this signed-off and do the usual forging (for people new on
the list, Cf. http://article.gmane.org/gmane.comp.version-control.git/19031).
