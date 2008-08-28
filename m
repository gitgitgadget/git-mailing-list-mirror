From: Perry Wagle <wagle@cs.indiana.edu>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 13:42:22 -0700
Message-ID: <B0BAA28F-C029-411B-BE86-3A63951CE213@cs.indiana.edu>
References: <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vr68b8q9p.fsf@gitster.siamese.dyndns.org> <20080827001705.GG23698@parisc-linux.org> <7v63pmkozh.fsf@gitster.siamese.dyndns.org> <1219907659.7107.230.camel@pmac.infradead.org> <7vtzd5fta0.fsf@gitster.siamese.dyndns.org> <1219912327.7107.245.camel@pmac.infradead.org> <94a0d4530808280157p230d289dlf0c85cd517541801@mail.gmail.com> <20080828115408.GA30834@hera.kernel.org> <94a0d4530808280615i2befb89cm7d6153bfceb11b19@mail.gmail.com> <94a0d4530808280634k1c23fe10q8934875c83d4a2f5@mail.gmail.com> <alpine.LFD.1.10.0808280936300.3300@nehalem.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Al Viro <viro@hera.kernel.org>,
	Matthew Wilcox <matthew@wil.cx>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 22:47:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYoP7-0007ru-AH
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 22:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756110AbYH1UqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 16:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756032AbYH1UqV
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 16:46:21 -0400
Received: from newman.cs.indiana.edu ([129.79.247.4]:53134 "EHLO
	newman.cs.indiana.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755952AbYH1UqU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 16:46:20 -0400
Received: from smtp.cs.indiana.edu (smtp.cs.indiana.edu [129.79.247.7])
	by newman.cs.indiana.edu (8.13.1/8.13.1/IUCS_2.87) with ESMTP id m7SKgUBY002119;
	Thu, 28 Aug 2008 16:42:30 -0400
Received: from dhcp-2.metabiology.com (pool-96-253-170-5.ptldor.fios.verizon.net [96.253.170.5])
	(authenticated bits=0)
	by rage.cs.indiana.edu (8.13.1/8.13.1/IUCS_SMTP_Alternate_Port_1.4) with ESMTP id m7SKgNvo008661
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 28 Aug 2008 16:42:27 -0400
In-Reply-To: <alpine.LFD.1.10.0808280936300.3300@nehalem.linux-foundation.org>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94138>

On Aug 28, 2008, at 9:37 AM, Linus Torvalds wrote:

> On Thu, 28 Aug 2008, Felipe Contreras wrote:
>>
>> If the git-foo was supposed to be deprecated in 1.6.0
>
> Itw as deprecated over a _year_ ago.

No, it wasn't.  As of March 2008, git<DASH> was still in the sample  
hooks and in git-web.  That was the last time I did anything with git  
scripting.  It was something between then and now that the <DASH>'s  
were finally removed.

Oh wait:

     dhcp-2:git wagle$ grep -r --color git- . | wc -l
         6580
     dhcp-2:git wagle$

No, I'm not going to figure out which are okay, and which aren't.   
I'll just assume that they are all okay, but leave you to wonder.

-- Perry

PS.  Okay, fine!  Here's as far as I got before getting bored:

     grep -r git- . | cat -v | sed "s/^.*\(git-[^ :\")\[($\']*\).*$/ 
\1/" | sort | uniq
