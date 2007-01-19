From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-fetch fails if remote is detached HEAD
Date: Fri, 19 Jan 2007 14:23:20 -0800
Message-ID: <7v7ivifyg7.fsf@assigned-by-dhcp.cox.net>
References: <200701191144.35773.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 23:23:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H828r-0005ML-2q
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 23:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbXASWXW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 17:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbXASWXW
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 17:23:22 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:46346 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964942AbXASWXW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 17:23:22 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070119222321.NRMQ25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 17:23:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DAPe1W0141kojtg0000000; Fri, 19 Jan 2007 17:23:39 -0500
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <200701191144.35773.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 19 Jan 2007 11:44:32 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37211>

I think it is trying to see if it is a git archive, and
the version of upload-pack you are invoking is not detached-HEAD
aware.
