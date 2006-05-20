From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFD] Git glossary: 'branch' and 'head' description
Date: Fri, 19 May 2006 19:06:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605191853570.10823@g5.osdl.org>
References: <e4f1ta$e07$1@sea.gmane.org> <87y7wyv72m.fsf@morpheus.hq.vtech>
 <20060519092136.GN22257@spearce.org> <Pine.LNX.4.64.0605192006400.6713@iabervon.org>
 <7vy7wxfs7v.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605192116360.6713@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 20 04:07:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhGrx-0000MR-UC
	for gcvg-git@gmane.org; Sat, 20 May 2006 04:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWETCGz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 22:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWETCGz
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 22:06:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37768 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964823AbWETCGy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 May 2006 22:06:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4K26ltH000340
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 19 May 2006 19:06:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4K26koh013627;
	Fri, 19 May 2006 19:06:47 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0605192116360.6713@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20371>



On Fri, 19 May 2006, Daniel Barkalow wrote:
> 
> I guess I did forget that it sticks around. So you have to be doing 
> something somewhat more complicated, like fetching the latest versions of 
> multiple topic branches.

I actually don't think it's at all unlikely that I'd start using this.

I tend to work in "spurts", where I do one thing for a while, and then 
merge several pull requests in fairly short order. So while I use 
ORIG_HEAD a lot, I can certainly imagine myself using the "since 2 hours 
ago" format too.

I'm not entirely sure about the syntax, though. It ends up being pretty 
command-line-unfriendly. The "gitk ORIG_HEAD.." thing is fairly easy to 
type, but typing

	gitk 'master@{2 hours ago}'..

on a Finnish keyboard (yeah, that's what I still use) is "interesting", 
since all of '@', '{' and '}' are complex characters (AltGr + '2', AltGr + 
'7' and AltGr + '0' respectively), and you have to remember the quoting.

Not that I see any obvious better syntax. Although allowing a shorthand 
like "@2.hours.ago" for "current branch, at given date" might help a 
bit, at least that wouldn't need quoting:

	gitk @2.hours.ago..

			Linus
