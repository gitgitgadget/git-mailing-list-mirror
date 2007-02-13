From: Junio C Hamano <junkio@cox.net>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 10:00:45 -0800
Message-ID: <7v7iumx7hu.fsf@assigned-by-dhcp.cox.net>
References: <45CFA30C.6030202@verizon.net>
	<200702130932.51601.litvinov2004@gmail.com>
	<Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
	<Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 13 19:00:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH1xS-0006Ac-G4
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 19:00:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbXBMSAr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 13:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbXBMSAr
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 13:00:47 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:56459 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbXBMSAq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 13:00:46 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070213180045.SHYT4586.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 13 Feb 2007 13:00:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id P60l1W00S1kojtg0000000; Tue, 13 Feb 2007 13:00:46 -0500
In-Reply-To: <Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 13 Feb 2007 09:23:24 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39560>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Here's a patch that I think we can merge right now. There may be other 
> places that need this, but this at least points out the three places that 
> read/write working tree files for git update-index, checkout and diff 
> respectively. That should cover a lot of it.

Thanks, applied.  I think git-apply has separate codepaths for
both reading and writing; I won't look into them before 1.5.0
but people are welcome to help advancing the cause before I get
to it ;-).
