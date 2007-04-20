From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Contribute a fairly paranoid update hook
Date: Fri, 20 Apr 2007 10:27:18 -0700
Message-ID: <7v647ryn0p.fsf@assigned-by-dhcp.cox.net>
References: <20070420060847.GA8255@spearce.org>
	<7vmz131fzz.fsf@assigned-by-dhcp.cox.net>
	<20070420145923.GB17480@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Apr 20 19:27:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HewtH-0002A2-HJ
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 19:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767163AbXDTR1U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 13:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993300AbXDTR1U
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 13:27:20 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:61584 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993298AbXDTR1T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 13:27:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070420172720.FTZU1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Fri, 20 Apr 2007 13:27:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id pVTK1W0031kojtg0000000; Fri, 20 Apr 2007 13:27:19 -0400
In-Reply-To: <20070420145923.GB17480@spearce.org> (Shawn O. Pearce's message
	of "Fri, 20 Apr 2007 10:59:23 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45118>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> 
>> > +$ENV{PATH}     = '/opt/git/bin';
>> 
>> This caught my attention ;-).
>
> What, is replacing PATH in the hook really all that paranoid?
> Its a perfectly reasonable thing to do.  ;-)

I 100% agree it is the right thing to to make sure PATH is a
known good value.  What caught my attention is /opt/git/bin
is the *ONLY* place you need to look at, not even /usr/bin!
