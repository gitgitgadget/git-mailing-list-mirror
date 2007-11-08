From: Andreas Ericsson <ae@op5.se>
Subject: Re: [REPLACEMENT PATCH] git-checkout: Add a test case for relative
 paths use.
Date: Thu, 08 Nov 2007 10:23:53 +0100
Message-ID: <4732D5A9.5040504@op5.se>
References: <11945006082887-git-send-email-dsymonds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 10:24:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq3d7-0000aH-8z
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 10:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759160AbXKHJX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 04:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759887AbXKHJX6
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 04:23:58 -0500
Received: from mail.op5.se ([193.201.96.20]:42292 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759023AbXKHJX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 04:23:57 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 736B61F08709;
	Thu,  8 Nov 2007 10:23:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dvL4-5vxP8XW; Thu,  8 Nov 2007 10:23:32 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 660D71F08706;
	Thu,  8 Nov 2007 10:23:32 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <11945006082887-git-send-email-dsymonds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63976>

David Symonds wrote:
> +'
> +
> +test_expect_failure 'checkout with relative path outside tree should fail (1)' \
> +	'git checkout HEAD - ../file0'
> +
> +test_expect_failure 'checkout with relative path outside tree should fail (2)' \
> +	'cd dir1 && git checkout HEAD - ./file0'
> +
> +test_expect_failure 'checkout with relative path outside tree should fail (2)' \
> +	'cd dir1 && git checkout HEAD - ../../file0'


Single-dashes on all of these?

Looks good otherwise.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
