From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 18:39:13 -0700 (PDT)
Message-ID: <20060928013914.16514.qmail@web51005.mail.yahoo.com>
References: <20060928002327.GA22593@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 28 03:39:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSkrv-0004Px-OR
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 03:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175AbWI1BjQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 21:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965177AbWI1BjQ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 21:39:16 -0400
Received: from web51005.mail.yahoo.com ([206.190.38.136]:58717 "HELO
	web51005.mail.yahoo.com") by vger.kernel.org with SMTP
	id S965175AbWI1BjP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 21:39:15 -0400
Received: (qmail 16516 invoked by uid 60001); 28 Sep 2006 01:39:14 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=RyCzj+mpQsWa7D6GcgzDzL/TPGEsfsy730X9Uork2NdQ0RN4cVRHfQMcbx4NdxaeX0saBEGOvuRrePNnqUBuoxevBfR9l2SUKwwoYGD96SIEw9EMU9RXJ3o03ftErjCK4QSzoPC8395UOpQTropHAASsO4WU5fU1wvp1/z4cRtI=  ;
Received: from [207.172.80.85] by web51005.mail.yahoo.com via HTTP; Wed, 27 Sep 2006 18:39:13 PDT
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060928002327.GA22593@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27963>


--- Shawn Pearce <spearce@spearce.org> wrote:

> Dependency order is all that matters.
> 
> It doesn't matter if K. Hacker makes a bug fix at 8 am his local
> time or 3 days ago.  All that matters is that K. Hacker made it by
> changing version A to version B.  Therefore commit B (containing
> the bug fix) depends on commit A and only commit A (which may in
> turn depend on commit A^, etc.).

>From a web display/generic notion of integrity perspective time order matters to me but it looks
like I am the only one. Keeping track of _local_ commit time would not add any dependencies. 

-Matt


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
