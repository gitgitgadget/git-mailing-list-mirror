From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 00/31] Push GUI, GUI improvements, various jgit
	stuff
Date: Mon, 25 Aug 2008 07:24:17 -0700
Message-ID: <20080825142417.GC25654@spearce.org>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com> <20080819175931.GH20947@spearce.org> <200808192121.30372.robin.rosenberg.lists@dewire.com> <48AB84A2.7010905@gmail.com> <20080820141326.GA3483@spearce.org> <48B2BAD1.5030909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 16:34:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXd0g-00058f-Do
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 16:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748AbYHYOYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 10:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755617AbYHYOYS
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 10:24:18 -0400
Received: from george.spearce.org ([209.20.77.23]:39320 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654AbYHYOYR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 10:24:17 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3A73F38375; Mon, 25 Aug 2008 14:24:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48B2BAD1.5030909@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93629>

Marek Zawirski <marek.zawirski@gmail.com> wrote:
> Shawn O. Pearce wrote:
>>
>> I've thought about starting a code.google.com project just to use
>> the issue tracking system there.
>
> That seems to be nice idea.
> The only downside I see is that using code.coogle.com with Mylyn may be  
> hard[1]. As if we start to use issues system, it may be nice opportunity  
> to start using Mylyn - if anybody want to?
>
> [1] http://www.jroller.com/alexRuiz/entry/using_mylyn_with_google_code

A comment there suggests its gotten slightly better:

Posted by Christopher Barber on July 17, 2008 at 02:26 PM PDT:
> There was a regression introduced in the 3.0 version of mylyn,
> but it has been fixed in 3.0.1, which was just released.
> 
> Also, since Google Code now supports csv output, you are probably
> better off changing your Query URL to:
> 
> ${serverUrl}/csv?can=1&colspec=ID+Status+Type+Owner+Summary
> 
> and your Query Pattern to:
> 
> "({Id}[0-9]+?)","({Status}.+?)","({Type}.+?)","({Owner}.+?)","({Description}.+?)"\n
> 
> This should provide a faster sync, since it minimizes the amount
> of bytes downloaded.

I may give it a try later today.

I also know some of the folks behind code.google.com.  I can poke
them to see if Mylyn support is going to be coming along in the
near future.  Google uses Eclipse a lot internally, and we have
a number of open source projects using code.google.com as their
hosting/issue tracking, and Eclipse as their IDE.  We probably
should be making the issue tracking product more accessible to IDEs.

-- 
Shawn.
