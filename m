From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and Mercurial
Date: Tue, 31 Jul 2007 22:50:48 -0700
Message-ID: <7vodhrby6f.fsf@assigned-by-dhcp.cox.net>
References: <200708010216.59750.jnareb@gmail.com>
	<alpine.LFD.0.999.0707311850220.4161@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 01 07:50:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG76j-0003ra-Ot
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 07:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175AbXHAFuv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 01:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753744AbXHAFuu
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 01:50:50 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:46543 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754188AbXHAFuu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 01:50:50 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070801055049.JXRG14885.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Wed, 1 Aug 2007 01:50:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id WVqo1X00L1kojtg0000000; Wed, 01 Aug 2007 01:50:49 -0400
In-Reply-To: <alpine.LFD.0.999.0707311850220.4161@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 31 Jul 2007 19:14:23 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54411>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> (Which admittedly is a bit odd. The reason I didn't ever seriously even 
> consider monotone was that the initial import was so *incredibly* sucky, 
> and took hours for the kernel. So use "-l" for benchmarks, and damn my 
> "I hate hardlinking repos" idiocy).

I would call aversion to -l a superstition, while aversion to -s
has a sound technical reasons.  The latter means you need to know
what you are doing --- namely, you are making the clone still
dependent on the original.
