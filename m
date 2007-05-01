From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "Producting Open Source Software" book and distributed SCMs
Date: Tue, 1 May 2007 15:45:18 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705011532400.3808@woody.linux-foundation.org>
References: <200704300120.42576.jnareb@gmail.com>
 <alpine.LFD.0.98.0705010829180.3808@woody.linux-foundation.org>
 <200705020027.41316.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 00:45:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hj166-0004wJ-FZ
	for gcvg-git@gmane.org; Wed, 02 May 2007 00:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722AbXEAWpX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 18:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754760AbXEAWpX
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 18:45:23 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:50663 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754722AbXEAWpW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2007 18:45:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l41MjJhi025033
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 1 May 2007 15:45:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l41MjJAH008440;
	Tue, 1 May 2007 15:45:19 -0700
In-Reply-To: <200705020027.41316.jnareb@gmail.com>
X-Spam-Status: No, hits=-2.98 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45990>



On Wed, 2 May 2007, Jakub Narebski wrote:
> 
> Actually Karl Fogel wrote in "Producting Open Source Software" that he
> recommends and uses 'soft' partial commit access; it means that committing
> is restricted to a part of project for some by a guideline, but is not
> enforced by the tool (by SCM).

Oh, absolutely. Except that really does require a lot of trust up front, 
which is the problem with commit access to begin with - you automatically 
have a very clear (and *big*) difference between insiders and outsiders, 
and there is no "gradual" way to move from one to the other.

So yes, for practical reasons, "commit access" really is almost always an 
all-or-nothing thing for most centralized setups, because nothing else 
really works. And when it isn't, it's just a horrible horrible pain in the 
*ss.

What people do instead of commit access is to set up triggers to notify 
people about certain subsystems being modified. Which is a good idea, but 
it's really a totally different thing.

> P.S. I recommend actually reading the book (at http://producingoss.com)
> instead of relying on my understanding of it.

It actually looks like a fine book, even though I think Karl is totally 
off in not seeing the big difference between centralized and distributed. 

I saw it at the local Borders, and considered buying it. I didn't even 
realize that it apparently is downloadable too.

And it talks about a lot of other things than just SCM's.

			Linus
