From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Use File::Find::find in git_get_projects_list
Date: Thu, 14 Sep 2006 09:42:33 -0700
Message-ID: <7vmz924cxy.fsf@assigned-by-dhcp.cox.net>
References: <200609140839.56181.jnareb@gmail.com>
	<200609140959.04061.jnareb@gmail.com>
	<7vvenq4wgp.fsf@assigned-by-dhcp.cox.net>
	<200609141201.41711.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 18:42:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNuIQ-0000Dm-Cy
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 18:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWINQmf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 12:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWINQmf
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 12:42:35 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:60354 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750700AbWINQmf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 12:42:35 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060914164234.DGQY2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Thu, 14 Sep 2006 12:42:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NGiP1V0091kojtg0000000
	Thu, 14 Sep 2006 12:42:23 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200609141201.41711.jnareb@gmail.com> (Jakub Narebski's message
	of "Thu, 14 Sep 2006 12:01:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27011>

Jakub Narebski <jnareb@gmail.com> writes:

> Sorry, this comment was leftover from before, when no_chdir was not 
> used. Then $_ was the last part of directory,...

Ah, thanks.  I missed that difference.  Did you choose to use
no_chdir for performance reasons or coding convenience (somehow
I had an impression that no_chdir would be slower)?

> Sorry for the confusion. By index I meant alternate way of specyfying 
> projects,...

Again, thanks for clarification.  I forgot about the handcrafted
project index file gitweb uses.

> First of all, why duplicated repositories are considered
> error? ... it is not that something bad would happen if there
> are duplicated repositories.

Fair enough, and I agree that that is a sane reasoning.  Thanks.
