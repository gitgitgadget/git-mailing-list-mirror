From: Junio C Hamano <junkio@cox.net>
Subject: Re: Pulling from refs/remotes/ ?
Date: Thu, 24 May 2007 18:53:30 -0700
Message-ID: <7v3b1lvfc5.fsf@assigned-by-dhcp.cox.net>
References: <f35d9n$21e$1@sea.gmane.org>
	<7v7iqxvgx8.fsf@assigned-by-dhcp.cox.net> <46563D55.3070607@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Fri May 25 03:53:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrOzl-0007Z3-17
	for gcvg-git@gmane.org; Fri, 25 May 2007 03:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbXEYBxc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 21:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752587AbXEYBxc
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 21:53:32 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:58924 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbXEYBxb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 21:53:31 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070525015330.QAJC2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Thu, 24 May 2007 21:53:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3DtW1X00S1kojtg0000000; Thu, 24 May 2007 21:53:31 -0400
In-Reply-To: <46563D55.3070607@xs4all.nl> (Han-Wen Nienhuys's message of "Thu,
	24 May 2007 22:35:17 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48328>

Han-Wen Nienhuys <hanwen@xs4all.nl> writes:

> Yes, that works, thanks. Wouldn't it be more consistent with this
> reasoning to disallow 
>
>   git pull . LOCAL-BRANCH 
>
> too?

I do not think so.

If somebody else (or yourself) did:

	$ git pull $dir LOCAL-BRANCH

(replace $dir with the `pwd` you would get in your repository),
that would work.  Why shouldn't it work for yourself?
