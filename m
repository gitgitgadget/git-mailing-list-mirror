From: Junio C Hamano <junkio@cox.net>
Subject: Re: Regression: git-commit no longer works from within subdirectories
Date: Thu, 03 Aug 2006 12:05:19 -0700
Message-ID: <7vzmelprm8.fsf@assigned-by-dhcp.cox.net>
References: <44D23B1C.80704@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 03 21:05:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8iVZ-00053s-H4
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 21:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWHCTFW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 15:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbWHCTFV
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 15:05:21 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:49346 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030196AbWHCTFV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 15:05:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060803190520.EAHB18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Aug 2006 15:05:20 -0400
To: Robert Shearman <rob@codeweavers.com>
In-Reply-To: <44D23B1C.80704@codeweavers.com> (Robert Shearman's message of
	"Thu, 03 Aug 2006 19:06:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24747>

Robert Shearman <rob@codeweavers.com> writes:

> In the latest master branch git-commit no longer works from within
> subdirectories. Instead, you have to go to the top-level directory of
> the git tree to do the commit.

This is broken and sorry I did not notice it earlier because I
usually run the tip of "next".  Will take a look.
