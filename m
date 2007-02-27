From: Junio C Hamano <junkio@cox.net>
Subject: Re: Funny reflog has missing space
Date: Tue, 27 Feb 2007 11:30:31 -0800
Message-ID: <7v4pp7flew.fsf@assigned-by-dhcp.cox.net>
References: <200702271529.13258.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 20:31:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM82Q-0003X7-8P
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 20:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbXB0Ta7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 14:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbXB0Ta7
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 14:30:59 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:40603 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbXB0Ta6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 14:30:58 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227193058.KDGZ2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 14:30:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UjWh1W01C1kojtg0000000; Tue, 27 Feb 2007 14:30:42 -0500
In-Reply-To: <200702271529.13258.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 27 Feb 2007 15:29:11 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40771>

Andy Parkins <andyparkins@gmail.com> writes:

> Hello,
>
> I've just peeked in my reflog (tail .git/logs/HEAD), and found something 
> strange:
>
> 72160ca5c05fab4fbd3c24c9b13cbd0651b60532 
> ca7b20e2677960cfc52c525b8f8bdf12ce79176b Andy Parkins <long@emailaddress.com> 
> 1172589175 +0000commit: Log message goes here
>
> Notice that there is no space between the "+0000" and the "commit".  This is 
> true for every item in this log and every log in this repository.
>
> Over in another part of the forest, I've got my git repository.  This is fine, 
> and has the space where I would expect.  The only difference I can see is 
> that in one I'm using my long work email address, and in the git one I'm 
> using my shorter gmail address.
>
> Is this normal?  "git-reflog show" works fine in both cases.

It is not.  It would be good to find out who puts corrupted
entry.
