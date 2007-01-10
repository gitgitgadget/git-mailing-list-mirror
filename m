From: Junio C Hamano <junkio@cox.net>
Subject: Re: Recovering from an aborted git-rebase?
Date: Tue, 09 Jan 2007 16:25:17 -0800
Message-ID: <7v3b6jiv82.fsf@assigned-by-dhcp.cox.net>
References: <45A42341.8040304@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 01:25:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4RHP-00086j-Bu
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 01:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbXAJAZT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 19:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbXAJAZT
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 19:25:19 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:57675 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932583AbXAJAZS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 19:25:18 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070110002517.KZTP25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Tue, 9 Jan 2007 19:25:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9CQT1W00F1kojtg0000000; Tue, 09 Jan 2007 19:24:27 -0500
To: Steven Grimm <koreth@midwinter.com>
In-Reply-To: <45A42341.8040304@midwinter.com> (Steven Grimm's message of "Tue,
	09 Jan 2007 15:20:33 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36440>

Steven Grimm <koreth@midwinter.com> writes:

> dev005:~/www-git$ git rebase master
> First, rewinding head to replay your work on top of it...
> HEAD is now at a5074e5... Fix IE6 display bug on photo_comments
> *********
> at this point I think to myself "oops, I meant to rebase to fql, not to
> master" and press ctrl+c
> *********

Doesn't "git rebase --abort" work for you at this point?
