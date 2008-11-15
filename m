From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH 3/3] Add -k/--keep-going option to mergetool
Date: Sat, 15 Nov 2008 10:56:03 -0500
Message-ID: <20081115155603.GD22948@mit.edu>
References: <1226580075-29289-1-git-send-email-charles@hashpling.org> <1226580075-29289-2-git-send-email-charles@hashpling.org> <1226580075-29289-3-git-send-email-charles@hashpling.org> <1226580075-29289-4-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Andreas Ericsson <ae@op5.se>,
	William Pursell <bill.pursell@gmail.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sat Nov 15 16:57:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1NWW-0005K6-A4
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 16:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbYKOP4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 10:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbYKOP4I
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 10:56:08 -0500
Received: from www.church-of-our-saviour.org ([69.25.196.31]:47054 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751424AbYKOP4H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 10:56:07 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1L1NVF-0005sg-Vw; Sat, 15 Nov 2008 10:56:06 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1L1NVD-0008HR-98; Sat, 15 Nov 2008 10:56:03 -0500
Content-Disposition: inline
In-Reply-To: <1226580075-29289-4-git-send-email-charles@hashpling.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101075>

On Thu, Nov 13, 2008 at 12:41:15PM +0000, Charles Bailey wrote:
> This option stops git mergetool from aborting at the first failed merge.
> This allows some additional use patterns. Merge conflicts can now be
> previewed one at time and merges can also be skipped so that they can be
> performed in a later pass.
> 
> There is also a mergetool.keepGoing configuration variable covering the
> same behaviour.

Instead of making this be a command-line and configuration option,
maybe it would be better to prompt the user after an aborted merge,
and give the user the opportunity to continue or abort?  i.e., instead
of just saying "merge of foo.c failed" and then exiting, to ask the
user instad something like, "Merge of foo.c failed; continue
attempting to merge the rest of the files? <y>"

I suspect this might be more friendly than Yet Another command-line
option and configuration parameter.  What do you think?

       	   		 	     	     	 - Ted
