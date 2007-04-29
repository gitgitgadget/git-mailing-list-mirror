From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-fetch and unannotated tags
Date: Sat, 28 Apr 2007 23:44:48 -0700
Message-ID: <7v7irvfzmn.fsf@assigned-by-dhcp.cox.net>
References: <200704252004.45112.andyparkins@gmail.com>
	<200704252142.33756.andyparkins@gmail.com>
	<7vfy6ow4my.fsf@assigned-by-dhcp.cox.net>
	<200704260904.08447.andyparkins@gmail.com> <4630C377.8000602@op5.se>
	<f0t5s3$f1e$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 29 08:45:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hi39v-0001xg-55
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 08:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbXD2GpU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 02:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbXD2GpT
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 02:45:19 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:62840 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754986AbXD2Got (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 02:44:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070429064449.SOUZ1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 29 Apr 2007 02:44:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id suko1W00a1kojtg0000000; Sun, 29 Apr 2007 02:44:49 -0400
In-Reply-To: <f0t5s3$f1e$1@sea.gmane.org> (Jakub Narebski's message of "Fri,
	27 Apr 2007 17:50:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45817>

Jakub Narebski <jnareb@gmail.com> writes:

> You can delete branch (ref?) using "<branch>:" refspec, if server you push to
> has git new enough. HTH.

I think you mean

	$ git push $URL :refs/heads/i-do-not-want-this-branch-anymore

that is, colon before existing ref, not after.
