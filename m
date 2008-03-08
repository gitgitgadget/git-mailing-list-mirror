From: David Brownell <david-b@pacbell.net>
Subject: Re: warning: no common commits - slow pull
Date: Sat, 8 Mar 2008 15:25:07 -0800
Message-ID: <200803081525.08181.david-b@pacbell.net>
References: <200803061735.47674.david-b@pacbell.net> <200803081448.47000.david-b@pacbell.net> <alpine.LNX.1.00.0803081750580.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 09 00:25:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY8QK-0005so-Um
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbYCHXZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbYCHXZO
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:25:14 -0500
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:27213 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751366AbYCHXZN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Mar 2008 18:25:13 -0500
Received: (qmail 11037 invoked from network); 8 Mar 2008 23:25:09 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:X-Yahoo-Newman-Property:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=5V/K366CcLZs27jYW7QUOY2yDgSc6DxoLexlV7yoKgC3kgI4JMTJnnUGHZJJ8n3uWB1+l0KDaQxQRFOTPS1e+emXsbPxEbp5heSTjTlUp0YR+P/ge/S2QV6JLxJH1jODAXUqDwnK5ksJARD/3gkGw6t9RgyoK7NGlVvhF1c1DPI=  ;
Received: from unknown (HELO ascent) (david-b@pacbell.net@69.226.243.232 with plain)
  by smtp123.sbc.mail.sp1.yahoo.com with SMTP; 8 Mar 2008 23:25:09 -0000
X-YMail-OSG: wH7aO_gVM1lzxZ6qg4SBshxGjPQFaoEmilt1jSNZMjDP0syAkuy8nhoz5tVzthrN9hN7LrTdPw--
X-Yahoo-Newman-Property: ymail-3
User-Agent: KMail/1.9.6
In-Reply-To: <alpine.LNX.1.00.0803081750580.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76619>

On Saturday 08 March 2008, Daniel Barkalow wrote:
> On Sat, 8 Mar 2008, David Brownell wrote:
> > Oddly, a few times when I tried that the bug didn't reproduce.
> > One factor may be workspaces cloned a long time ago with early
> > versions of GIT (or cogito).
> 
> Is it a few times on different workspaces, or with copies of the same 
> workspace?

I had several workspaces that weren't updated ... which by previous
experience should *all* have done an extra update.  I did the pull
with the GIT_DEBUG on a few of them, and the bogus one didn't happen.

This seemed odd to me so the next time I tried without the GIT_DEBUG
thing ... and got the bogus pull with "no common commits".  This was
unfortunately *after* I deleted tarballs of the previous workspaces,
so that exact experiment can't be reproduced.  Those were, however,
"newer" workspaces -- probably created last summer, rather than
a few years ago.


> I think that there's a dependance on how your current state and  
> the new state happen to line up.

The workspace in the tarball I can send you doesn't have any issues
with reproducibility ... now.  

- Dave
