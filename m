From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Mon, 11 Feb 2008 11:13:59 +0100
Message-ID: <47B01FE7.8010207@op5.se>
References: <200802081828.43849.kendy@suse.cz> <m3ejbngtnn.fsf@localhost.localdomain> <9e4733910802081126r5bf19c95rec817a1b6648ee4d@mail.gmail.com> <alpine.LFD.1.00.0802081457170.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jon Smirl <jonsmirl@gmail.com>, Jakub Narebski <jnareb@gmail.com>,
	Jan Holesovsky <kendy@suse.cz>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 11:14:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOVgb-0003Uq-Ov
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 11:14:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbYBKKOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 05:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbYBKKOJ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 05:14:09 -0500
Received: from mail.op5.se ([193.201.96.20]:51897 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949AbYBKKOI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 05:14:08 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 0037A1F08843;
	Mon, 11 Feb 2008 11:14:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 05gTXmCDk4lJ; Mon, 11 Feb 2008 11:14:06 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 836071F08841;
	Mon, 11 Feb 2008 11:14:03 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <alpine.LFD.1.00.0802081457170.2732@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73501>

Nicolas Pitre wrote:
> On Fri, 8 Feb 2008, Jon Smirl wrote:
> 
>> There are some patches for making repack work multi-core. Not sure if
>> they made it into the main git tree yet.
> 
> Yes, they are.  You need to compile with"make THREADED_DELTA_SEARCH=yes" 
> or add THREADED_DELTA_SEARCH=yes into config.mak for it to be enabled 
> though.  Then you have to set the pack.threads configuration variable 
> appropriately to use it.
> 

I sent a patch to get it to auto-detect multi-core machines, but I see
now that it was commented upon for finalization (by Nicolas, actually)
and I must have missed that, thinking it had been applied because I got
an accidental merge in my own tree.

As such, I've been using that patch the last several months without
problems. I'll rework them as per Nicolas' suggestions and resend.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
