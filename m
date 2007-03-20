From: Junio C Hamano <junkio@cox.net>
Subject: Re: Suspicious of v1.5.0 tag object
Date: Tue, 20 Mar 2007 13:43:00 -0700
Message-ID: <7v7itb7ijv.fsf@assigned-by-dhcp.cox.net>
References: <200703201323.15497.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 21:43:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTlAw-0003tS-LZ
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 21:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbXCTUnH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 16:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753879AbXCTUnG
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 16:43:06 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:59801 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869AbXCTUnF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 16:43:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070320204304.GDO1312.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 20 Mar 2007 16:43:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id d8j01W00V1kojtg0000000; Tue, 20 Mar 2007 16:43:01 -0400
In-Reply-To: <200703201323.15497.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 20 Mar 2007 13:23:12 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42760>

Andy Parkins <andyparkins@gmail.com> writes:

> I was just poking around and noticed this:
>
>   $ git cat-file -p v1.5.0
>   object 437b1b20df4b356c9342dac8d38849f24ef44f27
>   type commit
>   tag v1.5.0
>   tagger Junio C Hamano <junkio@cox.net> Wed Feb 14 00:00:00 2007 +0000
>
> Is it really the case that you tagged v1.5.0 at midnight UTC
> exactly; and that you travelled from your normal -0800
> timezone to +0000?  None of the other tags show this strange
> output.

Who are you referring to as "you" when your "To:" header reads
Git Mailing List ;-)?

That one and its commit object has that timestamp because the
release was supposed to be named "Rose scented bamboo".
