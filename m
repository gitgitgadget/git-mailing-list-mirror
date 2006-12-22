From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: warning merge message
Date: Fri, 22 Dec 2006 21:42:15 +0100
Message-ID: <200612222142.15489.Josef.Weidendorfer@gmx.de>
References: <867728.44872.qm@web31814.mail.mud.yahoo.com> <7vr6us92m2.fsf@assigned-by-dhcp.cox.net> <7v1wms79mg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 21:43:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxrEH-0007bE-Rn
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 21:42:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbWLVUmz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 15:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752646AbWLVUmz
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 15:42:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:45149 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752636AbWLVUmy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 15:42:54 -0500
Received: (qmail invoked by alias); 22 Dec 2006 20:42:52 -0000
Received: from p5496B9D3.dip0.t-ipconnect.de (EHLO noname) [84.150.185.211]
  by mail.gmx.net (mp031) with SMTP; 22 Dec 2006 21:42:52 +0100
X-Authenticated: #352111
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.5
In-Reply-To: <7v1wms79mg.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35212>

On Friday 22 December 2006 07:00, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> > Luben Tuikov <ltuikov@yahoo.com> writes:
> >
> >> Can we please eliminate this message:
> >> Warning: No merge candidate found because value of config option
> >>          "branch.master.merge" does not match any remote branch fetched.
> >
> > The above message was meant only for "git pull", but was leaked
> > even when you did "git fetch"; it was a bug and was corrected
> > already (hopefully).
> 
> Gaah... it turns out that it was not fixed properly.

Sorry, I am missing something.
What is the exact problem that goes wrong here?

The message is printed when "git pull [args]" does not result
in any merge with current branch. What is wrong about this?
But a "git pull ..." always should lead to some merge
in the end in every possible work flow, or should it not?

Josef
