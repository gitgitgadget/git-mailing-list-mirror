From: Junio C Hamano <junkio@cox.net>
Subject: Re: problems of git-status
Date: Wed, 28 Mar 2007 01:57:46 -0700
Message-ID: <7vy7lhkanp.fsf@assigned-by-dhcp.cox.net>
References: <460A2054.20404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Liu Yubao <yubao.liu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 11:03:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWU3y-0003H9-72
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 11:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933961AbXC1I6F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 04:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934015AbXC1I6F
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 04:58:05 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:55595 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933961AbXC1I6D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 04:58:03 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070328085746.QNXU25613.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 28 Mar 2007 04:57:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id g8xm1W00C1kojtg0000000; Wed, 28 Mar 2007 04:57:46 -0400
In-Reply-To: <460A2054.20404@gmail.com> (Liu Yubao's message of "Wed, 28 Mar
	2007 15:59:16 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43359>

Liu Yubao <yubao.liu@gmail.com> writes:

>    I find "git status" and "git status ." have different output. 

Think of "git status $ANY_ARGUMENTS" a preview of "git commit
$ANY_ARGUMENTS".  If you have local modifications, "git commit"
and "git commit ." would do different things, so corresponding
"git status" should give you different output.

By giving "." to git status, the latter form is asking what
reminder message you would see in the commit log message buffer
if you say "git commit ."
