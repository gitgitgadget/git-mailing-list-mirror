From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Multiple refs from the same remote in one git fetch
Date: Sat, 12 Aug 2006 16:07:29 -0700
Message-ID: <7vveoxo8ni.fsf@assigned-by-dhcp.cox.net>
References: <7vr6zsywmq.fsf@assigned-by-dhcp.cox.net>
	<20060812223947.GA13704@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 13 01:07:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GC2Zu-0004R5-Jc
	for gcvg-git@gmane.org; Sun, 13 Aug 2006 01:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWHLXHb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Aug 2006 19:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbWHLXHb
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Aug 2006 19:07:31 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:31121 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S964899AbWHLXHb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Aug 2006 19:07:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060812230730.BBIE2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 12 Aug 2006 19:07:30 -0400
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <20060812223947.GA13704@mellanox.co.il> (Michael S. Tsirkin's
	message of "Sun, 13 Aug 2006 01:39:47 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25269>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

> Quoting r. Junio C Hamano <junkio@cox.net>:
>> Subject: Re: [PATCH] Multiple refs from the same remote in one git fetch
>> 
>> "Michael S. Tsirkin" <mst@mellanox.co.il> writes:
>> 
>> > The following seems to fix this issue: simply scan the full
>> > refspec list for each remote instead of breaking on the first match.
>> > I had to touch the git-fetch.sh script as well as it is scanning
>> > the remote list, too. Works for me.
>> 
>> Looks Ok, although I have to admit I just gave a cursory look.
>> Thanks.
>> 
>
> Could this go into next then? 

No.  Spoke too fast.  Breaks t6200 test because it reports the
refs fetched in duplicates.
