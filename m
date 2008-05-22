From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix t3701 if core.filemode disabled
Date: Thu, 22 May 2008 15:20:42 +0200
Message-ID: <20080522132042.GF3206@steel.home>
References: <20080518152337.GB3058@steel.home> <20080518190839.GC15506@sigill.intra.peff.net> <20080518200121.GA5789@steel.home> <20080519202342.GA9694@steel.home> <20080519205550.GA24246@sigill.intra.peff.net> <20080520215932.GB10437@steel.home> <20080521143607.GA3575@sigill.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 22 15:21:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzAjg-0002XR-Q7
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 15:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761854AbYEVNUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 09:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763514AbYEVNUp
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 09:20:45 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:57200 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761854AbYEVNUo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 09:20:44 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMna1s/dNSK
Received: from tigra.home (Fa855.f.strato-dslnet.de [195.4.168.85])
	by post.webmailer.de (klopstock mo62) (RZmta 16.38)
	with ESMTP id v034fck4MC9aiU ; Thu, 22 May 2008 15:20:42 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 228BA277BD;
	Thu, 22 May 2008 15:20:42 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 2D4D956D28; Thu, 22 May 2008 15:20:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080521143607.GA3575@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82630>

Jeff King, Wed, May 21, 2008 16:36:07 +0200:
> 2. It's a little hard to see which tests are affected. I would have done
>    something more like:
> 
>   if test "$(git config --bool core.filemode)" = true
>     test_filemode=
>   else
>     test_filemode=:
>   fi
> 
>   $test_filemode test_expect_success ...
> 
>   But maybe that is just overengineering.

But a nice one. I like the idea but Junio already did your other
suggestions in master, so I just keep it in mind for the next one
