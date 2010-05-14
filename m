From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/4] All is too much
Date: Fri, 14 May 2010 18:08:20 +0200
Message-ID: <4BED7574.4070503@drmicha.warpmail.net>
References: <20100505033536.GB8779@coredump.intra.peff.net> <cover.1273760226.git.git@drmicha.warpmail.net> <20100514060612.GA19652@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 14 18:08:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCxR4-0007sS-Im
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 18:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391Ab0ENQIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 12:08:17 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47793 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751979Ab0ENQIQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 May 2010 12:08:16 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6C975F6438;
	Fri, 14 May 2010 12:08:15 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 14 May 2010 12:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=lAj+/Ay47wCflFjvNxKf3yI6BLs=; b=q/NsCBVAQcUsH/mOdJ51d6JrztpRnIn6Z4NWz+RQzLTpuexI89PpaZatzSullTbyMoaCp6riWmzMk0XJbTCsQcHRNg8hZulrh1vIVmrlmfopSWLDh6uKdqdWaL7kHD06jK2Xh2P/QmkYf1cZxHLRLPaWC96weFsl6MOKwJwj0GM=
X-Sasl-enc: veAXT71+hGiuRNGlnZqmf7GNgKyAicFWimJZNvvyJ9VW 1273853295
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A766F4D2BB;
	Fri, 14 May 2010 12:08:14 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <20100514060612.GA19652@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147096>

Jeff King venit, vidit, dixit 14.05.2010 08:06:
> On Thu, May 13, 2010 at 04:24:34PM +0200, Michael J Gruber wrote:
> 
>> This series introduces --lrbranches and --locals as abbreviations
>> for "HEAD --branches --remotes" (local and remote branches) resp.
>> "HEAD --branches --tags" (local refs).
> 
> Thanks. --lrbranches is still a little ugly to me, but it does address
> my concern with --heads, and I don't have a better suggestion.
> 
> Patch 4/4 itself looks OK. Did you test each part of the series
> independently, though? It looks like 3/4 tests --lrbranches, which isn't
> introduced until 4/4.

Sheesh. I did test them individually, of course. That is, before
reordering with rebase -i and "fixup!"ing the last one. I probably
squashed them in the wrong order :(

I always get confused by the ordering in the action script, which is
just the reverse of git log --oneline.

I'm sorry I didn't catch this myself, I'll rerebase-eee asap.

Michael
