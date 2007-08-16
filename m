From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [linux-pm] Re: Storing Maintainers info around the kernel tree
Date: Thu, 16 Aug 2007 17:50:30 +0200
Message-ID: <46C47246.9020800@gmail.com>
References: <Pine.LNX.4.44L0.0708161128540.3757-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kyle Moffett <mrmacman_g4@mac.com>,
	Salikh Zakirov <salikh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	LKML Kernel <linux-kernel@vger.kernel.org>,
	Joe Perches <joe@perches.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pm@lists.linux-foundation.org, git@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
X-From: git-owner@vger.kernel.org Thu Aug 16 17:54:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILhgS-0002Ga-H7
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 17:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758970AbXHPPyt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 11:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758700AbXHPPys
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 11:54:48 -0400
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:60344 "EHLO
	smtpq1.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758632AbXHPPyr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 11:54:47 -0400
Received: from [213.51.146.189] (port=53213 helo=smtp2.tilbu1.nb.home.nl)
	by smtpq1.tilbu1.nb.home.nl with esmtp (Exim 4.30)
	id 1ILhgD-00017m-6o; Thu, 16 Aug 2007 17:54:37 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:51600 helo=[192.168.0.3])
	by smtp2.tilbu1.nb.home.nl with esmtp (Exim 4.30)
	id 1ILhgB-0007pJ-6x; Thu, 16 Aug 2007 17:54:35 +0200
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <Pine.LNX.4.44L0.0708161128540.3757-100000@iolanthe.rowland.org>
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56022>

On 08/16/2007 05:31 PM, Alan Stern wrote:

> Please remember that not everybody uses git.  The MAINTAINERS data 
> should be available in the kernel source itself.

It may be useful to generate a MAINTAINERS file into releases yes.

I must say though that "why?" would also be a question. I personally don't 
think there's a whole lot wrong with more and more expecting people who 
submit patches (for whom this automation is intended) to be using git. Back 
in the BK days there were lots of reasons for resisting any and all 
dependency on the source code management tool but there don't seem to be too 
many left today as far as I'm concerned.

If it's about non-developer users, I suspect it would to a fairly large 
degree be an "in theory" thing to expect that said user does want the 
information in a downloaded releases, but not in git, and not online where 
git-web could also easily display all the information right alongside the files.

But yes, sure, anything can be generated...

Rene.
