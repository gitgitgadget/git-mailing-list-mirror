From: Ryan Anderson <ryan@michonline.com>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Thu, 23 Mar 2006 16:02:15 -0500
Message-ID: <20060323210215.GH26071@mythryan2.michonline.com>
References: <20060322133337.GU20746@lug-owl.de> <Pine.LNX.4.64.0603221517210.26286@g5.osdl.org> <Pine.LNX.4.64.0603221607580.26286@g5.osdl.org> <44223B90.3040500@zytor.com> <1143128751.6850.35.camel@neko.keithp.com> <Pine.LNX.4.64.0603230758260.26286@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Keith Packard <keithp@keithp.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jan-Benedict Glaw <jbglaw@lug-owl.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 22:03:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMWyA-0002YG-H8
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 22:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422697AbWCWVDn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 16:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWCWVDn
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 16:03:43 -0500
Received: from mail.autoweb.net ([198.172.237.26]:57222 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S964940AbWCWVDm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Mar 2006 16:03:42 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FMWxk-0003Pe-7W; Thu, 23 Mar 2006 16:03:21 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FMWxf-0005rv-U1; Thu, 23 Mar 2006 16:03:15 -0500
Received: from ryan by mythical with local (Exim 4.60)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1FMWxB-0005EE-OC; Thu, 23 Mar 2006 16:02:45 -0500
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603230758260.26286@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17872>

On Thu, Mar 23, 2006 at 08:01:14AM -0800, Linus Torvalds wrote:
> On Thu, 23 Mar 2006, Keith Packard wrote:
> > 
> > Note that vendor branches are always made from the first revision along
> > a branch, independent of when they occur, so you'll get 1.1.3.1 even if
> > the head revision along the trunk is 1.246.
> 
> I have to say, that one thing I've learnt during this whole git thing is 
> that other SCM's are DAMN CONFUSED.
> 
> I used to think that git was potentially hard to understand. Not so. git 
> is an absolute paragon of logic and easy-to-understand concepts.
> 
> Compared to SVN (can anybody sat "trunk/branch/tag confusion") and CVS, 
> git is not only a hell of a lot more capable, it's just more logical.

This might be somewhat controversial, and I haven't done any research to
confirm my impression, but you might be just seeing the symptoms of
different ways of looking at the problem.

Scott Collins (QT evangelist, incredibly smart guy) commented to me
sometime over the summer, that every new SCM was born out of someone's
desire to implement a new merge algorithm.  While I think that's too
simple, I think there have been an awful lot of academic SCMs out there.

Git has taken a very pragmatic approach, in that the goal has been "What
is the smallest number of concepts we can create that let us solve the
problem, even if we occassionally have to make some tradeoffs?"
(Thinking of rename detection there, mostly.)

So, really, I guess the comment I'm trying to make here is that Occam
was right.

-- 

Ryan Anderson
  sometimes Pug Majere
