From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Breaking "git status"
Date: Thu, 06 Aug 2009 12:06:26 -0700
Message-ID: <7vhbwklq31.fsf@alter.siamese.dyndns.org>
References: <1249463746-21538-1-git-send-email-gitster@pobox.com>
 <1249463746-21538-2-git-send-email-gitster@pobox.com>
 <1249463746-21538-3-git-send-email-gitster@pobox.com>
 <1249463746-21538-4-git-send-email-gitster@pobox.com>
 <1249463746-21538-5-git-send-email-gitster@pobox.com>
 <1249463746-21538-6-git-send-email-gitster@pobox.com>
 <20090806153339.GC1970@coredump.intra.peff.net>
 <7vljlwnc6j.fsf_-_@alter.siamese.dyndns.org>
 <20090806164247.GA1073@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 06 21:06:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ8IT-0007D4-Qn
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 21:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755409AbZHFTGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 15:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754936AbZHFTGa
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 15:06:30 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46737 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595AbZHFTGa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 15:06:30 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 99E1623E0A;
	Thu,  6 Aug 2009 15:06:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0B18923E07; Thu, 
 6 Aug 2009 15:06:27 -0400 (EDT)
In-Reply-To: <20090806164247.GA1073@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 6 Aug 2009 12\:42\:47 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3FF52DCE-82BC-11DE-BF0F-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125106>

Jeff King <peff@peff.net> writes:

> I wonder if introducing such a configuration option is not going to
> cause more confusion in the long run than simply switching. As a
> script-writer, you are not helping me at all because I can't make any
> assumptions about how the user has set the variable.
>
> I guess you are helping those who want to keep "git status" as-is
> forever for their own typing.

Not really.  I meant to be helpful to people who would say "Ok, I read the
transition plan, and I understand I eventually need to switch, but I
cannot afford to right at this momennt.  I'd transition on the timetable
of my choosing, rather than on the calendar git developers arbitrarily
set."

But you are right.  This would not really help scripts transition.
