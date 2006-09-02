From: Junio C Hamano <junkio@cox.net>
Subject: Re: Mozilla .git tree
Date: Sat, 02 Sep 2006 13:55:24 -0700
Message-ID: <7vejuuyon7.fsf@assigned-by-dhcp.cox.net>
References: <20060829232007.GC22935@spearce.org>
	<9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com>
	<20060830015122.GE22935@spearce.org>
	<9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
	<20060830031029.GA23967@spearce.org>
	<Pine.LNX.4.64.0608300124550.9796@xanadu.home>
	<7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net>
	<7vr6yw58xp.fsf@assigned-by-dhcp.cox.net>
	<20060902020426.GF24234@spearce.org>
	<7v3bba1qg5.fsf@assigned-by-dhcp.cox.net>
	<20060902175125.GC27826@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 22:55:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJcWR-0007pZ-4Q
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 22:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbWIBUzU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 16:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbWIBUzU
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 16:55:20 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:41643 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751572AbWIBUzT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 16:55:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060902205518.XDCG4015.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Sat, 2 Sep 2006 16:55:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HYvJ1V00v1kojtg0000000
	Sat, 02 Sep 2006 16:55:19 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060902175125.GC27826@spearce.org> (Shawn Pearce's message of
	"Sat, 2 Sep 2006 13:51:25 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26356>

Shawn Pearce <spearce@spearce.org> writes:

>> > Sure the scheme you outlined allows a 64 bit difference but
>> > uncompressed objects already can't be larger than 2**32-1...
>> 
>> Where do we have that limitation?
>
> sha1_file.c uses "unsigned long" a lot to deal with size of an
> object, deflated.  iirc unsigned long is only 32 bits even in many
> 64 bit architectures.  Or am I wrong?

Of course 4G .idx (\377tOc) patch would update them to u64.
What is the problem?


-- 
VGER BF report: U 0.905241
