From: Junio C Hamano <gitster@pobox.com>
Subject: Re: email address handling
Date: Sat, 02 Aug 2008 09:42:11 -0700
Message-ID: <7v3alnpdwc.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org>
 <20080801131127.20b3acfd.akpm@linux-foundation.org>
 <alpine.LFD.1.10.0808011316050.3277@nehalem.linux-foundation.org>
 <20080801132415.0b0314e4.akpm@linux-foundation.org>
 <alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org>
 <20080801135421.5ca0f6af.akpm@linux-foundation.org>
 <7vvdykqub6.fsf@gitster.siamese.dyndns.org>
 <20080801145804.85041bbd.akpm@linux-foundation.org>
 <20080801221539.GA8617@mit.edu>
 <20080801152720.56dbff09.akpm@linux-foundation.org>
 <alpine.LFD.1.10.0808011534260.6819@nehalem.linux-foundation.org>
 <20080801154902.c60717e5.akpm@linux-foundation.org>
 <alpine.LFD.1.10.0808011554350.6819@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808011608150.6819@nehalem.linux-foundation.org>
 <alpine.DEB.1.00.0808021321500.9611@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.LFD.1.10.0808020916370.3318@nehalem.linux-foundation.org>
 <7vabfvpdyk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 02 18:43:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPKCQ-0004vw-Qk
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 18:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755406AbYHBQmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 12:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754786AbYHBQmW
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 12:42:22 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41546 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122AbYHBQmV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 12:42:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DA79E47CCD;
	Sat,  2 Aug 2008 12:42:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9D98547CCA; Sat,  2 Aug 2008 12:42:13 -0400 (EDT)
In-Reply-To: <7vabfvpdyk.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 02 Aug 2008 09:40:51 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F94A2852-60B1-11DD-ACBB-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91154>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> On Sat, 2 Aug 2008, Johannes Schindelin wrote:
>>> 
>>> Ah, there lies the rub (you forgot that the original complaint was about 
>>> a comma, and pretty=email does not handle those):
>>
>> Indeed.
>>
>> I wonder where that is_rfc2047_special() function came from.  The list of 
>> "special" characters is totally bogus.
>
> This function is about quoting inside dq pair, so the function does not

s/is about/is NOT about/;

Sorry, I should grab coffee before continuing.

> look at the set you listed.  It is about quoting non-ascii chars using the
> ?charset?Q? or ?charset?B? notation.
>
> If we want to use double quotes that should be done elsewhere, not in that
> function.
