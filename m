From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/5] git-add: add ignored files when asked explicitly.
Date: Tue, 26 Dec 2006 11:05:23 -0800
Message-ID: <7v1wmmfpfw.fsf@assigned-by-dhcp.cox.net>
References: <7vbqlskz2u.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612251443230.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vslf3khsc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612261632360.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 26 20:05:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzHc8-0005Ks-SX
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 20:05:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932762AbWLZTFZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 14:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932761AbWLZTFZ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 14:05:25 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:62859 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932762AbWLZTFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 14:05:25 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061226190524.WYHW15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Dec 2006 14:05:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3X5d1W00M1kojtg0000000; Tue, 26 Dec 2006 14:05:37 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612261632360.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 26 Dec 2006 16:34:18 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35427>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > Most people do
>> >
>> > 	$ git add *.o
>> >
>> > instead, where bash expands the expression. Maybe this new behaviour 
>> > should be hidden between a "-f" option?
>> 
>> When would anybody do "git add *.o"?
>
> Not exactly "git add *.o", but when I see in git-status that there are 
> only a couple of files which are untracked, and I want them added, I 
> lazily do "git add *".

I changed it to warn and refuse and made it only add under -f
flag.
