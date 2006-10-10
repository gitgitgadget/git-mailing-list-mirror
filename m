From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Understand the meaning of commas in git-send-email
Date: Tue, 10 Oct 2006 10:44:56 -0700
Message-ID: <7vzmc412w7.fsf@assigned-by-dhcp.cox.net>
References: <20061010145936.GC8993@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 19:45:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXLf4-0003o5-H1
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 19:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWJJRo6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 13:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWJJRo6
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 13:44:58 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:46522 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751072AbWJJRo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 13:44:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061010174457.XPFS12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Oct 2006 13:44:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Yhkz1V00l1kojtg0000000
	Tue, 10 Oct 2006 13:45:00 -0400
To: Matthew Wilcox <matthew@wil.cx>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28643>

Matthew Wilcox <matthew@wil.cx> writes:

> I made the mistake of adding one Cc: line with two email addresses on
> it, instead of two Cc: lines with one email address each.  Extending
> git-send-email to parse that case turns out to not be too much work.
>
> Signed-off-by: Matthew Wilcox <matthew@wil.cx>

I am not sure.  The input addresses this part of the code deals
with are of human readable form 

	Matthew Wilcox <matthew@wil.cx>
        matthew@wil.cx (Matthew Wilcox)

and the loop is extracting the part inside <> pair.

I have a mild suspicion that your patch may need to understand
quoting to handle somebody else's name safely and correctly.

	junkio@cox.net (Junio C Hamano, aka gitster)
