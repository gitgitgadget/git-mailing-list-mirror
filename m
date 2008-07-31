From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git vs Monotone
Date: Thu, 31 Jul 2008 13:24:41 -0700
Message-ID: <7vmyjxyf7a.fsf@gitster.siamese.dyndns.org>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com>
 <alpine.LFD.1.10.0807311211260.3277@nehalem.linux-foundation.org>
 <63BEA5E623E09F4D92233FB12A9F79430238A5EC@emailmn.mqsoftware.com>
 <alpine.LFD.1.10.0807311244240.3277@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Craig L. Ching" <cching@mqsoftware.com>, sverre@rabbelier.nl,
	Git Mailinglist <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 22:26:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOeid-0004aH-W4
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 22:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbYGaUYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 16:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbYGaUYu
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 16:24:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52366 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbYGaUYt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 16:24:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2F13243B63;
	Thu, 31 Jul 2008 16:24:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5C06A43B60; Thu, 31 Jul 2008 16:24:43 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0807311244240.3277@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Thu, 31 Jul 2008 12:52:43 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B8AAC94C-5F3E-11DD-B0F8-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90980>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> ... And since the original pack-file is marked as a 'keep' file,
> that original pack-file won't even be broken apart.

Oops, isn't that something we fixed recently as a "bug"?

> So completely ignoring the fact that you could do a single database with 
> git, and completely ignoring the fact that with git you'd probably use 
> branches for at least some of those 11 repos anyway, he'd _still_ have had 
> less disk space used by git unless he would do something intentionally odd 
> (like clone all the repositories over the network separately).

Well, people are not perfect and they are free to express their opinions
based on faulty understanding of reality on their blogs.  The right things
to do are (1) ignore them on the list and not waste many people's time,
and/or (2) educate them, but in private or in a circle where many other
similar ignorants benefit from such education.  That is not here but
perhaps on #monotone channel?
