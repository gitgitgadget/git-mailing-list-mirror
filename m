From: Junio C Hamano <junkio@cox.net>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 10:11:54 -0800
Message-ID: <7vlkj2vset.fsf@assigned-by-dhcp.cox.net>
References: <45CFA30C.6030202@verizon.net>
	<200702130932.51601.litvinov2004@gmail.com>
	<Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
	<Pine.LNX.4.63.0702131901040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 13 19:12:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH28F-0002yE-Gj
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 19:11:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbXBMSL4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 13:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbXBMSL4
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 13:11:56 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:64666 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbXBMSLz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 13:11:55 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070213181156.XVVS1306.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 13 Feb 2007 13:11:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id P6Bu1W00F1kojtg0000000; Tue, 13 Feb 2007 13:11:55 -0500
In-Reply-To: <Pine.LNX.4.63.0702131901040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 13 Feb 2007 19:04:26 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39570>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> No hooks means something like cvsnt does, and that means no .gitattributes 
> either. (BTW I really hate .gitattributes, as it does not at all say what 
> this is about; it's about file _conversions_, not attributes).

> However, I am slightly positive about the .gitfiletypes approach, _iff_ we 
> think about more than just text/binary from the start. If we do it right, 
> it will buy us more.

We might start with only binary/text attributes, but we may add
more later, e.g. chmod=o-rwx.  I do not see much differnece
between attributes vs filetypes.
