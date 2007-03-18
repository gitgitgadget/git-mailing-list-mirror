From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/5] introduce GIT_WORK_TREE environment variable
Date: Sun, 18 Mar 2007 13:28:58 -0700
Message-ID: <7v4poil2id.fsf@assigned-by-dhcp.cox.net>
References: <20070317015855.GB19305@moooo.ath.cx>
	<7vbqiss4yw.fsf@assigned-by-dhcp.cox.net>
	<20070317143452.GA21140@moooo.ath.cx>
	<20070317144403.GC26290@moooo.ath.cx>
	<20070318201209.GA1968@moooo.ath.cx>
	<20070318202302.GA5191@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Sun Mar 18 21:29:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT20M-0004M4-Hq
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 21:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933203AbXCRU3D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 16:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933192AbXCRU3B
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 16:29:01 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:40769 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933200AbXCRU3A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 16:29:00 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070318202859.ZHQP24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 18 Mar 2007 16:28:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cLUz1W0041kojtg0000000; Sun, 18 Mar 2007 16:28:59 -0400
In-Reply-To: <20070318202302.GA5191@moooo.ath.cx> (Matthias Lederhofer's
	message of "Sun, 18 Mar 2007 21:23:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42517>

Matthias Lederhofer <matled@gmx.net> writes:

> Matthias Lederhofer <matled@gmx.net> wrote:
>> Matthias Lederhofer <matled@gmx.net> wrote:
>> > +		inside_working_tree = !prefixcmp(cwd, worktree);
>> [..]
>> > +			inside_git_dir = !prefixcmp(cwd, gitdir);
>> 
>> This time a real bug: the parameters have to be the other way around.
>
> Sorry, it was right.  prefixcmp got me confused again when doing some
> testing and the result wasn't what I expected.  I'll go and copy&paste
> 100 times !prefixcmp(str, prefix) means "begins str with prefix?"

I do not mind replacing the whole set, but keeping track of
these small "oops", "oh", "ah" are confusing to me.

Could you take a deep breath, review them yourself one more
time, and resend, *after* making sure that you are confident
with them enough to feel that you would not have to issue
"oops", "sorry", "ah this is better" messages for a few days
after sending them out, pretty please?
