From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Licensing and the library version of git
Date: Fri, 28 Jul 2006 11:01:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607281053580.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910607261436v4c0802e5v7301e904593f9bab@mail.gmail.com> 
 <20060727114105.GZ13776@pasky.or.cz>  <Pine.LNX.4.63.0607271400160.29667@wbgn013.biozentrum.uni-wuerzburg.de>
  <9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com> 
 <20060727131127.GA13776@pasky.or.cz>  <9e4733910607270911p50d25d97w1a898fc7a9119e7d@mail.gmail.com>
  <eablgn$c6a$1@sea.gmane.org> <9e4733910607271743o3b7a27d5v55a216745937c74e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 28 11:01:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6ODm-00089c-BX
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 11:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbWG1JBW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 05:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161105AbWG1JBW
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 05:01:22 -0400
Received: from mail.gmx.de ([213.165.64.21]:15754 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161109AbWG1JBV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 05:01:21 -0400
Received: (qmail invoked by alias); 28 Jul 2006 09:01:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 28 Jul 2006 11:01:17 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910607271743o3b7a27d5v55a216745937c74e@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24377>

Hi,

On Thu, 27 Jul 2006, Jon Smirl wrote:

> On 7/27/06, Anand Kumria <wildfire@progsoc.org> wrote:
>
> > So, using CVSNT (a GPL'd SCCI provider) and git-cvsserver would be a way
> > to continue.  I'm assuming that the primary functionality they want via
> > their IDE is checkout/diff/commit/log.
> 
> Now, that's a great strategy. Tell the large project you are
> interested in switching off from CVS to git that they need to run a
> CVS emulation gateway forever. I don't think a switch has much of a
> chance of happening.

Oh, but it has!

The beautiful thing is that you can change to git _without_ changing all 
client software! Just to a git-cvsimport, switch, and some might not even 
notice that the server has changed behind their back.

And then, you can phase out CVS slowly.

BTW have you worked with MSVC's integrated source control? In every single 
case where I had to work with MSVC, I found I'm way faster with external 
tools (and it did not matter if the SCM was Visual Source Safe, CVS or 
PVCS). I know that my colleagues found the same.

BTW2 I agree that some deciding people would make MSVC integration a 
premise for migration to Git. So, why don't you give it a try? (I do not 
have a working MSVC setup, or I would help you.)

Ciao,
Dscho
