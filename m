From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [RFC] git-gui USer's Survey 2007 (was: If you would write git
	from scratch now, what would you change?)
Date: Fri, 30 Nov 2007 18:50:18 +0100
Message-ID: <20071130175018.GB30048@efreet.light.src>
References: <20071127012013.GG14735@spearce.org> <fifstd$ilj$1@ger.gmane.org> <20071127015833.GL14735@spearce.org> <Pine.LNX.4.64.0711271136050.27959@racer.site> <fiib19$dj6$1@ger.gmane.org> <Pine.LNX.4.64.0711281225150.27959@racer.site> <20071128232523.GE9174@efreet.light.src> <Pine.LNX.4.64.0711282345500.27959@racer.site> <20071129065706.GA24070@efreet.light.src> <Pine.LNX.4.64.0711291200000.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 30 18:51:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyA0y-0004m2-Ks
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 18:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759619AbXK3Ruk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 12:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758422AbXK3Ruk
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 12:50:40 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:47251 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758230AbXK3Ruj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 12:50:39 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 7B7865741F;
	Fri, 30 Nov 2007 18:50:37 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 8336t+1UsTSa; Fri, 30 Nov 2007 18:50:31 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id C9EF157723;
	Fri, 30 Nov 2007 18:50:28 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IyA0J-0002sw-91; Fri, 30 Nov 2007 18:50:19 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711291200000.27959@racer.site>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66650>

On Thu, Nov 29, 2007 at 12:01:47 +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 29 Nov 2007, Jan Hudec wrote:
> 
> > On Wed, Nov 28, 2007 at 23:48:12 +0000, Johannes Schindelin wrote:
> >
> > > Furthermore, my complaint was not about a platform where neither C# 
> > > nor Python work.  That is irrelevant.  If you have one platform where 
> > > only one works, and another platform where only the other works, you 
> > > cannot have a single program for both platforms.  Right?
> > 
> > Right.
> > 
> > I probably shouldn't be surprised that mono does not work on older unices,
> > but I am a bit surprised python does not.
> 
> *Sigh* I managed again to make myself misunderstood.
> 
> Even if newer Python does not easily compile on that IRIX, I have an old 
> Python there (2.2).  But I don't have any Python on MSys.  (Yes, there is 
> a _MinGW_ port, but no _MSys_ one.)  So for me, Python is out.

While it would be a problem, but is it really fatal? AFAIK MSys uses unixy
paths inside the program, but accepts arguments and calls other processes
using the windows convention, so mingw python should have no problem calling
msys programs and vice versa. It might be more problematic to compile
a shared module for it, but .dlls are quite well isolated, so even compiling
a plugin linked with msys for mingw python might not be impossible.

Nevertheless, I actually think git-gui is quite well in Tcl/Tk and rewriting
it in python nor any other language would probably help it in any way.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
