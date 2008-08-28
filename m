From: Perry Wagle <wagle@cs.indiana.edu>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 16:22:12 -0700
Message-ID: <4018E8E1-9C23-4AED-BA78-6E889A32E691@cs.indiana.edu>
References: <20080828090421.GQ10360@machine.or.cz> <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu> <alpine.LFD.1.10.0808280934160.3300@nehalem.linux-foundation.org> <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu> <20080828195211.GA3545@mithlond.arda.local> <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu> <20080828212346.GA27867@coredump.intra.peff.net> <1C144B19-DA21-4CB4-B872-C1F154B031CF@cs.indiana.edu> <20080828215907.GE27867@coredump.intra.peff.net> <3DE083DB-ADFF-45E7-B3EB-A76985941271@cs.indiana.edu> <20080828230401.GC29609@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Petr Baudis <pasky@suse.cz>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	Andi Kleen <andi@firstfloor.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 29 01:24:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYqqe-0001Gs-GX
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 01:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356AbYH1XXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 19:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbYH1XXM
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 19:23:12 -0400
Received: from newman.cs.indiana.edu ([129.79.247.4]:59557 "EHLO
	newman.cs.indiana.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187AbYH1XXL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 19:23:11 -0400
Received: from smtp.cs.indiana.edu (smtp.cs.indiana.edu [129.79.247.7])
	by newman.cs.indiana.edu (8.13.1/8.13.1/IUCS_2.87) with ESMTP id m7SNMIJr013266;
	Thu, 28 Aug 2008 19:22:19 -0400
Received: from dhcp-2.metabiology.com (pool-96-253-170-5.ptldor.fios.verizon.net [96.253.170.5])
	(authenticated bits=0)
	by rage.cs.indiana.edu (8.13.1/8.13.1/IUCS_SMTP_Alternate_Port_1.4) with ESMTP id m7SNMD50010778
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 28 Aug 2008 19:22:17 -0400
In-Reply-To: <20080828230401.GC29609@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94206>

On Aug 28, 2008, at 4:04 PM, Jeff King wrote:

> On Thu, Aug 28, 2008 at 03:33:26PM -0700, Perry Wagle wrote:
>
>> But I think I'll still remain wary because 1.6 introduced a nearly
>> complete renaming of the API for what, in this thread anyway,  
>> completely
>> silly reasons.  If there are good reasons, I haven't seen them.
>
> I think the reasons have been mentioned a few times. Maybe you just
> didn't think they were good.

What I saw was "git<DASH><SPACE> produces a list of 143 commands.   
Long lists are inefficient.  Get rid of it!".  Actually the list is a  
hash table in any reasonable shell.  So its only aesthetics?

Being able to quickly see the list is very useful.  That could be done  
with git<SPACE><TAB>, except some people want that to be lobotomized  
to show only a fraction of the total.  My mind boggles at that one.

But see my other post.  I'm over it.

-- Perry
