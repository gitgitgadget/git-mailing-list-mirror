From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsserver: Make always-binary mode a config file option
Date: Thu, 01 Mar 2007 01:46:51 -0800
Message-ID: <7vk5y1uwhg.fsf@assigned-by-dhcp.cox.net>
References: <7v4ppedj3r.fsf@assigned-by-dhcp.cox.net>
	<200703010840.54377.andyparkins@gmail.com>
	<46a038f90703010113o256f19a2qb1c16f4c85e5bd1c@mail.gmail.com>
	<200703010941.20161.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Martin Langhoff" <martin.langhoff@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 10:46:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMhsE-0001AZ-RJ
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 10:46:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbXCAJqx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 04:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbXCAJqx
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 04:46:53 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:37716 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964778AbXCAJqw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 04:46:52 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070301094652.RFHP2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 1 Mar 2007 04:46:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VMmr1W00U1kojtg0000000; Thu, 01 Mar 2007 04:46:52 -0500
In-Reply-To: <200703010941.20161.andyparkins@gmail.com> (Andy Parkins's
	message of "Thu, 1 Mar 2007 09:41:16 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41070>

Andy Parkins <andyparkins@gmail.com> writes:

> Erm, yes, I know that.  But who is going to set that switch?
> This isn't real CVS where the repository records that
> information.  At the moment git does not know whether any
> given file is binary or text.

What do you think I have been hacking around pathattr stuff
today for ;-)? 
