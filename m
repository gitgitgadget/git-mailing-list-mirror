From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFH] An early draft of v1.5.0 release notes
Date: Wed, 27 Dec 2006 02:24:07 -0800
Message-ID: <7v1wml8wmw.fsf@assigned-by-dhcp.cox.net>
References: <7vvejx948y.fsf@assigned-by-dhcp.cox.net>
	<emtgps$f1q$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 11:24:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzVxZ-0006Nn-CQ
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 11:24:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066AbWL0KYK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 05:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754094AbWL0KYK
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 05:24:10 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:56919 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066AbWL0KYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 05:24:09 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061227102408.CYUE97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Dec 2006 05:24:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3mQM1W00L1kojtg0000000; Wed, 27 Dec 2006 05:24:22 -0500
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <emtgps$f1q$1@sea.gmane.org> (Jakub Narebski's message of "Wed,
	27 Dec 2006 11:12:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35460>

Jakub Narebski <jnareb@gmail.com> writes:

> That's a bit bad, as it forces to lose some info... but that
> info was not that useful anyway.

I am tired of listening to this useless FUD of yours.  You lost
the information when you pruned away the underlying objects; you
are not losing information when you expire the reflog entries
that became useless long time ago.

> I don't quite like it. Why if someone uses different encoding
> that utf-8 because his terminal is not set to utf-8? Having suddenly
> what looks like garbage on output, while input was in local encoding
> (and specified in i18n.commitencoding) is a bit suprising...

If Luben wants UTF-8 in his project, but somebody he pulled from
was mistakenly used latin-1, then the commit pulled record
latin-1 while Luben has i18n.commitencoding in his repository
set to UTF-8.  Output will be done in UTF-8 for Luben.  For the
originator of that latin-1 commit, i18n.commitencoding says
latin-1 (and that was the only reason he managed to create such
a commit) and git show of that commit would not involve
recoding.

At least that is the idea.  Have you spotted a bug, perhaps?

>> (shortlog since v1.4.4.3 here)
>
> I'd rather have description a la "what's cooking" here... 

Send the summary to the list and I'll append it to the release
notes.
