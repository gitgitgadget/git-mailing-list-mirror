From: Perry Wagle <wagle@cs.indiana.edu>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 16:28:34 -0700
Message-ID: <76E64CE4-758C-4215-BA46-A222A8D78C12@cs.indiana.edu>
References: <20080828090421.GQ10360@machine.or.cz> <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu> <alpine.LFD.1.10.0808280934160.3300@nehalem.linux-foundation.org> <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu> <20080828195211.GA3545@mithlond.arda.local> <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu> <20080828212346.GA27867@coredump.intra.peff.net> <1C144B19-DA21-4CB4-B872-C1F154B031CF@cs.indiana.edu> <20080828215907.GE27867@coredump.intra.peff.net> <3DE083DB-ADFF-45E7-B3EB-A76985941271@cs.indiana.edu> <20080828230401.GC29609@coredump.intra.peff.net> <7vmyiwd8ot.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Teemu Likonen <tlikonen@iki.fi>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Petr Baudis <pasky@suse.cz>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	Andi Kleen <andi@firstfloor.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 01:31:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYqxs-0003oB-If
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 01:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755171AbYH1Xab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 19:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755166AbYH1Xab
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 19:30:31 -0400
Received: from newman.cs.indiana.edu ([129.79.247.4]:59843 "EHLO
	newman.cs.indiana.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755143AbYH1Xaa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 19:30:30 -0400
Received: from smtp.cs.indiana.edu (smtp.cs.indiana.edu [129.79.247.7])
	by newman.cs.indiana.edu (8.13.1/8.13.1/IUCS_2.87) with ESMTP id m7SNSfIu013659;
	Thu, 28 Aug 2008 19:28:42 -0400
Received: from dhcp-2.metabiology.com (pool-96-253-170-5.ptldor.fios.verizon.net [96.253.170.5])
	(authenticated bits=0)
	by rage.cs.indiana.edu (8.13.1/8.13.1/IUCS_SMTP_Alternate_Port_1.4) with ESMTP id m7SNSZ94010860
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 28 Aug 2008 19:28:39 -0400
In-Reply-To: <7vmyiwd8ot.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94209>

My (ahem) implied point (sorry) also was that these "hook" scripts act  
as examples of how to write git scripts in general, and some of them  
are written to me run as regular scripts.

-- Perry

On Aug 28, 2008, at 4:24 PM, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>>> In March 2008, the sample git-hooks and git-web used git<DASH>  
>>> commands.
>>> That was the last I looked at git until Tuesday of this week.
>>
>> Yes, and some of the test scripts still have git-* in them. I think  
>> in
>> that respect, the git community has been very bad about eating our  
>> own
>> dog food.
>
> Not at all.
>
> For one thing, hooks do run under modified PATH, as already pointed  
> out in
> the earlier thread.
>
> Test scripts are executed in a special environment whose GIT_EXEC_PATH
> points at the top of the build tree, where all git-foo lives.
>
> Before anybody greps in Documentation/ to make pointless noises  
> about some
> dashed-form git-foo in there when we do not talk about what the user  
> types
> but about a command as a concept in manual pages, they are left in  
> dashed
> form deliberately, partly to help manpage browsers crosslink across  
> pages.
>
> We could have described typographic convention,
>
> Cf.
>
>    http://thread.gmane.org/gmane.comp.version-control.git/86940/focus=87008
>
> but we ended up not doing so.
