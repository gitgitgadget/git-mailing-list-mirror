From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] --date=relative falls back to "short" format for
 commits older than a year
Date: Fri, 20 Feb 2009 21:48:00 -0800
Message-ID: <7vab8gs5m7.fsf@gitster.siamese.dyndns.org>
References: <1235165034-20299-1-git-send-email-eletuchy@gmail.com>
 <alpine.LFD.2.00.0902201409230.21686@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: eletuchy@gmail.com, peff@peff.net, git@vger.kernel.org,
	eletuchy@facebook.com, Eugene Letuchy <eugene@facebook.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Feb 21 06:53:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lakno-000140-1X
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 06:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbZBUFsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 00:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbZBUFsM
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 00:48:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41331 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbZBUFsM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 00:48:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 795582B96F;
	Sat, 21 Feb 2009 00:48:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4AA0B2B94F; Sat,
 21 Feb 2009 00:48:02 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0902201409230.21686@localhost.localdomain>
 (Linus Torvalds's message of "Fri, 20 Feb 2009 14:15:22 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 393072DC-FFDB-11DD-BD79-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110928>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So here's a throw-away patch (meaning: I won't be re-sending it, because I 
> really don't think it's a big deal) to add "--date=raw". It just prints 
> out the internal raw git format - seconds since epoch plus timezone (put 
> another way: 'date +"%s %z"' format)

Heh, who can discard a patch *WITH DOCUMENTATION* from you ;-)

Thanks.
