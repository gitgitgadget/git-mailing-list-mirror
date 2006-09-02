From: Junio C Hamano <junkio@cox.net>
Subject: Re: Mozilla .git tree
Date: Sat, 02 Sep 2006 04:06:19 -0700
Message-ID: <7vveo6zfx0.fsf@assigned-by-dhcp.cox.net>
References: <20060829232007.GC22935@spearce.org>
	<9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com>
	<20060830015122.GE22935@spearce.org>
	<9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
	<20060830031029.GA23967@spearce.org>
	<Pine.LNX.4.64.0608300124550.9796@xanadu.home>
	<7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net>
	<7vr6yw58xp.fsf@assigned-by-dhcp.cox.net>
	<20060902011950.GB24234@spearce.org>
	<7v8xl23oia.fsf@assigned-by-dhcp.cox.net>
	<20060902043931.GA25146@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 13:06:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJTKS-0007Ya-Hk
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 13:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWIBLGS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 07:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWIBLGS
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 07:06:18 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:5812 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751048AbWIBLGR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 07:06:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060902110616.RUHU6711.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Sat, 2 Sep 2006 07:06:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HP6B1V00H1kojtg0000000
	Sat, 02 Sep 2006 07:06:12 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060902043931.GA25146@spearce.org> (Shawn Pearce's message of
	"Sat, 2 Sep 2006 00:39:31 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26331>

Shawn Pearce <spearce@spearce.org> writes:

> Using a 28 byte index entry instead of a 32 byte index entry means
> the Mozilla historical pack index will only be 52.4 MiB rather than
> the slightly larger 59.9 MiB.

Yup, that was one consideration.  One small worry is we will be
placing u64 at 4-byte alignment by using 28-byte entries but I
think that is Ok.


-- 
VGER BF report: U 0.5
