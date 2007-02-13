From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] Fix potential command line overflow in hooks--update
Date: Tue, 13 Feb 2007 10:03:42 -0800
Message-ID: <7v3b5ax7cx.fsf@assigned-by-dhcp.cox.net>
References: <200702131423.58561.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 13 19:03:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH20I-0007Vn-GD
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 19:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbXBMSDo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 13:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbXBMSDo
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 13:03:44 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:54082 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbXBMSDn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 13:03:43 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070213180343.LKZT21668.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Tue, 13 Feb 2007 13:03:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id P63i1W00F1kojtg0000000; Tue, 13 Feb 2007 13:03:42 -0500
In-Reply-To: <200702131423.58561.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 13 Feb 2007 14:23:58 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39561>

Andy Parkins <andyparkins@gmail.com> writes:

> In a repository with a large number of refs, the following command line
> could easily overflow the command line size limitations
> ...

Thanks, applied.
