From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: The GPL: No shelter for the Linux kernel?
Date: Sun, 24 Sep 2006 09:53:35 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0609240952240.28459@yvahk01.tjqt.qr>
References: <MDEHLPKNGKAHNMBLJOLKIEJNOJAB.davids@webmaster.com>
 <Pine.LNX.4.61.0609231004330.9543@yvahk01.tjqt.qr> <Pine.LNX.4.64.0609231051570.4388@g5.osdl.org>
 <20060923181406.GC11916@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	David Schwartz <davids@webmaster.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 09:56:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GROqu-0001WN-G7
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 09:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWIXH4g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 03:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWIXH4g
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 03:56:36 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:27595 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751362AbWIXH4f (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 03:56:35 -0400
Received: from linux01.gwdg.de ([134.76.13.21])
	by mailer.gwdg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <jengelh@linux01.gwdg.de>)
	id 1GROqa-0007ka-HK; Sun, 24 Sep 2006 09:56:23 +0200
Received: from linux01.gwdg.de (localhost [127.0.0.1])
	by linux01.gwdg.de (8.13.3/8.13.3/SuSE Linux 0.7) with ESMTP id k8O7raqC028944;
	Sun, 24 Sep 2006 09:53:38 +0200
Received: from localhost (jengelh@localhost)
	by linux01.gwdg.de (8.13.3/8.13.3/Submit) with ESMTP id k8O7rZ4D028938;
	Sun, 24 Sep 2006 09:53:35 +0200
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060923181406.GC11916@pasky.or.cz>
X-Spam-Level: /
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
X-Virus-Scanned: (clean) by exiscan+sophie
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27648>

>> Side note: in "git", we kind of discussed this. And because the project 
>> was started when the whole GPL version discussion was already in bloom, 
>> the git project has a note at top of the COPYING file that says:
>> 
>>  Note that the only valid version of the GPL as far as this project
>>  is concerned is _this_ particular version of the license (ie v2, not
>>  v2.2 or v3.x or whatever), unless explicitly otherwise stated.
>> 
>>  HOWEVER, in order to allow a migration to GPLv3 if that seems like
>>  a good idea, I also ask that people involved with the project make
>>  their preferences known. In particular, if you trust me to make that
>>  decision, you might note so in your copyright message, ie something
>>  like
>> 
>>         This file is licensed under the GPL v2, or a later version
>>         at the discretion of Linus.
>> 
>
>  Actually, this didn't catch on very well anyway, I guess because most
>people just know it's GPLv2 and don't even bother to peek at COPYING, we
>are a bit sloppy about copyright notices and most of them don't mention
>licence at all (if there are any in the file at all), and adding
>explicit copyright notices to mails isn't too popular either.

Would every file that does not contain an explicit license (this 
excludes MODULE_LICENSE) falls under COPYING?

>	$ git grep 'discretion'
>	COPYING:        at the discretion of Linus.
>	git-annotate.perl:# at the discretion of Linus Torvalds.
>	git-relink.perl:# Later versions of the GPL at the discretion of Linus Torvalds
>	git-request-pull.sh:# at the discretion of Linus Torvalds.
>
>and I've found no patches with such special assignment.


Jan Engelhardt
-- 
