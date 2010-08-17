From: Stephen Bash <bash@genarts.com>
Subject: Re: [GSoC update] git-remote-svn: The final one
Date: Tue, 17 Aug 2010 12:20:15 -0400 (EDT)
Message-ID: <27168737.115723.1282062015125.JavaMail.root@mail.hq.genarts.com>
References: <20100817155933.GB6947@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Stefan Sperling <stsp@elego.de>,
	Bert Huijben <rhuijben@collab.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Will Palmer <wmpalmer@gmail.com>,
	Philip Martin <philip.martin@wandisco.com>,
	Jonas Gehring <jonas.gehring@boolsoft.org>,
	=?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 18:20:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlOts-0000pX-30
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 18:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757274Ab0HQQUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 12:20:24 -0400
Received: from hq.genarts.com ([173.9.65.1]:8058 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754223Ab0HQQUX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 12:20:23 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 139FC1E2624F;
	Tue, 17 Aug 2010 12:20:22 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 913kOMmG8SUw; Tue, 17 Aug 2010 12:20:15 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 6F7CA1E2635B;
	Tue, 17 Aug 2010 12:20:15 -0400 (EDT)
In-Reply-To: <20100817155933.GB6947@kytes>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153758>

> > So being selfish, what I care about is an improved method for
> > converting SVN repos to git repos once and never going back. It
> > sounds to me like the major hurdles remaining there are getting
> > svn-fe to handle dumpfile v3 and handling branches/tags. Is that
> > correct?
> 
> We're doing better than that- when the whole thing is complete, we
> should have perfectly seamless two-way compatibility.

That makes complete sense.  It just happens I'm interested in a subset of the problem (the order has come down from on high that we will be using git for future development), so I'm curious if/how a one-time conversion simplifies things.

> But yes, you're
> right- there are several non-trivial tasks to handle, the top three of
> which are:
> 1. Making svn-fe git-aware (and hence handle dumpfile v3)
> 2. Writing a fast-export to dumpfilev3 converter
> 3. Implementing the branch/ tag mapper in an extensible way

Thanks for clarifying.

> Don't worry about it though- we're all working hard on it :)

I believe that :)  And you're not holding me up; I've spent my spare time this summer coming up with some Perl scripts to work with svn-fe for the one-time conversion, so I'll have my point case solved in the near future.  But I'm sure the problem will come up again, and I'll be happy to use the general tool then.

Thanks,
Stephen
