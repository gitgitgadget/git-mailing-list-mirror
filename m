From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Sat, 31 Mar 2007 13:54:58 +0200
Message-ID: <20070331115458.GC4377@steel.home>
References: <7v1wj5ycx5.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 31 13:55:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXcAt-00064k-Aa
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 13:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971AbXCaLzB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 07:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752996AbXCaLzB
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 07:55:01 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:45421 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbXCaLzA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 07:55:00 -0400
Received: from tigra.home (Fc8c6.f.strato-dslnet.de [195.4.200.198])
	by post.webmailer.de (mrclete mo58) (RZmta 5.5)
	with ESMTP id J01921j2V8QXUi ; Sat, 31 Mar 2007 13:54:59 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B7198277B6;
	Sat, 31 Mar 2007 13:54:58 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 4AC85D150; Sat, 31 Mar 2007 13:54:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v1wj5ycx5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+WNdA=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43549>

Junio C Hamano, Sat, Mar 31, 2007 11:34:14 +0200:
> 
> If you can remind me of patches that are "must have"s for 1.5.1
> that I've missed, that would be very nice.  We've broken "git
> am" and "git rebase" (without --merge) on 'master' branch for
> people who has i18n contents after 1.5.0 but they should be
> fixed now.

We still have absolutely broken merge-recursive WRT rename/rename
conflicts in intermediate trees.

> Please, remember that the key word for this weekend is "make
> 1.5.1 NO WORSE than 1.5.0".  IOW, the focus is on obvious
> regression fixes.

It is "no worse", but doesn't "pretty bad" count?
