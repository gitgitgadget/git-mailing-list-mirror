From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Add a message explaining that automatic GC is about to
 start
Date: Thu, 18 Oct 2007 07:16:25 -0700
Message-ID: <47176AB9.7010409@midwinter.com>
References: <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org> <20071017015109.303760cc@localhost.localdomain> <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org> <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com> <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org> <20071018003256.GA5062@coredump.intra.peff.net> <alpine.LFD.0.999.0710171753020.26902@woody.linux-foundation.org> <20071018024553.GA5186@coredump.intra.peff.net> <alpine.LFD.0.999.0710171955580.26902@woody.linux-foundation.org> <20071018032307.GA7313@coredump.intra.peff.net> <20071018044143.GA24043@midwinter.com> <3391BADA-B5B4-4A8E-A6C0-42169AFC0331@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Luke Lu <git@vicaya.com>,
	Christer Weinigel <christer@weinigel.se>,
	Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 16:16:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiWB9-0006qn-ES
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 16:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763834AbXJROQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 10:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763918AbXJROQa
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 10:16:30 -0400
Received: from tater.midwinter.com ([216.32.86.90]:33871 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763828AbXJROQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 10:16:29 -0400
Received: (qmail 27744 invoked from network); 18 Oct 2007 14:16:28 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=CEj52jRlbS+mWN30Uy8ziQLCjf9q9a6LoIekXudj0oKomYnaBsqp7IR4FWVpS8+f  ;
Received: from localhost (HELO sgrimm-mbp.lan) (koreth@127.0.0.1)
  by localhost with SMTP; 18 Oct 2007 14:16:28 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <3391BADA-B5B4-4A8E-A6C0-42169AFC0331@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61532>

Brian Gernhardt wrote:
> I'm not sure telling the users how to disable it every time it shows 
> up is a good idea.  gc --auto exists for the naive user, and 
> suggesting they turn it off each time it happens will just result 
> in...  people turning it off, leading back to the performance issues 
> that caused the feature to be installed in the first place.  Perhaps a 
> message more along the lines of "To avoid this, run "git gc" manually 
> on a regular basis.  See 'git help gc' for more information."

That's a good point. Jeff / Shawn, do you agree with that? I'll come up 
with an alternate patch if so.

-Steve
