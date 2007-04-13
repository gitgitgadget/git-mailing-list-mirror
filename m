From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-quiltimport complaining yet still working
Date: Fri, 13 Apr 2007 15:42:46 -0700
Message-ID: <7vodlrc2vt.fsf@assigned-by-dhcp.cox.net>
References: <20070413203837.GA27660@kroah.com>
	<Pine.LNX.4.64.0704131431040.28042@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg KH <greg@kroah.com>, Don Zickus <dzickus@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Apr 14 00:42:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcUTj-0000A6-Nd
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 00:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030477AbXDMWmt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 18:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030866AbXDMWms
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 18:42:48 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:57665 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030477AbXDMWms (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 18:42:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070413224248.GHTI1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 13 Apr 2007 18:42:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id mmin1W0041kojtg0000000; Fri, 13 Apr 2007 18:42:47 -0400
In-Reply-To: <Pine.LNX.4.64.0704131431040.28042@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 13 Apr 2007 14:34:18 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44438>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> This should fix it.
>
> There were two bugs: "stop_here" doesn't exist, but the bug that causes 
> this code to trigger in the *first* place is the wrong use of "$dotest". 
> It should be ".dotest"

I am quite sure that I've said the same thing as above in my
earlier message to fix this exact thing, but as usual I appear
to have sent it to the list and then forgot to apply it myself.

Thanks.
