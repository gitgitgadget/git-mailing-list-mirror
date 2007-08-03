From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and Mercurial
Date: Thu, 02 Aug 2007 17:51:50 -0700
Message-ID: <7v3az1samx.fsf@assigned-by-dhcp.cox.net>
References: <200708010216.59750.jnareb@gmail.com>
	<alpine.LFD.0.999.0707311850220.4161@woody.linux-foundation.org>
	<7vodhrby6f.fsf@assigned-by-dhcp.cox.net>
	<20070801092428.GB28106@thunk.org>
	<7vr6mn5znm.fsf@assigned-by-dhcp.cox.net>
	<87tzrjfe5h.wl%cworth@cworth.org>
	<alpine.LFD.0.999.0708010937050.3582@woody.linux-foundation.org>
	<7vejim1n92.fsf@assigned-by-dhcp.cox.net>
	<86tzrikz5x.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 03 02:51:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGlOV-0000PO-CH
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 02:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbXHCAvw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 20:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbXHCAvw
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 20:51:52 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:44380 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbXHCAvw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 20:51:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070803005151.YTOY7349.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Aug 2007 20:51:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XCrq1X00Y1kojtg0000000; Thu, 02 Aug 2007 20:51:51 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54657>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>  * With -l, as long as the source repository is healthy, it is
>>    very likely that the recipient would be, too.  Also it is
>>    very cheap.  You do not get any back-up benefit.
>
> Oh, but one does: an overzealous prune or rm -oopswrongoption in one
> repo does not hurt the other.

That's not "back-up" benefit I was thinking about.  It is more
about protecting your data from hardware failure.  You
physically have bits in two places, preferrably on separate disk
drives.

And that is what you do not get from hardlinked clone.
