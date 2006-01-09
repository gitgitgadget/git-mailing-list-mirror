From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUCNE] GIT 1.1.0
Date: Mon, 09 Jan 2006 02:38:30 -0800
Message-ID: <7vbqylpty1.fsf@assigned-by-dhcp.cox.net>
References: <7v4q4eurgu.fsf@assigned-by-dhcp.cox.net>
	<20060109084930.GA560@localhost.localdomain>
	<7vr77hpwla.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 11:38:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvuQK-0004sQ-9b
	for gcvg-git@gmane.org; Mon, 09 Jan 2006 11:38:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWAIKic (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 05:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWAIKic
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 05:38:32 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:62916 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750955AbWAIKic (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2006 05:38:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060109103718.XAYN20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 9 Jan 2006 05:37:18 -0500
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
In-Reply-To: <7vr77hpwla.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 09 Jan 2006 01:41:21 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14370>

Junio C Hamano <junkio@cox.net> writes:

> Coywolf Qi Hunt <qiyong@fc-cn.com> writes:
>
>> Why not support debian? I see the debian directory is outdated.
>
> I think that was discussed already this year, so look in the
> list archive for the past 10 days or so please before asking.

Especially, please see this thread:

    http://marc.theaimsgroup.com/?l=git&m=113576889301331 

I haven't received any patches to re-add debian/ directory from
Gerrit since I removed it, and I do not expect nor wish to get
one.  I respect Gerrit's request not to ship debian/ directory
myself.

If you want to see deb packages at kernel.org built by me, you
need to convince both Gerrit and me with a workable workflow
that does not add extra burden on us and avoids confusion.

A starting point might be for me to slave debian/ part from
Gerrit, updating debian/changelog with only X.Y.Z-0 entries by
me, and publish X.Y.Z-0 packages at kernel.org.
