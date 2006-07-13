From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] format-patch: Generate a newline between the subject header and the message body.
Date: Thu, 13 Jul 2006 14:31:01 -0700
Message-ID: <7vbqrtur8q.fsf@assigned-by-dhcp.cox.net>
References: <44B6369D.6070602@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 23:31:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G18m5-0007Sw-LD
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 23:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030409AbWGMVbF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 17:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWGMVbF
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 17:31:05 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:63645 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1030409AbWGMVbE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 17:31:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060713213103.FGPT22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Jul 2006 17:31:03 -0400
To: Robert Shearman <rob@codeweavers.com>
In-Reply-To: <44B6369D.6070602@codeweavers.com> (Robert Shearman's message of
	"Thu, 13 Jul 2006 13:03:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23853>

Robert Shearman <rob@codeweavers.com> writes:

> This patch inserts a newline in two places - once in the loop to
> separate the subject part of the commit message from the body part of
> the commit message and another after the loop to counteract the eating
> of whitespace at the end of the message.

Thanks.

 * Please sign your patch.

 * This breaks a handful t4013 tests, but all in a good way (in
   other words, the expected output files were wrong).

I'll fix up the t/t4013/diff.* files myself.
