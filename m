From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re: [TRIVIAL] Documentation: merge: one <remote> is
 required
Date: Wed, 12 Aug 2009 13:31:00 -0700
Message-ID: <7vhbwcydtn.fsf@alter.siamese.dyndns.org>
References: <1249995838.1589.3.camel@localhost.localdomain>
 <20090811144253.GA12956@vidovic>
 <1250002681.2707.2.camel@localhost.localdomain>
 <7vy6ppbvdf.fsf@alter.siamese.dyndns.org>
 <1250074578.7545.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
X-From: git-owner@vger.kernel.org Wed Aug 12 22:31:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbKTe-0008UY-Ky
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 22:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869AbZHLUbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 16:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752364AbZHLUbG
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 16:31:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53471 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbZHLUbF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 16:31:05 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CE7385F3;
	Wed, 12 Aug 2009 16:31:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 986D085F2; Wed, 12 Aug
 2009 16:31:01 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0F2EDABA-877F-11DE-848F-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125741>

Paul Bolle <pebolle@tiscali.nl> writes:

> Confusingly, as far as I can see, the manpages of the following commands
> seem to use the "one or more" meaning:
>     git merge-base
> ...
> ("git mv" uses both meanings in its synopsis. The two "git tag"
> invocations seem to do nothing with zero arguments and do not return an
> error.)
>
> If the above commands really use the "one or more" meaning, that would
> mean both versions are used in the documentation. I'd say it would be
> better to stick to one meaning throughout the manpages.

You are absolutely right.  We would want consistency.

I do not have any objection to make sure that we uniformly use ellipses
for one-or-more (and enclose them in [] if we want zero-or-more).  Are
these two that your patch touched the only ones that need fixing?
