From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Add a message explaining that automatic GC is about to start
Date: Thu, 18 Oct 2007 09:52:08 -0400
Message-ID: <3391BADA-B5B4-4A8E-A6C0-42169AFC0331@silverinsanity.com>
References: <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org> <20071017015109.303760cc@localhost.localdomain> <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org> <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com> <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org> <20071018003256.GA5062@coredump.intra.peff.net> <alpine.LFD.0.999.0710171753020.26902@woody.linux-foundation.org> <20071018024553.GA5186@coredump.intra.peff.net> <alpine.LFD.0.999.0710171955580.26902@woody.linux-foundation.org> <20071018032307.GA7313@coredump.intra.peff.net> <20071018044143.GA24043@midwinter.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Luke Lu <git@vicaya.com>,
	Christer Weinigel <christer@weinigel.se>,
	Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: koreth@midwinter.com
X-From: git-owner@vger.kernel.org Thu Oct 18 15:52:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiVnk-0000kc-DY
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 15:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761957AbXJRNv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 09:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757827AbXJRNv7
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 09:51:59 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:48025 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757776AbXJRNv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 09:51:58 -0400
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id F18511FFC22B;
	Thu, 18 Oct 2007 13:51:50 +0000 (UTC)
In-Reply-To: <20071018044143.GA24043@midwinter.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61530>


On Oct 18, 2007, at 12:41 AM, koreth@midwinter.com wrote:

> And as an added bonus, we can tell people how to turn off automatic GC
> and how to invoke it by hand.

> +		fprintf(stderr, "Packing your repository for optimum "
> +			"performance. If you would rather run\n"
> +			"\"git gc\" by hand, run \"git config gc.auto 0\" "
> +			"to disable automatic cleanup.\n");

I'm not sure telling the users how to disable it every time it shows  
up is a good idea.  gc --auto exists for the naive user, and  
suggesting they turn it off each time it happens will just result  
in...  people turning it off, leading back to the performance issues  
that caused the feature to be installed in the first place.  Perhaps  
a message more along the lines of "To avoid this, run "git gc"  
manually on a regular basis.  See 'git help gc' for more information."

~~ Brian
