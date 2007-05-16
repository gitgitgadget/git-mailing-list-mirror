From: Junio C Hamano <junkio@cox.net>
Subject: Re: MinGW port: some questions
Date: Wed, 16 May 2007 12:09:30 -0700
Message-ID: <7vejlgegb9.fsf@assigned-by-dhcp.cox.net>
References: <1179341520.31213.38.camel@bruno.nolaviz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alon Ziv <alonz@nolaviz.org>
X-From: git-owner@vger.kernel.org Wed May 16 21:09:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoOsT-0001Q3-7w
	for gcvg-git@gmane.org; Wed, 16 May 2007 21:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756534AbXEPTJb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 15:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756579AbXEPTJb
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 15:09:31 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:51301 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756534AbXEPTJb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 15:09:31 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070516190929.DEDR13903.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 16 May 2007 15:09:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id zv9V1W00f1kojtg0000000; Wed, 16 May 2007 15:09:30 -0400
In-Reply-To: <1179341520.31213.38.camel@bruno.nolaviz.org> (Alon Ziv's message
	of "Wed, 16 May 2007 21:52:00 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47451>

Alon Ziv <alonz@nolaviz.org> writes:

> I am referring, for example, to the changes from commit dc380d6, which
> were reverted in Git mainline (actually in "next", they never reached
> Git's "master").  Or to the changes from 4493e36, which had the same
> fate.

MinGW repository bases its work on my 'next', so it will not be
pulled wholesale to my 'master'.  The plan is to trickle down
the platform independent bits of fixes and refactoring to the
mainline, as well as #ifdef __MINGW32__ and $(findstring MINGW)
parts, but that will most likely happen as a series of bite
sized patch series to the list with public reviews.

I do not know if you mistyped dc380d6 (I do not find it there),
but reverting 4493e36 (merge of jc/3way) was intentional.  The
work in that commit that deviates from the mainline is the
jc/3way topic, which turned out to be incomplete and not very
usable.  MinGW tree might not have synchronized with the latest
from the mainline in which case it might not have merged the
revert from me yet, and that may be why you are seeing the
differences.
