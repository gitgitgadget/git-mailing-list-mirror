From: Perry Wagle <wagle@cs.indiana.edu>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 14:41:52 -0700
Message-ID: <1C144B19-DA21-4CB4-B872-C1F154B031CF@cs.indiana.edu>
References: <alpine.DEB.1.10.0808271717190.19923@gandalf.stny.rr.com> <7vd4jukphm.fsf@gitster.siamese.dyndns.org> <F86A1E37-8015-41B5-A462-F044B8D1C2B1@cs.indiana.edu> <BD6DEBB7-4D1C-43E9-B3D2-B46E42D9771D@cs.indiana.edu> <20080828090421.GQ10360@machine.or.cz> <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu> <alpine.LFD.1.10.0808280934160.3300@nehalem.linux-foundation.org> <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu> <20080828195211.GA3545@mithlond.arda.local> <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu> <20080828212346.GA27867@coredump.intra.peff.net>
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
X-From: git-owner@vger.kernel.org Thu Aug 28 23:44:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYpI5-00080T-OK
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 23:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924AbYH1VnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 17:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753911AbYH1VnZ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 17:43:25 -0400
Received: from newman.cs.indiana.edu ([129.79.247.4]:55986 "EHLO
	newman.cs.indiana.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825AbYH1VnY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 17:43:24 -0400
Received: from smtp.cs.indiana.edu (smtp.cs.indiana.edu [129.79.247.7])
	by newman.cs.indiana.edu (8.13.1/8.13.1/IUCS_2.87) with ESMTP id m7SLfxfB006967;
	Thu, 28 Aug 2008 17:42:00 -0400
Received: from dhcp-2.metabiology.com (pool-96-253-170-5.ptldor.fios.verizon.net [96.253.170.5])
	(authenticated bits=0)
	by rage.cs.indiana.edu (8.13.1/8.13.1/IUCS_SMTP_Alternate_Port_1.4) with ESMTP id m7SLfr7H009457
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 28 Aug 2008 17:41:57 -0400
In-Reply-To: <20080828212346.GA27867@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94184>


On Aug 28, 2008, at 2:23 PM, Jeff King wrote:

> On Thu, Aug 28, 2008 at 01:23:50PM -0700, Perry Wagle wrote:
>
>> But, my problem is not git<DASH> vs git<SPACE>, but the slap-dash way
>> upward compatibility was broken and the "water over the dam" slippery
>> slope rationalizations that refuse to consider reverting.  "You"  
>> will do
>> it again in the future since you are declaring success here.  And  
>> "you"
>> have likely done it in the past 6 months.
>
> I don't think Junio is declaring success. In fact, I think he has sent
> several messages saying (paraphrasing of course):

I did not name anyone, and put "you" in quotes to try to not even  
imply I was pointing at one person.  Several people have declared  
success, but Junio wasn't one of them.  I think (?) that he was just  
the unwilling gunman.  8)

> So please stop making specious claims that there are crazy
> backwards-incompatibility bugs lurking throughout new versions of git.
> If there are, then please find and name them. If not, then I think the
> git community would welcome suggestions about how better to notify  
> users
> about the rare changes like this one.

I now have to TEST to find those crazy backwards-incompatibility bugs  
before I can upgrade us to 1.6.0.  To test, I have to try to imagine  
what I and others were assuming about git.  And this episode means  
that I can't make any assumptions about the sanity of any changes  
since March, which is the version I'm thinking of upgrading.

But note that THIS upward compatibility bug has been declared to not  
be a bug.  Will any others receive the same stamp?

So please put on your engineer hat, and stop talking about "specious  
claims" and hurting feelings.  Heck, I even got Linus himself to ask  
if us people were on drugs, and I didn't take it personally.  At least  
I'm saying something that can be disputed, and not ad hominem like  
Linus.  8)

How to better notify them is to do it on a major release, like Git  
2.0.  THEN, they expect upward compatibility to break.

-- Perry
