From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-branch: show detached HEAD
Date: Tue, 02 Jan 2007 23:05:20 -0800
Message-ID: <7v1wmcr3nz.fsf@assigned-by-dhcp.cox.net>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net>
	<1167780131528-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 03 08:05:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H20Bm-0003M7-D7
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 08:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780AbXACHFW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 02:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754826AbXACHFW
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 02:05:22 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:39492 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780AbXACHFW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 02:05:22 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070103070521.DLVX2628.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Wed, 3 Jan 2007 02:05:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6X5b1W00V1kojtg0000000; Wed, 03 Jan 2007 02:05:36 -0500
To: Lars Hjemli <hjemli@gmail.com>
In-Reply-To: <1167780131528-git-send-email-hjemli@gmail.com> (Lars Hjemli's
	message of "Wed, 3 Jan 2007 00:22:11 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35847>

Lars Hjemli <hjemli@gmail.com> writes:

> This makes git-branch show a detached HEAD as '* (no branch)'.
>
> Signed-off-by: Lars Hjemli <hjemli@gmail.com>
> ---
>
> This might be a premature patch. But if/when we allow HEAD to be detached, 
> git-branch should tell us that HEAD is the current 'branch'.

I fully agree with the motivation, but 100 lines of change to
adjust only to detached HEAD seems too much.  What else is going
on in this patch, I wonder...

Can we have two patches, one for loop restructuring without
detached HEAD support, and then another to add support for it?
