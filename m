From: Junio C Hamano <junkio@cox.net>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Wed, 14 Feb 2007 14:13:01 -0800
Message-ID: <7vire4l76a.fsf@assigned-by-dhcp.cox.net>
References: <17875.13564.622087.63653@lisa.zopyra.com>
	<7vhctor78j.fsf@assigned-by-dhcp.cox.net>
	<17875.17647.74882.218627@lisa.zopyra.com>
	<7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net>
	<17875.30187.289679.417079@lisa.zopyra.com>
	<17875.30687.661794.512124@lisa.zopyra.com>
	<Pine.LNX.4.64.0702141314440.20368@woody.linux-foundation.org>
	<17875.33204.413186.355557@lisa.zopyra.com>
	<7vzm7gl8cf.fsf@assigned-by-dhcp.cox.net>
	<7vvei4l84q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702142303250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 14 23:13:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHSNB-00019i-J9
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 23:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbXBNWNG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 17:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbXBNWNF
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 17:13:05 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:49180 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964796AbXBNWNE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 17:13:04 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214221303.TPNM4586.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 17:13:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PaD11W00b1kojtg0000000; Wed, 14 Feb 2007 17:13:02 -0500
In-Reply-To: <Pine.LNX.4.63.0702142303250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 14 Feb 2007 23:04:08 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39764>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 14 Feb 2007, Junio C Hamano wrote:
>
>> By the way, I sometimes think it might be worth doing this:
>> 
>> 	$ chmod a-r .git/
>> 
>> We always access files by explicit paths and never ask "ls .git/foo*" to 
>> find what are under .git/ directory.
>
> If so, please make it unconfigurable. I use tab-completion in the git 
> directory quite often.

Do you mean "configurable"?

I wonder what you are doing inside .git directory in the first
place.  I never chdir() into it myself, but that may be because
I practicaly live inside Emacs.
