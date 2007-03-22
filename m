From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-check-ref-format returns 1 for valid branch names
Date: Thu, 22 Mar 2007 13:32:41 -0700
Message-ID: <7vejnht3x2.fsf@assigned-by-dhcp.cox.net>
References: <dbfc82860703221324k48690833g6731ef75562839d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: "Nikolai Weibull" <now@bitwi.se>
X-From: git-owner@vger.kernel.org Thu Mar 22 21:32:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUTxm-0003Zc-59
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 21:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934230AbXCVUcn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 16:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934222AbXCVUcn
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 16:32:43 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:37090 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934230AbXCVUcm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 16:32:42 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070322203242.PTT1606.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Thu, 22 Mar 2007 16:32:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id dwYh1W00G1kojtg0000000; Thu, 22 Mar 2007 16:32:42 -0400
In-Reply-To: <dbfc82860703221324k48690833g6731ef75562839d6@mail.gmail.com>
	(Nikolai Weibull's message of "Thu, 22 Mar 2007 21:24:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42878>

"Nikolai Weibull" <now@bitwi.se> writes:

> I'm obviously doing something wrong, but in git 1.5.0.4
>
> % git check-ref-format abc
> % echo $?
> 1
>
> What am I missing here?

If you are trying to see if abc is a valid branch name, try refs/heads/abc.
