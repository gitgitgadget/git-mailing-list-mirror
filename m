From: Perry Wagle <wagle@cs.indiana.edu>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 16:14:14 -0700
Message-ID: <CD2FC91F-D5BB-486D-B138-F521A493FE73@cs.indiana.edu>
References: <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vr68b8q9p.fsf@gitster.siamese.dyndns.org> <20080827001705.GG23698@parisc-linux.org> <7v63pmkozh.fsf@gitster.siamese.dyndns.org> <1219907659.7107.230.camel@pmac.infradead.org> <7vtzd5fta0.fsf@gitster.siamese.dyndns.org> <1219912327.7107.245.camel@pmac.infradead.org> <94a0d4530808280157p230d289dlf0c85cd517541801@mail.gmail.com> <20080828115408.GA30834@hera.kernel.org> <94a0d4530808280615i2befb89cm7d6153bfceb11b19@mail.gmail.com> <94a0d4530808280634k1c23fe10q8934875c83d4a2f5@mail.gmail.com> <alpine.LFD.1.10.0808280936300.3300@nehalem.linux-foundation.org> <B0BAA28F-C029-411B-BE86-3A63951CE213@cs.indiana.edu> <m3prnsrbdp.fsf@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Al Viro <viro@hera.kernel.org>,
	Matthew Wilcox <matthew@wil.cx>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 01:16:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYqip-0007iS-ST
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 01:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402AbYH1XPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 19:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754564AbYH1XPH
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 19:15:07 -0400
Received: from newman.cs.indiana.edu ([129.79.247.4]:59223 "EHLO
	newman.cs.indiana.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356AbYH1XPG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 19:15:06 -0400
Received: from smtp.cs.indiana.edu (smtp.cs.indiana.edu [129.79.247.7])
	by newman.cs.indiana.edu (8.13.1/8.13.1/IUCS_2.87) with ESMTP id m7SNELj1012803;
	Thu, 28 Aug 2008 19:14:21 -0400
Received: from dhcp-2.metabiology.com (pool-96-253-170-5.ptldor.fios.verizon.net [96.253.170.5])
	(authenticated bits=0)
	by rage.cs.indiana.edu (8.13.1/8.13.1/IUCS_SMTP_Alternate_Port_1.4) with ESMTP id m7SNEFUU010688
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 28 Aug 2008 19:14:19 -0400
In-Reply-To: <m3prnsrbdp.fsf@localhost.localdomain>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94203>

I did:

pwagle@starscream:/usr/lib/cgi-bin$ ls -l
total 352
-rw-r--r-- 1 root root    164 2008-03-07 12:03 git-favicon.png
-rw-r--r-- 1 root root    208 2008-03-07 12:03 git-logo.png
-rwxr-xr-x 1 root root 167729 2008-03-07 12:03 gitweb.cgi
-rw-r--r-- 1 root root   7112 2008-03-07 12:03 gitweb.css
-rwxr-xr-x 1 root root 167932 2008-03-07 12:03 gitweb.perl
pwagle@starscream:/usr/lib/cgi-bin$ grep git- * | wc -l
68
pwagle@starscream:/usr/lib/cgi-bin$

On Aug 28, 2008, at 4:03 PM, Jakub Narebski wrote:

> Perry Wagle <wagle@cs.indiana.edu> writes:
>
>> On Aug 28, 2008, at 9:37 AM, Linus Torvalds wrote:
>>> On Thu, 28 Aug 2008, Felipe Contreras wrote:
>>>>
>>>> If the git-foo was supposed to be deprecated in 1.6.0
>>>
>>> Itw as deprecated over a _year_ ago.
>>
>> No, it wasn't.  As of March 2008, git<DASH> was still in the sample
>> hooks and in git-web. [...]
>
> If by "git-web" you mean "gitweb", the git web interface in Perl, this
> is simply not true.  From the commit 25691fb (gitweb: Use --git-dir
> parameter instead of setting $ENV{'GIT_DIR'}) _at least_ gitweb uses
> "git <comd>" and not "git-cmd" form.  And this commit was on 28 August
> 2006, so in March 2008 gitweb didn't use git<DASH> form...
>
> Check your facts, please...
>
> -- 
> Jakub Narebski
> Poland
> ShadeHawk on #git
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
