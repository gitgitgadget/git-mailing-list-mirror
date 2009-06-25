From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Could this be done simpler?
Date: Thu, 25 Jun 2009 15:29:58 -0700
Message-ID: <7vprcsymjd.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.01.0906241426120.3154@localhost.localdomain>
	<7veit9m8cs.fsf@alter.siamese.dyndns.org>
	<200906260002.40531.chriscool@tuxfamily.org>
	<200906260023.03169.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Jun 26 00:30:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJxSL-0006LW-Nk
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 00:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593AbZFYW35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 18:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753574AbZFYW34
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 18:29:56 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:56554 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbZFYW3z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 18:29:55 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090625222958.EFGM25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Thu, 25 Jun 2009 18:29:58 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 8NVy1c0074aMwMQ04NVysx; Thu, 25 Jun 2009 18:29:58 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=YjxVEfEYJ9cA:10 a=dIu3SnmMAAAA:8
 a=UuNRHE8GK7IFE6iMFhoA:9 a=oA-hiQXhRBJ7UUu7GJpmqOYQ8GwA:4 a=Rn8qiON8_f4A:10
X-CM-Score: 0.00
In-Reply-To: <200906260023.03169.chriscool@tuxfamily.org> (Christian Couder's message of "Fri\, 26 Jun 2009 00\:23\:02 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122252>

Christian Couder <chriscool@tuxfamily.org> writes:

>> If someone creates a "git decompose-octopus <commit>" command then ...

I am afraid that misses the entire point of my discussion.

Such a decomposed octopus would _only_ be necessary during bisection, only
when the user chooses to test two tips at once (instead of testing one by
one), _and_ only its tree is needed for that purpose.  In other words, we
should be able to do this _without_ creating an extra commit, let alone
replace mechanism.
