From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Efficient way to import snapshots?
Date: Mon, 30 Jul 2007 16:30:22 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707301629230.4161@woody.linux-foundation.org>
References: <20070730180710.GA64467@nowhere>
 <alpine.LFD.0.999.0707301144180.4161@woody.linux-foundation.org>
 <20070730192922.GB64467@nowhere> <alpine.LFD.0.999.0707301240330.4161@woody.linux-foundation.org>
 <20070730222028.GE64467@nowhere>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Craig Boston <craig@olyun.gank.org>
X-From: git-owner@vger.kernel.org Tue Jul 31 01:31:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFehc-0003WS-2x
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 01:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760592AbXG3XbB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 19:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760353AbXG3XbB
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 19:31:01 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55915 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760324AbXG3XbA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2007 19:31:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6UNURuF001685
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 30 Jul 2007 16:30:29 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6UNUM6B004074;
	Mon, 30 Jul 2007 16:30:22 -0700
In-Reply-To: <20070730222028.GE64467@nowhere>
X-Spam-Status: No, hits=-2.728 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.16__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54292>



On Mon, 30 Jul 2007, Craig Boston wrote:
> 
> # On branch cvs_RELENG_4
> nothing to commit (working directory clean)
> git: 67.65 seconds

So I _seriously_ hope that about 65 of those 67 seconds was the "cvs 
update -d" or something like that. 

Anything that takes a minute in git is way way *way* too slow. Any 
half-way normal git operations should take less than a second.

		Linus
