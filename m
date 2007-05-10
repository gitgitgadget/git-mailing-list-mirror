From: Junio C Hamano <junkio@cox.net>
Subject: Re: quick bare clones taking longer?
Date: Thu, 10 May 2007 14:55:52 -0700
Message-ID: <7vbqgsibrr.fsf@assigned-by-dhcp.cox.net>
References: <7virb1sm6h.fsf@assigned-by-dhcp.cox.net>
	<20070509.150256.59469756.davem@davemloft.net>
	<7v3b25siwk.fsf@assigned-by-dhcp.cox.net>
	<20070509.162301.48802460.davem@davemloft.net>
	<7vy7jxr35a.fsf@assigned-by-dhcp.cox.net>
	<7vd519r10c.fsf@assigned-by-dhcp.cox.net>
	<vpqtzul3xzm.fsf@bauges.imag.fr> <4642DE52.F9F0A5B2@eudaptics.com>
	<loom.20070510T224750-851@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan Nicholson <dbn.lists@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 23:55:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmGc9-0003Ae-LD
	for gcvg-git@gmane.org; Thu, 10 May 2007 23:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760807AbXEJVzy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 17:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759887AbXEJVzy
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 17:55:54 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:62683 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759581AbXEJVzx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 17:55:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070510215553.ZZPN13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 10 May 2007 17:55:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xZvs1W00A1kojtg0000000; Thu, 10 May 2007 17:55:52 -0400
In-Reply-To: <loom.20070510T224750-851@post.gmane.org> (Dan Nicholson's
	message of "Thu, 10 May 2007 20:52:15 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46904>

Dan Nicholson <dbn.lists@gmail.com> writes:

> In fact, all POSIX shells should support `cd -P' according to the spec, so it
> should probably just be used directly instead of hoping that /bin/pwd exists.
>
> (cd -P "$1" && (cd .git ; pwd)) 2>/dev/null
>
> http://www.opengroup.org/onlinepubs/009695399/utilities/cd.html

Yes but no ;-).  I've said this a few times on the list in the
past, but I'll repeat it again for new people.

We reject something whose portability in question by saying
"It's not _even in_ POSIX".  We on the other hand try to refrain
from saying "POSIX says you are supposed to have it, so screw
people that are not fully POSIX".
