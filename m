From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/4] Correct comment in prepare_packed_git_one.
Date: Thu, 01 Feb 2007 22:21:09 -0800
Message-ID: <7vwt31jd0q.fsf@assigned-by-dhcp.cox.net>
References: <a0b03fc086bb66e2aa2e386dcb4ff97fc837f07f.1170363130.git.spearce@spearce.org>
	<20070201205227.GB19009@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 02 07:21:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCrnO-0002MX-F4
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 07:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423130AbXBBGVL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 01:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423132AbXBBGVL
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 01:21:11 -0500
Received: from fed1rmmtai17.cox.net ([68.230.241.42]:58677 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423130AbXBBGVK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 01:21:10 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070202062111.WAWE1343.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Fri, 2 Feb 2007 01:21:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JWM91W00N1kojtg0000000; Fri, 02 Feb 2007 01:21:09 -0500
In-Reply-To: <20070201205227.GB19009@spearce.org> (Shawn O. Pearce's message
	of "Thu, 1 Feb 2007 15:52:27 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38461>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> After staring at the comment and the associated for loop, I
> realized the comment was completely bogus.

Yeah, when the comment was written, the loop after the comment
did not exist.  The comment was talking about calling
add_packed_git() to see if the corresponding pack can be mapped,
and then upon receiving NULL, not linking p to the packed_git
linked list.
