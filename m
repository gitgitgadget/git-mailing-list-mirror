From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] checkout: allow full refnames for local branches
Date: Wed, 09 May 2007 01:48:57 -0700
Message-ID: <7v7iriwfeu.fsf@assigned-by-dhcp.cox.net>
References: <11787000032830-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 10:49:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlhrK-0005Fk-P6
	for gcvg-git@gmane.org; Wed, 09 May 2007 10:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbXEIItA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 04:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754375AbXEIItA
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 04:49:00 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:50880 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbXEIIs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 04:48:59 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070509084858.EHSN24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 04:48:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id wwox1W00P1kojtg0000000; Wed, 09 May 2007 04:48:58 -0400
In-Reply-To: <11787000032830-git-send-email-hjemli@gmail.com> (Lars Hjemli's
	message of "Wed, 9 May 2007 10:40:03 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46683>

Lars Hjemli <hjemli@gmail.com> writes:

> This teaches git-checkout to strip the prefix 'refs/heads/' from the
> supplied <branch> argument, to make
>
> 	git-checkout refs/heads/master
>
> behave like
>
> 	git-checkout master
>
> The former command would detach HEAD.
>
> Signed-off-by: Lars Hjemli <hjemli@gmail.com>
> ---
>
> I'm undecided on wheter this is a bugfix or a new feature. It certainly
> introduces new behaviour, but it passes all the tests.

Why is this necessary, may I ask?
