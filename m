From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH] hash: fix lookup_hash semantics
Date: Fri, 22 Feb 2008 23:13:42 +0100
Message-ID: <2A7FA5AD-555E-480F-924F-68BB340E1753@ai.rug.nl>
References: <20080222194726.GA24532@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 23:15:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSgAk-0008TL-8y
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 23:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936233AbYBVWO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 17:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935962AbYBVWO2
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 17:14:28 -0500
Received: from lvps87-230-85-232.dedicated.hosteurope.de ([87.230.85.232]:47299
	"EHLO lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936226AbYBVWO0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Feb 2008 17:14:26 -0500
Received: from s55918ba6.adsl.wanadoo.nl ([85.145.139.166] helo=[192.168.1.11])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1JSg9M-0006DH-NJ; Fri, 22 Feb 2008 23:14:23 +0100
In-Reply-To: <20080222194726.GA24532@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74763>


On Feb 22, 2008, at 8:47 PM, Jeff King wrote:

> This shuts up the valgrind errors I see under Linux; it would be  
> nice to
> get confirmation from OS X people that this fixes their "git status"
> segfaults.

I think my original message may not have come through as it was in  
HTML accidentally.

Anyway, I tested the patch and it works. Thanks!

Tested-by: Pieter de Bie <pdebie@ai.rug.nl>

- Pieter
