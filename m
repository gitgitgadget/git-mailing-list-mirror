From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Importing Mozilla CVS into git
Date: Thu, 1 Jun 2006 18:11:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606011809401.5498@g5.osdl.org>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com> 
 <Pine.LNX.4.64.0606011643290.5498@g5.osdl.org>
 <9e4733910606011759t7c828a50gc4a6b45d92d2b344@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 03:11:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlyC8-0003wV-JT
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 03:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWFBBLP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 21:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWFBBLP
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 21:11:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17047 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751059AbWFBBLP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jun 2006 21:11:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k521BC2g018779
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 1 Jun 2006 18:11:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k521BBS5023927;
	Thu, 1 Jun 2006 18:11:12 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606011759t7c828a50gc4a6b45d92d2b344@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21133>



On Thu, 1 Jun 2006, Jon Smirl wrote:
> 
> I was trying to use it to figure out what was wrong with the branch
> processing in parsecvs. It doesn't have to be fixed. show-branch --all
> fails with same 29 tag limit.

You're much better off using "gitk --all" if you want to see the result, 
the "show-branch" this is really broken. It is using the old algorithm 
that we used to use for "git-rev-tree", and got rid of about a year ago 
there in favour of git-rev-list ;)

			Linus
