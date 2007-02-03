From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] builtin-branch: be prepared for ref-logging
Date: Sat, 03 Feb 2007 11:50:05 -0800
Message-ID: <7vr6t73tsi.fsf@assigned-by-dhcp.cox.net>
References: <11705213662728-git-send-email-tutufan@gmail.com>
	<11705277471962-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 20:50:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDQtn-0007dB-8A
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 20:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbXBCTuI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 14:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbXBCTuI
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 14:50:08 -0500
Received: from fed1rmmtai19.cox.net ([68.230.241.40]:53647 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751391AbXBCTuH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 14:50:07 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070203195006.BBCM1349.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Feb 2007 14:50:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id K7q51W01c1kojtg0000000; Sat, 03 Feb 2007 14:50:06 -0500
In-Reply-To: <11705277471962-git-send-email-hjemli@gmail.com> (Lars Hjemli's
	message of "Sat, 3 Feb 2007 19:35:47 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38591>

Lars Hjemli <hjemli@gmail.com> writes:

> The test for reflog parameter to create_branch() should also have tested
> for log_all_ref_updates. But there is no good reason not to prepare a
> reflog message, so lets just do it.
>
> Signed-off-by: Lars Hjemli <hjemli@gmail.com>
> ---
>
> Sorry, the previous patch was obviously no good, since it didn't honour
> the case where (reflog==1 && log_all_ref_updates==0)

Ah, I did not see your fix-up patch before I sent out my
comments.

Funny thing is that I thought I fixed this already, but
apparently I didn't.  It could have been one of my "fixing in
working tree, sending out a patch to the list for comments and
then forgetting to apply it".  Maybe not.

In any case, thanks for the fix.
