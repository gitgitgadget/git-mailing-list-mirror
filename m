From: Guido Ostkamp <git@ostkamp.fastmail.fm>
Subject: Re: [PATCH] Fix Solaris compiler warnings
Date: Fri, 16 Nov 2007 23:52:01 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711162346270.7281@bianca.dialin.t-online.de>
References: <Pine.LNX.4.64.0711152317140.7416@bianca.dialin.t-online.de>
 <20071115230002.GA24069@steel.home> <7v1war3xrq.fsf@gitster.siamese.dyndns.org>
 <20071116074850.GA3400@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 23:53:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItA4Q-0007XY-LR
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 23:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757402AbXKPWwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 17:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756649AbXKPWwJ
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 17:52:09 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52006 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756080AbXKPWwI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Nov 2007 17:52:08 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id E8B154859E;
	Fri, 16 Nov 2007 17:52:06 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 16 Nov 2007 17:52:06 -0500
X-Sasl-enc: zAKxQpX18obxf9CM8j1ELg23gDiOlMEuVud8wCEDovFj 1195253526
Received: from [192.168.2.101] (p549A0232.dip0.t-ipconnect.de [84.154.2.50])
	by mail.messagingengine.com (Postfix) with ESMTP id D4B2C2A858;
	Fri, 16 Nov 2007 17:52:05 -0500 (EST)
In-Reply-To: <20071116074850.GA3400@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65252>

On Fri, 16 Nov 2007, Alex Riesen wrote:
> Hmm... Guido, I owe you an appology.

accepted ;-)

> Still, consider this patch instead (it does not fix the return in 
> xdiff/xdiffi.c though):

If your intention is to have a final 'return' statement for stupid 
compilers, this should work (though I haven't verified it on a live system 
I think it looks reasonably well).

Are you going to include it?

What about the xdiff/xdiffi.c problem that should also be solved?

Regards

Guido
