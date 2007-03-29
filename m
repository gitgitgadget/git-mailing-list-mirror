From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-mailinfo munges the patch?
Date: Thu, 29 Mar 2007 14:19:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703291417250.6730@woody.linux-foundation.org>
References: <7v1wj74xck.fsf@assigned-by-dhcp.cox.net> <20070329205357.GF11029@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 23:19:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX221-0004nQ-J8
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 23:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030739AbXC2VTi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 17:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030745AbXC2VTi
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 17:19:38 -0400
Received: from smtp.osdl.org ([65.172.181.24]:39615 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030739AbXC2VTi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 17:19:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2TLJRU2031567
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 29 Mar 2007 14:19:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2TLJQEH012352;
	Thu, 29 Mar 2007 14:19:27 -0700
In-Reply-To: <20070329205357.GF11029@redhat.com>
X-Spam-Status: No, hits=-0.462 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43474>



On Thu, 29 Mar 2007, Don Zickus wrote:
> 
> Ok.  I see what you are saying with the old code.  Sorry about that.  Do
> you have a sample file that I can play with to test my fix?

On that note - here's an unrelated simple case that the old mailinfo got 
right, but the new one seems to screw up: multiple Subject: lines.

The old one would make later Subject: lines override the earlier ones, and 
I depended on that when I fix up peoples emails to me manually (you 
wouldn't believe how bad explanations or subject lines people use for 
perfectly good patches ;)

The current mailinfo seems to just take the first one. 

		Linus
