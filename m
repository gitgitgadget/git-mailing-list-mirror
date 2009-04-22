From: Andy Lester <andy@petdance.com>
Subject: Re: Removing duplicated code between builtin-send-pack.c and transport.c
Date: Wed, 22 Apr 2009 14:13:28 -0500
Message-ID: <ADA21A9C-96E3-4441-B925-5B623433F42E@petdance.com>
References: <09511913-0ED3-41C0-A4F0-9F2D452C00D7@petdance.com> <alpine.LNX.1.00.0904221407160.10753@iabervon.org> <20090422190337.GA13424@coredump.intra.peff.net> <FF499E4E-B2F1-4795-B9F9-AD73CDDE417A@petdance.com> <20090422191044.GC13424@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:16:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwhvP-0002Lg-RJ
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 21:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbZDVTN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 15:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753887AbZDVTN3
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 15:13:29 -0400
Received: from huggy.petdance.com ([72.14.176.61]:59243 "EHLO
	huggy.petdance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084AbZDVTN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 15:13:29 -0400
Received: from alester.flr.follett.com (host3130.follett.com [12.47.12.130])
	by huggy.petdance.com (Postfix) with ESMTP id 79C0B22DE75;
	Wed, 22 Apr 2009 15:13:28 -0400 (EDT)
In-Reply-To: <20090422191044.GC13424@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117234>


On Apr 22, 2009, at 2:10 PM, Jeff King wrote:

> I don't know if that is quite appropriate. I think the point of moving
> many of the duplicated functions into transport.c is that they are  
> used
> by other transports, like http. So probably the transport-agnostic  
> ones
> should stay in transport.c, and they should all get called in the same
> way, no matter what the transport.


My mistake.  I'll remove the code from builtin-send-pack.c, improve  
it, and builtin-send-pack.c can get deprecated when/if anyone wants.

--
Andy Lester => andy@petdance.com => www.theworkinggeek.com => AIM:petdance
