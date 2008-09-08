From: Scott Wood <scottwood@freescale.com>
Subject: Re: git apply vs. renamed files index mismatch
Date: Mon, 08 Sep 2008 16:38:57 -0500
Message-ID: <48C59B71.3040902@freescale.com>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com> <1220900995-11928-2-git-send-email-becky.bruce@freescale.com> <48C57A92.6060608@freescale.com> <20080908212717.GA21338@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Becky Bruce <becky.bruce@freescale.com>, linuxppc-dev@ozlabs.org,
	git@vger.kernel.org
To: avorontsov@ru.mvista.com
X-From: git-owner@vger.kernel.org Mon Sep 08 23:41:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcoUG-0000bI-2h
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 23:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203AbYIHVk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 17:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754199AbYIHVkZ
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 17:40:25 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:40381 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892AbYIHVkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 17:40:25 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m88Le9C5010419;
	Mon, 8 Sep 2008 14:40:10 -0700 (MST)
Received: from [10.82.16.68] (udp110651uds.am.freescale.net [10.82.16.68])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m88Le9Ta019649;
	Mon, 8 Sep 2008 16:40:09 -0500 (CDT)
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <20080908212717.GA21338@oksana.dev.rtsoft.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95307>

Anton Vorontsov wrote:
> I always thought that posting "-M" patches to the public lists is
> discouraged since it is quite difficult to apply them via patch(1).
> Also think of non-git users...

I think the substantially enhanced reviewability trumps non-git-users 
who can follow the rename instructions manually (or fix up their patch 
utility) if they insist on shunning tools that would make their life easier.

> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
> new file mode 100644
> index 0000000..ae5708e
> [...]
> diff --git a/arch/powerpc/kernel/dma_64.c b/arch/powerpc/kernel/dma_64.c
> deleted file mode 100644
> index ae5708e..0000000
> 
> That is, if hashes match then it was pure rename.

I suppose, though it's not as easy to spot, and won't help in showing 
what the differences are if there are any.

-Scott
