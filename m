From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 10:18:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610201016490.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca>
 <200610201821.34712.jnareb@gmail.com> <45390168.6020502@utoronto.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 19:19:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gay1M-0008DF-Kq
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 19:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWJTRS4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 13:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWJTRS4
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 13:18:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57247 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932208AbWJTRS4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 13:18:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9KHIjaX025596
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 Oct 2006 10:18:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9KHIiSr026339;
	Fri, 20 Oct 2006 10:18:45 -0700
To: Aaron Bentley <aaron.bentley@utoronto.ca>
In-Reply-To: <45390168.6020502@utoronto.ca>
X-Spam-Status: No, hits=-0.973 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29506>



On Fri, 20 Oct 2006, Aaron Bentley wrote:
> 
> All solutions have disadvantages.  We prefer the disadvantages that come
> from using file-ids over the disadvantages that come from using
> content-based rename detection.

That's fine, but please don't call the git rename handling "maybe" or 
"partial", like a lot of people seem to do. 

Git _definitely_ handles renames, both in everyday life and when merging. 
Some people may not like how it's done, but other (I'll say "equally 
informed", even though obviously I know better ;) people really don't like 
the way bzr or others do their rename handling.

			Linus
