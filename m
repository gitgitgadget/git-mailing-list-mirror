From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] git-repack: generational repacking (and example hook
 script)
Date: Wed, 04 Jul 2007 18:16:34 +1200
Message-ID: <468B3B42.2040103@vilain.net>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz> <11831937813223-git-send-email-sam.vilain@catalyst.net.nz> <11831937822346-git-send-email-sam.vilain@catalyst.net.nz> <11831937823184-git-send-email-sam.vilain@catalyst.net.nz> <11831937823982-git-send-email-sam.vilain@catalyst.net.nz> <1183193782172-git-send-email-sam.vilain@catalyst.net.nz> <11831937822249-git-send-email-sam.vilain@catalyst.net.nz> <11831937823756-git-send-email-sam.vilain@catalyst.net.nz> <11831937822950-git-send-email-sam.vilain@catalyst.net.nz> <11831937823588-git-send-email-sam.vilain@catalyst.net.nz> <1183193782608-git-send-email-sam.vilain@catalyst.net.nz> <alpine.LFD.0.999.0707022331080.26459@xanadu.home> <4689D77D.20601@vilain.net> <alpine.LFD.0.999.0707031020300.26459@xanadu.home> <468AE462.1040202@vilain.net> <Pine.LNX.4.64.0707040155240.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 04 08:16:57 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5yAR-0001Hd-B3
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 08:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346AbXGDGQp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 02:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752868AbXGDGQp
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 02:16:45 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:53425 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbXGDGQo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 02:16:44 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id EE11713A4F0; Wed,  4 Jul 2007 18:16:41 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id CB05B13A400;
	Wed,  4 Jul 2007 18:16:36 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <Pine.LNX.4.64.0707040155240.4071@racer.site>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51572>

Johannes Schindelin wrote:
>>>> 1. Do you agree that some users would want their git repositories to be
>>>> "maintenance free"?
>>> I'm not so sure.
>> Well, no offence, but I think you should withhold from voicing a
>> fundamental concern as this, because you're not one of its target users.
> Let's put it this way. A lot of car drivers would probably agree that it 
> is a Good Thing (tm) if their car automatically went to get gas, before it 
> ran out of it. Less hassle, right?
> 
> Yes, except if your car decides to get gas when you are already late, 
> speeding, trying to catch your plane.

Ok, but if you're only packing a few hundred objects it usually won't
matter because it is fast enough that you hardly notice.

And if you don't like it, you turn it off, or don't turn it on.

Sam.
