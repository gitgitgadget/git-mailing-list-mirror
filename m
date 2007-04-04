From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Tue, 03 Apr 2007 23:25:58 -0700
Message-ID: <7v3b3g8xl5.fsf@assigned-by-dhcp.cox.net>
References: <20070322104021.GJ29341@mellanox.co.il>
	<7v7it7kkl9.fsf@assigned-by-dhcp.cox.net>
	<20070404060213.GB31984@mellanox.co.il>
	<7vircc8ybz.fsf@assigned-by-dhcp.cox.net>
	<20070404061958.GB30309@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 08:26:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYywX-0004Zg-7x
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 08:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbXDDG0B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 02:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753493AbXDDG0A
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 02:26:00 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:33071 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbXDDG0A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 02:26:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070404062559.DTYY373.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Wed, 4 Apr 2007 02:25:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id iuRz1W0051kojtg0000000; Wed, 04 Apr 2007 02:25:59 -0400
In-Reply-To: <20070404061958.GB30309@spearce.org> (Shawn O. Pearce's message
	of "Wed, 4 Apr 2007 02:19:58 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43714>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
>> > *Maybe* git can be even smarter, and notice that only
>> > commit message has changed, and preserve the author automatically
>> > in this case? I haven't looked at how hard that would be to do.
>> 
>> Maybe you can try what you complain about out before you rant?
>> I amend other people's commit messages after the fact almost
>> *every* *day*.
>
> Me too.  And I *know* Junio amends my stuff after applying it to
> git.git.  Just look back at the history to see how many thinkos
> he's saved me from...  ;-)

Actually, you cannot know.  I may well be editing your mesage in
my mailbox before applying, like Linus does.
