From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: How to replace a single corrupt, packed object?
Date: Fri, 8 Aug 2008 17:30:19 +0200
Message-ID: <0BF03F86-8E4E-46D2-9B04-4385CEBD6902@ai.rug.nl>
References: <alpine.DEB.1.00.0808081639490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, nico@cam.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 08 17:31:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRTwD-0000fO-4n
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 17:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267AbYHHPaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 11:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752170AbYHHPaa
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 11:30:30 -0400
Received: from frim.nl ([87.230.85.232]:52599 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752120AbYHHPaa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Aug 2008 11:30:30 -0400
Received: from s5591931c.adsl.wanadoo.nl ([85.145.147.28] helo=[192.168.1.11])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1KRTv9-0003az-BT; Fri, 08 Aug 2008 17:30:27 +0200
In-Reply-To: <alpine.DEB.1.00.0808081639490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91682>

On 8 aug 2008, at 16:41, Johannes Schindelin wrote:

> fatal: corrupt packed object for  
> 2c1e128aa51e3a64bd61556c0cd488628b423ccf
> error: failed to run repack
>
> Fortunately, I have the uncorrupted object somewhere else.  So I  
> copy the
> single object as a loose one, and all is fine.  Right?
>
> Wrong.
>
> Repack still picks up the corrupt object instead of the good one.   
> What's
> the best way out?

I don't know how to replace the object, but you can expand the pack,  
replace
the loose file, delete the old pack, and then create a new one, as  
also explained
in this thread:

	http://thread.gmane.org/gmane.comp.version-control.git/40893/focus=40896

- Pieter
