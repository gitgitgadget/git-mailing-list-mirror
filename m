From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Thu, 13 Oct 2005 22:43:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510132229490.23590@g5.osdl.org>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net> <20051007232909.GB8893@steel.home>
 <7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net> <20051008064555.GA3831@steel.home>
 <7vachks7aq.fsf@assigned-by-dhcp.cox.net> <20051008133032.GA32079@localhost>
 <7v64s7svya.fsf@assigned-by-dhcp.cox.net> <7vu0frpxs1.fsf@assigned-by-dhcp.cox.net>
 <87mzlgh8xa.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510110802470.14597@g5.osdl.org>
 <87ek6s0w34.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510111121030.14597@g5.osdl.org>
 <87slv7zvqj.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510111346220.14597@g5.osdl.org>
 <877jcjmdmq.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510120749230.14597@g5.osdl.org>
 <87vf02qy79.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510121355280.15297@g5.osdl.org>
 <87ek6ork3y.fsf@penguin.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Robert Fitzsimons <robfitz@273k.net>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 07:45:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQILx-00054P-Kw
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 07:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVJNFnf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 01:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbVJNFne
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 01:43:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20418 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932175AbVJNFne (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2005 01:43:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9E5hL4s010506
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 13 Oct 2005 22:43:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9E5hJjf020204;
	Thu, 13 Oct 2005 22:43:19 -0700
To: Paul Eggert <eggert@CS.UCLA.EDU>
In-Reply-To: <87ek6ork3y.fsf@penguin.cs.ucla.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.124 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10098>



On Thu, 13 Oct 2005, Paul Eggert wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > I find that email is very robust - it's basically 8-bit clean. No 
> > character encoding, no crap. Just a byte stream. It really _is_ the most 
> > reliable format.
> 
> I found another amusing bit of info that tends to undercut this claim.

No, I think you found that email as a _transfer_ is mostly 8-bit clean 
(finally! Oh - has qmail gotten fixed?).

But the end-points aren't. They do strange things with encodings, 
sometimes. They see an encoding they don't know what to do with, and they 
just freak out.

		Linus
