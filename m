From: Junio C Hamano <junkio@cox.net>
Subject: Re: file rename causes history to disappear
Date: Wed, 06 Sep 2006 16:54:44 -0700
Message-ID: <7vpse85z5n.fsf@assigned-by-dhcp.cox.net>
References: <44FEE0BB.2060601@garzik.org>
	<Pine.LNX.4.64.0609060834520.27779@g5.osdl.org>
	<44FEED4B.30909@garzik.org>
	<Pine.LNX.4.64.0609060858050.27779@g5.osdl.org>
	<edmvfv$lt7$2@sea.gmane.org>
	<Pine.LNX.4.64.0609061131100.27779@g5.osdl.org>
	<edn5dd$c4s$2@sea.gmane.org>
	<Pine.LNX.4.64.0609061205100.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 07 01:54:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL7EJ-0000pp-Bb
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 01:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWIFXyi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 19:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbWIFXyh
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 19:54:37 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:8640 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1030261AbWIFXyg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 19:54:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060906235435.RSEK6711.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Sep 2006 19:54:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id KBuc1V00K1kojtg0000000
	Wed, 06 Sep 2006 19:54:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609061205100.27779@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 6 Sep 2006 12:06:06 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26571>

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 6 Sep 2006, Jakub Narebski wrote:
>> 
>> But --follow=<filename> with <pathspec> can be useful, e.g. when <pathspec> 
>> is a directory (or, perhaps in the future, glob), which would mean "follow
>> the contents indicated in starting hash by <filename>, and stop following
>> when it falls out outside given <pathspec>, in our case given directory".
>
> Yes, that would indeed make sense. The pathspec ends up being kept as a 
> "limiter", and basically tells you what the "context" for following is 
> allowed to be. 
>
> Color me convinced.

Likewise.
