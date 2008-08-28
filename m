From: Perry Wagle <wagle@cs.indiana.edu>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 12:24:17 -0700
Message-ID: <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu>
References: <20080826164526.GM26610@one.firstfloor.org> <48B5098E.748.A598B62@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de> <B83CC7EA-C77E-45CA-B9C5-FC81A8C0C9A5@cs.indiana.edu> <20080827195019.GA9962@sigill.intra.peff.net> <38B725C0-40C3-496C-AAD4-4EA65E3085F5@cs.indiana.edu> <48B5BC5F.4070209@kernel.org> <alpine.DEB.1.10.0808271717190.19923@gandalf.stny.rr.com> <7vd4jukphm.fsf@gitster.siamese.dyndns.org> <F86A1E37-8015-41B5-A462-F044B8D1C2B1@cs.indiana.edu> <BD6DEBB7-4D1C-43E9-B3D2-B46E42D9771D@cs.indiana.edu> <20080828090421.GQ10360@machine.or.cz> <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu> <alpine.LFD.1.10.0808280934160.3300@nehalem.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jeff King <peff@peff.net>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	Andi Kleen <andi@firstfloor.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 21:27:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYn9W-00059M-0y
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 21:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767AbYH1T0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 15:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753314AbYH1T0S
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 15:26:18 -0400
Received: from newman.cs.indiana.edu ([129.79.247.4]:48965 "EHLO
	newman.cs.indiana.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbYH1T0R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 15:26:17 -0400
Received: from smtp.cs.indiana.edu (smtp.cs.indiana.edu [129.79.247.7])
	by newman.cs.indiana.edu (8.13.1/8.13.1/IUCS_2.87) with ESMTP id m7SJOQfE027772;
	Thu, 28 Aug 2008 15:24:27 -0400
Received: from dhcp-2.metabiology.com (pool-96-253-170-5.ptldor.fios.verizon.net [96.253.170.5])
	(authenticated bits=0)
	by rage.cs.indiana.edu (8.13.1/8.13.1/IUCS_SMTP_Alternate_Port_1.4) with ESMTP id m7SJOHWX007554
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 28 Aug 2008 15:24:22 -0400
In-Reply-To: <alpine.LFD.1.10.0808280934160.3300@nehalem.linux-foundation.org>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94121>

On Aug 28, 2008, at 9:35 AM, Linus Torvalds wrote:

> On Thu, 28 Aug 2008, Perry Wagle wrote:
>>
>> The PATH thing fixes the problem of typing in git-commands at the
>> command line, but not for scripts containing git<DASH> commands.   
>> I've
>> seen no-one rebut my rebuttal.
>
> What drugs are you people on?

No drugs, just that I was expecting people to do more than demonstrate  
to me the excellence of their knee reflex.  Especially you (Linus),  
who supports thinking things out and not depending on debugging tools.

I prefer to think things out and not "coding from the hip".  I can be  
proven wrong, but you are going to have to engage your brain to do  
so.  Threatening me or whacking me with the neural loop from your  
spine to your knee isn't going to cut it.

> Just put it in your .bash_profile or something. It will now work for  
> all
> your scripts.

In terms of continuing to provide me git<DASH><TAB> if I so desire,  
that's an excellent idea, and I've repeatedly said so.

In terms of preserving scripts, thats a filthy hack that only fixes my  
own execution of those scripts, not for other people.  And some people  
don't run bash, so /etc/bashrc *on every system* or whatever doesn't  
actually do it either.  Did you think that out?

> And for us people who do _not_ want it, we fix the scripts, or we  
> don't
> run them.

This is one upward compatibility broken for goofy reasons, at least  
those given in this thread, where there were numerous "ZOMG!  I get  
143 completions!" accompanied by false claims that it was a 143  
element *list* when in fact a *hash table* is used.

But the issue for me is what other upward compatibilities were  
broken?  What am I testing for?  Is is really only that I

     sed s/git-/git<SPACE>/g

on the scripts?  I'm doubting it, given the quality of reasoning and  
lack of respect for upward compatibility on this thread.

Yes, I'm over-killing a molehill, but I see you all building a  
mountain in the distance that I don't feel like climbing.  I haven't  
been paid to do git stuff for months.

-- Perry
