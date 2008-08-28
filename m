From: Perry Wagle <wagle@cs.indiana.edu>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 03:33:46 -0700
Message-ID: <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu>
References: <20080826164526.GM26610@one.firstfloor.org> <48B5098E.748.A598B62@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de> <B83CC7EA-C77E-45CA-B9C5-FC81A8C0C9A5@cs.indiana.edu> <20080827195019.GA9962@sigill.intra.peff.net> <38B725C0-40C3-496C-AAD4-4EA65E3085F5@cs.indiana.edu> <48B5BC5F.4070209@kernel.org> <alpine.DEB.1.10.0808271717190.19923@gandalf.stny.rr.com> <7vd4jukphm.fsf@gitster.siamese.dyndns.org> <F86A1E37-8015-41B5-A462-F044B8D1C2B1@cs.indiana.edu> <BD6DEBB7-4D1C-43E9-B3D2-B46E42D9771D@cs.indiana.edu> <20080828090421.GQ10360@machine.or.cz>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Steven Rostedt <rostedt@goodmis.org>, users@kernel.org,
	Jeff King <peff@peff.net>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	Andi Kleen <andi@firstfloor.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Aug 28 12:36:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYerN-0005bd-8j
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 12:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbYH1KfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 06:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbYH1KfH
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 06:35:07 -0400
Received: from newman.cs.indiana.edu ([129.79.247.4]:44252 "EHLO
	newman.cs.indiana.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbYH1KfG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 06:35:06 -0400
Received: from smtp.cs.indiana.edu (smtp.cs.indiana.edu [129.79.247.7])
	by newman.cs.indiana.edu (8.13.1/8.13.1/IUCS_2.87) with ESMTP id m7SAXsme005538;
	Thu, 28 Aug 2008 06:33:55 -0400
Received: from dhcp-2.metabiology.com (pool-96-253-170-5.ptldor.fios.verizon.net [96.253.170.5])
	(authenticated bits=0)
	by rage.cs.indiana.edu (8.13.1/8.13.1/IUCS_SMTP_Alternate_Port_1.4) with ESMTP id m7SAXlcO000379
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 28 Aug 2008 06:33:51 -0400
In-Reply-To: <20080828090421.GQ10360@machine.or.cz>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Aug 28, 2008, at 2:04 AM, Petr Baudis wrote:

>  This thread is starting to seriously irritate even *me* by now, which
> is quite a feat...
>
> On Wed, Aug 27, 2008 at 05:05:33PM -0700, Perry Wagle wrote:
>> Oh yeah, sorry.  I neglected to mention that my problem was having  
>> the
>> git- forms in scripts all over an internal network, and having no
>> amazingly easy way of fixing them.  I don't know who all copied them.
>
>  Should I count for you how many times the $PATH workaround has been
> mentioned already? Or the gitexecdir workaround?

The PATH thing fixes the problem of typing in git-commands at the  
command line, but not for scripts containing git<DASH> commands.  I've  
seen no-one rebut my rebuttal.

Are you suggesting that I break into machines that I don't have access  
to add a export PATH= line to copies of scripts that were written 6  
months ago, and worked just fine until someone decided that "upward  
compatibility" wasn't an important concept?

What other upward compatibilities were broken in the past six months?   
What am I testing for tomorrow when I fix it before releasing an  
upgraded git?  Next month?

I really don't understand this "upward compatibility doesn't matter"  
thing.

>  What the hell are you talking about? Did you *try*? git<SPACE><TAB>
> does not do the same thing as git<DASH><TAB>, and it has been clearly
> stated in this thread several times. It shows only the commands that  
> are
> *interesting* for the user, just as $PATH does not include /usr/sbin  
> and
> /sbin and /usr/lib/wine because the executables in these directories
> just aren't interesting for the users. If you care about all the Git
> internals, go read git(1) to see the list of all the plumbing stuff.

In this thread the new completion thing has been clearly stated both  
ways.

I have one, apparently very authoritative, response in this thread  
assuring me that it will not be the case that the command completion  
space will be restricted in the fashion you support.  I'm not sure who  
to believe.  It might not matter: apparently, one person in the thread  
was forced to make the change we are all responding to here.  When  
does that happen again?

I find the notion that the command completion should give partial  
results an unpleasant concept.  I've been stuck with systems with no  
documentation, but with command completion with that sort of thinking,  
and as a result, and it was very frustrating.

-- Perry
