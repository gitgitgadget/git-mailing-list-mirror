From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Support for old Perl versions
Date: Sat, 31 May 2008 13:32:16 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805311328040.13507@racer.site.net>
References: <20080530095047.GD18781@machine.or.cz> <1212179270-26170-1-git-send-email-LeWiemann@gmail.com> <20080530210531.GH18781@machine.or.cz> <7vd4n3iivt.fsf@gitster.siamese.dyndns.org> <86r6bjmpqc.fsf@blue.stonehenge.com> <484078C7.7020008@gmail.com>
 <alpine.DEB.1.00.0805311248050.13507@racer.site.net> <20080531121755.GL593@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lea Wiemann <lewiemann@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat May 31 14:34:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2QHp-0007rW-EC
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 14:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbYEaMdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 08:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbYEaMdZ
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 08:33:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:55815 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750867AbYEaMdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 08:33:25 -0400
Received: (qmail invoked by alias); 31 May 2008 12:33:22 -0000
Received: from R3073.r.pppool.de (EHLO none.local) [89.54.48.115]
  by mail.gmx.net (mp055) with SMTP; 31 May 2008 14:33:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+LfJN+GZCLpFRdg8E4bggxkn1EVPex3IDFzR1PeJ
	T+h81CFWkCd/t1
X-X-Sender: gene099@racer.site.net
In-Reply-To: <20080531121755.GL593@machine.or.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83379>

Hi,

On Sat, 31 May 2008, Petr Baudis wrote:

> On Sat, May 31, 2008 at 12:50:14PM +0100, Johannes Schindelin wrote:
> > On Fri, 30 May 2008, Lea Wiemann wrote:
> > 
> > > I'm honestly not too keen on sacrificing time (or code prettiness) 
> > > on 5.6 compatibility, so if there are no reasons besides the memory 
> > > leak to move away from throw/catch, perhaps we can just keep using 
> > > it?
> > 
> > I think your opinion would change dramatically if you were stuck on a 
> > platform with Perl 5.6.  In general, I deem it not nice to sacrifice 
> > backwards compatibility just because _you_ do not need it.
> 
>   let's get some perspective here: 5.6.1 was released on 2001-Apr-08. 
> 5.8.0 followed on 2002-Jul-18.  Is there anyone on the list who _is_ 
> stuck on a platform with Perl 5.6 _and_ uses Git on it? Heck, we are 
> even approaching GNU Interactive Tools 4.3.20 release here, walking that 
> much back.

I think this is not an interesting question.  Those stuck with Perl 5.6 
are most likely not those who lurk on this list.

Sure, we could just require users to upgrade to Linux, newest glibc and 
everything and be done.  We could also require our users to stick their 
fingers where the sun don't shine.

The really interesting question is: is the time of a single developer (who 
gets all the upsides of requiring a certain setup) worth the hassle and 
pain of possibly more than one person getting all the _downsides_?

In the case that started this thread, I would not hesitate a single 
microsecond to answer "No, hell no".

Hth,
Dscho
