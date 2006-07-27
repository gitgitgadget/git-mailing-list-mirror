From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Licensing and the library version of git
Date: Thu, 27 Jul 2006 09:41:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607270936200.4168@g5.osdl.org>
References: <9e4733910607261436v4c0802e5v7301e904593f9bab@mail.gmail.com> 
 <20060727114105.GZ13776@pasky.or.cz>  <Pine.LNX.4.63.0607271400160.29667@wbgn013.biozentrum.uni-wuerzburg.de>
  <9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com> 
 <20060727131127.GA13776@pasky.or.cz> <9e4733910607270911p50d25d97w1a898fc7a9119e7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 18:42:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G68va-0004xt-2J
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 18:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbWG0Qlg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 12:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbWG0Qlf
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 12:41:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42638 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751513AbWG0Qle (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 12:41:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6RGfMnW011016
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 27 Jul 2006 09:41:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6RGfKW0008705;
	Thu, 27 Jul 2006 09:41:21 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910607270911p50d25d97w1a898fc7a9119e7d@mail.gmail.com>
X-Spam-Status: No, hits=-0.584 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24298>



On Thu, 27 Jul 2006, Jon Smirl wrote:
> 
> Inability to integrate with Microsoft Visual Studio is going to have a
> lot of impact on the cross platform use of git.  Is a conscious
> decision being made to stop this integration or is this just unplanned
> side effect of the original license? If this is an unplanned side
> effect, the quicker we move, the easier it is to fix.

I don't think the choice of GPLv2 is an "unplanned side effect". It's a 
fact.

I personally don't much like the LGPL.

I'd also like to point out that unlike every single horror I've ever 
witnessed when looking closer at SCM products, git actually has a simple 
design, with stable and reasonably well-documented data structures. In 
fact, I'm a huge proponent of designing your code around the data, rather 
than the other way around, and I think it's one of the reasons git has 
been fairly successful (*).

So it's easy enough to just write whatever Java code or something to just 
access the databases yourself. The object model of git may be smart, but 
it's neither proprietary nor patented. I suspect it's often a lot easier 
to integrate git into other projects _that_ way, rather than try to 
actually port the code itself.

		Linus

(*) I will, in fact, claim that the difference between a bad programmer 
and a good one is whether he considers his code or his data structures 
more important. Bad programmers worry about the code. Good programmers 
worry about data structures and their relationships.
