From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-format-patch possible regressions
Date: Thu, 25 May 2006 16:11:24 -0700
Message-ID: <7vy7wpr97n.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550605251223g2cf8cfb9vfa18d016b369188d@mail.gmail.com>
	<7vhd3dubd9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0605252338530.31700@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0605260014340.13003@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri May 26 01:11:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjOzK-0003nF-6y
	for gcvg-git@gmane.org; Fri, 26 May 2006 01:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbWEYXL1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 19:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbWEYXL1
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 19:11:27 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:11933 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S965073AbWEYXL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 19:11:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060525231125.ZVKA15767.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 25 May 2006 19:11:25 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0605260014340.13003@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 26 May 2006 00:18:12 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20770>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Thinking about this again, it makes more sense not to imply --numbered:

Yes, that makes sense.  That way you can say "Please start
naming the output files at 0032-xxxx.txt, because you gave me 31
patch series last time, but I do not want [PATCH x/y] on the
subject line, just [PATCH]".

That brings up another issue.  Don't we need to have another
option --total-number that overrides the /y part above?

Hmm...
