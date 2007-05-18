From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix crlf attribute handling to match documentation
Date: Fri, 18 May 2007 11:28:40 -0700
Message-ID: <7v1whe6l5z.fsf@assigned-by-dhcp.cox.net>
References: <200705181333.32719.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 18 20:29:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp7Ca-0007eQ-Ng
	for gcvg-git@gmane.org; Fri, 18 May 2007 20:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950AbXERS2n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 14:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753742AbXERS2m
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 14:28:42 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:36005 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762116AbXERS2l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 14:28:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070518182841.IIKM14313.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 18 May 2007 14:28:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 0iUg1X00P1kojtg0000000; Fri, 18 May 2007 14:28:41 -0400
In-Reply-To: <200705181333.32719.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 18 May 2007 13:33:32 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47625>

Andy Parkins <andyparkins@gmail.com> writes:

> gitattributes.txt says, of the crlf attribute:
> ...
> However, that is not what convert.c was doing.

Thanks.  I'll take a look later.

Some addition to the existing test t/t0020-crlf.sh to
demonstrate this bug and your fix would be appropriate.
