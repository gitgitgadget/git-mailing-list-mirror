From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 24 Apr 2007 14:41:16 -0700
Message-ID: <7vwt014fib.fsf@assigned-by-dhcp.cox.net>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net>
	<7vr6qlxexe.fsf@assigned-by-dhcp.cox.net>
	<7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
	<7vejmdq63w.fsf@assigned-by-dhcp.cox.net>
	<7v647ninbq.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0704231007i81ee20cx9a37f1c8a3df62b1@mail.gmail.com>
	<7vvefnf1wb.fsf@assigned-by-dhcp.cox.net>
	<20070423211658.GA21404@steel.home>
	<7v4pn6ep41.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0704240858w6121430fj624582539f14ceee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 23:41:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgSlM-00052x-UR
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 23:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423143AbXDXVlW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 17:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423146AbXDXVlW
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 17:41:22 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:63810 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423143AbXDXVlU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 17:41:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070424214116.PGQF1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 24 Apr 2007 17:41:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id r9hG1W00B1kojtg0000000; Tue, 24 Apr 2007 17:41:16 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45492>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 4/23/07, Junio C Hamano <junkio@cox.net> wrote:
>> ...
>> That's one of the reasons why only the filter names are assigned
>> to paths using gitattributes mechanism and what action to take
>> when a specific filter name is attached to a path is determined
>> by the config.  Missing filter driver definition in the config
>> is not an error but makes the filter a no-op passthru.
>
> Fragile. What if content is useless without filter?

In that case, the project screwed itself and it is not our
problem anymore ;-).

>> The content filtering is to massage the content into a shape
>> that is more convenient for the platform/filesystem/the user to
>> use.  The keyword here is "more convenient" and not "usable"; in
>
> how can "not usable" be "more convenient"?

I think I worded it incorrectly to be misunderstood, but I
couldn't word them better then, I do not know I can word them
better now.

Something could be 1. unusable, or 2. usable.  Among usable
shapes, there are 2-a. inconvenient but usable and 2-b. very
convenient to use.

What I tried to say was that if you use filtering mechanism to
massage contents that is unusable into usable (i.e. crossing
from 1 to 2), you are already misusing the mechanism (but we do
not prevent you because we are only "giving you a long rope").
The filter is meant to be used to cross from 2-a to 2-b.
