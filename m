From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-gc "--aggressive" somewhat broken
Date: Fri, 6 Jul 2007 18:16:15 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707061812410.8278@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0707061310390.8278@woody.linux-foundation.org
 > <alpine.LFD.0.999.0707061512550.8278@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jul 07 03:17:09 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6yv6-0003HE-Es
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 03:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbXGGBQy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 21:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752100AbXGGBQy
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 21:16:54 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34957 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751992AbXGGBQy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jul 2007 21:16:54 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l671GNJ1016790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 6 Jul 2007 18:16:24 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l671GFH8031787;
	Fri, 6 Jul 2007 18:16:15 -0700
In-Reply-To: <alpine.LFD.0.999.0707061512550.8278@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.641 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51795>



On Fri, 6 Jul 2007, Linus Torvalds wrote:
> 
> This is a totally untested patch that may or may not work.

And by that I obviously mean "does not work".

I only tested on the gcc thing, and it causes an assertion error when 
trying to actually write out the deltas ("corrupt packed object").

I'm sure somebody can figure it out, 

		Linus
