From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] Overlapping projects
Date: Mon, 09 May 2005 23:19:55 -0700
Message-ID: <7vhdhbr4ac.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0505100135110.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 08:13:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVNzZ-0000EN-1W
	for gcvg-git@gmane.org; Tue, 10 May 2005 08:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVEJGUN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 02:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVEJGUN
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 02:20:13 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:64656 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261563AbVEJGT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 02:19:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050510061954.IAEU7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 10 May 2005 02:19:54 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505100135110.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Tue, 10 May 2005 01:51:01 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

>> ...
>> with an instruction like:
>> 
>> ...  Theoretically they can be independently updated to
>> the latest but preferred combination is to use at least this
>> release of core GIT to use this version of Cogito ...

DB> But when Petr adds something to the core, intended for eventual inclusion
DB> in the mainline, and uses it in cogito, this breaks everything, because
DB> then people have to know to pull both the latest cogito and the latest git
DB> from him. If the new git isn't backwards-compatible, then someone building
DB> an old cogito would have to somehow find the matching old git.

I think we are in agreement and saying the same thing.  Yes, if
people wants to do mix and match, they should know what they are
doing.

Also I do not see any reason not to have GIT that comes from
Cogito additional stuff while Linus tree lags behind, which in a
sense already has been the case for some commands.  Separating
directories would make things easier to manage, not harder.

Anyhow let's wait and see what Petr does.  He said he has been
preparing core backports earlier.  No point arguing about his
tree without helping him.

