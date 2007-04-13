From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git-clone: add --track <headname> support
Date: Thu, 12 Apr 2007 17:28:16 -0700
Message-ID: <7v3b35i0db.fsf@assigned-by-dhcp.cox.net>
References: <1176372539871-git-send-email-martin@catalyst.net.nz>
	<87veg1tuuv.wl%cworth@cworth.org> <461EA8C5.1070503@catalyst.net.nz>
	<87slb5tbvu.wl%cworth@cworth.org> <461EC5DC.6060903@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org, junkio@cox.net
To: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Fri Apr 13 02:28:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc9eH-0001tV-I9
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 02:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930AbXDMA2S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 20:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753943AbXDMA2R
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 20:28:17 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:50085 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753930AbXDMA2R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 20:28:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070413002816.NVDE1266.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 12 Apr 2007 20:28:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id mQUG1W00C1kojtg0000000; Thu, 12 Apr 2007 20:28:16 -0400
In-Reply-To: <461EC5DC.6060903@catalyst.net.nz> (Martin Langhoff's message of
	"Fri, 13 Apr 2007 11:50:52 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44375>

Martin Langhoff <martin@catalyst.net.nz> writes:

> If your tree is reasonably clean (so that the implied git-checkout won't
> fail), then on 1.5.1 this Just Works
>
>         git branch --track <branch> origin/<branch>
>         git pull # as needed

At least in theory, with branch.autosetupmerge, you shouldn't
even have to say --track there.  I've never used it myself,
though.
