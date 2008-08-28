From: Perry Wagle <wagle@cs.indiana.edu>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 12:56:29 -0700
Message-ID: <EEE40F07-E371-45A1-ADB0-E6B680B2555F@cs.indiana.edu>
References: <20080826164526.GM26610@one.firstfloor.org> <48B5098E.748.A598B62@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de> <B83CC7EA-C77E-45CA-B9C5-FC81A8C0C9A5@cs.indiana.edu> <20080827195019.GA9962@sigill.intra.peff.net> <38B725C0-40C3-496C-AAD4-4EA65E3085F5@cs.indiana.edu> <48B5BC5F.4070209@kernel.org> <alpine.DEB.1.10.0808271717190.19923@gandalf.stny.rr.com> <7vd4jukphm.fsf@gitster.siamese.dyndns.org> <F86A1E37-8015-41B5-A462-F044B8D1C2B1@cs.indiana.edu> <BD6DEBB7-4D1C-43E9-B3D2-B46E42D9771D@cs.indiana.edu> <20080828090421.GQ10360@machine.or.cz> <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu> <1219920145.7107.273.camel@pmac.infradead.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>,
	=?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Steven Rostedt <rostedt@goodmis.org>, users@kernel.org,
	Jeff King <peff@peff.net>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	Andi Kleen <andi@firstfloor.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 21:58:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYndS-0007IS-Pq
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 21:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598AbYH1T5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 15:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753922AbYH1T5Y
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 15:57:24 -0400
Received: from newman.cs.indiana.edu ([129.79.247.4]:50696 "EHLO
	newman.cs.indiana.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295AbYH1T5X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 15:57:23 -0400
Received: from smtp.cs.indiana.edu (smtp.cs.indiana.edu [129.79.247.7])
	by newman.cs.indiana.edu (8.13.1/8.13.1/IUCS_2.87) with ESMTP id m7SJuZSm030615;
	Thu, 28 Aug 2008 15:56:36 -0400
Received: from dhcp-2.metabiology.com (pool-96-253-170-5.ptldor.fios.verizon.net [96.253.170.5])
	(authenticated bits=0)
	by rage.cs.indiana.edu (8.13.1/8.13.1/IUCS_SMTP_Alternate_Port_1.4) with ESMTP id m7SJuUan008058
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 28 Aug 2008 15:56:34 -0400
In-Reply-To: <1219920145.7107.273.camel@pmac.infradead.org>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94127>


On Aug 28, 2008, at 3:42 AM, David Woodhouse wrote:

> On Thu, 2008-08-28 at 03:33 -0700, Perry Wagle wrote:
>> Are you suggesting that I break into machines that I don't have  
>> access
>> to add a export PATH= line to copies of scripts that were written 6
>> months ago, and worked just fine until someone decided that "upward
>> compatibility" wasn't an important concept?
>
> Not at all. But as long as you also refrain from breaking into those
> same machines and upgrading them to git 1.6.0, you should be fine.

I was being over-dramatic in an attempt to get people to at least try  
to think it out.  You did, thanks!

But the actual problem is that I provide a central repository with  
"the current version of git" for us.  I'm not sure who all pulls from  
that repository, but a number of them have finally learned git well  
enough to clamor for 1.6.0.

So it's them upgrading from my repository, not me upgrading for them.

> Or if you _do_ upgrade them to git 1.6.0, you should make sure you  
> build
> with gitexecdir=/usr/bin to prevent the breakage.

That's a hack, which will burn me in less than a year.

> What distribution are you running on those machines? If they upgrade
> their version of git from an earlier version to 1.6.0 in a stable
> release without setting gitexecdir=/usr/bin to preserve compatibility,
> then the packager needs to be taken out back and shot.

I'm the packager.  I didn't upgrade our customized version of git  
because I'm still trying to think it out.

I don't get to break things.  If I break them, I gotta fix them.  I  
haven't been paid to do git stuff for months, and I have a deadline  
tomorrow.  But I gotta act now if I want a chance to live a life  
without the git community breaking upward compatibility on minor  
version releases for completely frivolous reasons.  It wasn't broke,  
but you "fixed" it anyway.  What's next?

I'm more worried about what's next and what's already slipped through  
than this one particular thing.

-- Perry
