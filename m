From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/6] packed deltas with offset to base instead of sha1
Date: Thu, 21 Sep 2006 21:57:53 -0700
Message-ID: <7v64fg7b1q.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0609202350450.2627@xanadu.home>
	<7v4pv1eqgl.fsf@assigned-by-dhcp.cox.net>
	<20060921160227.GC3934@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 22 06:58:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQd7F-0003J2-5g
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 06:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWIVE55 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 00:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWIVE54
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 00:57:56 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:63651 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932269AbWIVE5z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Sep 2006 00:57:55 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060922045754.IDVF18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Fri, 22 Sep 2006 00:57:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id RGxw1V0051kojtg0000000
	Fri, 22 Sep 2006 00:57:56 -0400
To: Shawn Pearce <spearce@spearce.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27518>

Shawn Pearce <spearce@spearce.org> writes:

>> Nice, although I suspect this would make it a bit more involved
>> to merge a few outstanding stuff.
>
> If you are talking about my mmap window code merge in Nico's
> work first...
> However I have looked at the merge and I more or less need to
> rewrite a good chunk of it just to get it onto 106d7; rewriting it
> onto Nico's work here is probably going to be about the same amount
> of effort.

I had the same impression, although without seeing your code.
Will see to it to have delta-offset code in "next" soonish.

Thanks.
