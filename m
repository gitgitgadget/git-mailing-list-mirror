From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Mon, 18 Sep 2006 01:19:00 -0700
Message-ID: <7vmz8xr3ij.fsf@assigned-by-dhcp.cox.net>
References: <7vk64bnnxl.fsf@assigned-by-dhcp.cox.net>
	<7vu035u4c3.fsf@assigned-by-dhcp.cox.net> <eelbd2$56s$1@sea.gmane.org>
	<7vlkohu3j1.fsf@assigned-by-dhcp.cox.net> <eeld1a$830$2@sea.gmane.org>
	<Pine.LNX.4.63.0609181010500.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 10:19:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPELR-0000dT-LG
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 10:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965566AbWIRITG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 04:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965564AbWIRITG
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 04:19:06 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:34729 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S965567AbWIRITC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Sep 2006 04:19:02 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060918081901.NEBL2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Mon, 18 Sep 2006 04:19:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PkJo1V0061kojtg0000000
	Mon, 18 Sep 2006 04:18:48 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0609181010500.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 18 Sep 2006 10:11:42 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27242>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > That's not a good excuse, though.  It means you cannot propose
>> > new core-side support that only gitweb would benefit from
>> > initially, since we will not add new stuff to the core that does
>> > not have real users, and new stuff in the core must be cooked in
>> > "next" before it is proven to be useful and correct.
>>  
>> But this also means that if I were for example to use git-for-each-ref
>> in gitweb, I couldn't _test_ if it works. Ah, well, if you can live with
>> PATCH/RFC... But I'd rather wait for git-for-each-ref in _released_ version
>> of git. 
>
> Why not set up a testing directory, where you use both gitweb _and_ git 
> from next? It is easy...

That's Ok; it means that he just cannot work on certain things.
It's not like we take gitweb patch only from Jakub, so it is not
the end of the world either ;-).

Also it is handy to have somebody who sticks to things that are
available in master to catch breakage we might accidentally
cause by Porcelainish commands jumping the gun before core-side
change hits the master branch.
