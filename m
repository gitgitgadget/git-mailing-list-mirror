From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] make git compile on old version of engarde linux
Date: Sat, 12 Aug 2006 16:09:11 -0700
Message-ID: <7vr6zlo8ko.fsf@assigned-by-dhcp.cox.net>
References: <7vac6etz5n.fsf@assigned-by-dhcp.cox.net>
	<20060812224520.GB13704@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 13 01:09:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GC2bW-0004fW-4x
	for gcvg-git@gmane.org; Sun, 13 Aug 2006 01:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbWHLXJP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Aug 2006 19:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWHLXJO
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Aug 2006 19:09:14 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:8683 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S964954AbWHLXJN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Aug 2006 19:09:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060812230912.MVVD14543.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 12 Aug 2006 19:09:12 -0400
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <20060812224520.GB13704@mellanox.co.il> (Michael S. Tsirkin's
	message of "Sun, 13 Aug 2006 01:45:20 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25271>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

>> Alternatively Ramsay's _XOPEN_SOURCE patch is part of "next", so
>> if it fixes the problem for you that would confirm the patch is
>> a good one to have.
>
> BTW, would it make sense fr this patch to be cherry-picked into 1.4.8?
> I guess the reason that LNK macros are under GNU_SOURCE is the following
> text from stat(2):
>  
>        The S_ISLNK and S_ISSOCK macros
>        are not in POSIX.1-1996, but both will be in the next  POSIX  standard;
>        the former is from SVID 4v2, the latter from SUSv2.

I originally scheduled it for immediately after 1.4.2 but I
would say why not.  It makes sense and does not seem to break
for people (otherwise I would have heard screams, hopefully).
