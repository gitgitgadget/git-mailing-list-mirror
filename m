From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] pack-refs --all
Date: Sun, 08 Oct 2006 12:56:18 -0700
Message-ID: <7vlknqintp.fsf@assigned-by-dhcp.cox.net>
References: <7v4pufkz55.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0610081401000.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 08 21:56:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWel5-0006j7-GQ
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 21:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWJHT4U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 15:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWJHT4U
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 15:56:20 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:29179 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751384AbWJHT4T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Oct 2006 15:56:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061008195619.BXJV22409.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Sun, 8 Oct 2006 15:56:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XvwA1V00W1kojtg0000000
	Sun, 08 Oct 2006 15:56:10 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28545>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 8 Oct 2006, Junio C Hamano wrote:
>
>> This changes 'git-pack-refs' to pack only tags by default.
>
> Since there is not really a high cost attached, why not migrate towards 
> only-packed-refs? (Of course, this means that git-update-ref should learn 
> to update in-place)?

It indeed is tempting and I was tempted to do that and unify
that with ref-log when we were talking about packed refs before
I saw Linus's initial implementation.
