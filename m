From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 0/8] builtin-clone
Date: Fri, 18 Apr 2008 03:14:31 +0200
Message-ID: <200804180314.31659.johan@herland.net>
References: <alpine.LNX.1.00.0804171923040.19665@iabervon.org>
 <200804180250.48544.johan@herland.net>
 <alpine.LNX.1.00.0804172052300.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Apr 18 03:16:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmfCx-0005ZF-NF
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 03:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbYDRBPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 21:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbYDRBPV
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 21:15:21 -0400
Received: from smtp.getmail.no ([84.208.20.33]:52247 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751228AbYDRBPU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 21:15:20 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JZH00K01Y5JDB00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 18 Apr 2008 03:15:19 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZH00L3NY48BA80@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 18 Apr 2008 03:14:32 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZH00L53Y47ORE0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 18 Apr 2008 03:14:32 +0200 (CEST)
In-reply-to: <alpine.LNX.1.00.0804172052300.19665@iabervon.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79858>

On Friday 18 April 2008, Daniel Barkalow wrote:
> On Fri, 18 Apr 2008, Johan Herland wrote:
> > On Friday 18 April 2008, Daniel Barkalow wrote:
> > > This is my latest version, rebased approximately on current master (or 
> > > recent maint, I guess). It's missing all of Johan's stuff, which is tests 
> > > for stuff I've fixed
> > 
> > Does this mean you no longer need the tests, or that you want me to resend?
> 
> I have them, but my patch-sending process isn't set up for sending other 
> people's patches without forging their email, and I wanted to get this 
> series out, and they're not critical, so I skipped them for now.

No problem. Feel free to do whatever you like with them. :)

> > 1. Add a command-line option (and config variable?) for controlling
> >    whether "git clone" generates packed refs.
> > 
> > 2. Make "git clone" unconditionally generate packed refs.
> > 
> > Currently, I'm leaning towards (2), [...]
> > 
> > If there are good arguments for going with (1), I'd love to hear them.
> 
> I think it's fine, actually (now that you've not test corrections that 
> work for it); but I'd like to have builtin-clone land without any changes 
> in behaviour, and then get this sort of improvement.

Yes, I agree that a pure rewrite (without changes in behaviour) should be
committed first.


Have fun :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
