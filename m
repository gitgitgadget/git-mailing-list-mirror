From: Junio C Hamano <junkio@cox.net>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Wed, 14 Feb 2007 09:18:56 -0800
Message-ID: <7vbqjwr727.fsf@assigned-by-dhcp.cox.net>
References: <45CFA30C.6030202@verizon.net>
	<7v7iumx7hu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org>
	<200702141736.57521.litvinov2004@gmail.com>
	<Pine.LNX.4.64.0702140835440.3604@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Litvinov <litvinov2004@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 18:19:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHNmq-0008Ft-Mh
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 18:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbXBNRS6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 12:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbXBNRS6
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 12:18:58 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:62714 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbXBNRS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 12:18:57 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214171857.FLNZ21704.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 12:18:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PVJw1W00m1kojtg0000000; Wed, 14 Feb 2007 12:18:57 -0500
In-Reply-To: <Pine.LNX.4.64.0702140835440.3604@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 14 Feb 2007 08:37:33 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39693>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 14 Feb 2007, Alexander Litvinov wrote:
>> 
>> I just tried this patch and it works! From now I can use git-cvsimport under 
>> Linux and then clone it to cygwin and work there with full history. Nice, 
>> very nice.
>
> Btw, it didn't do any commit message conversion etc, so you'll still 
> always see commit messages with LF-only, and if you _create_ commits, you 
> need to make sure that whatever program you use will do the right thing.

I think stripspace removes CR so we should be Ok.
