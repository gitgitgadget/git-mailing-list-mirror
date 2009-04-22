From: Andy Lester <andy@petdance.com>
Subject: Re: Removing duplicated code between builtin-send-pack.c and transport.c
Date: Wed, 22 Apr 2009 14:06:22 -0500
Message-ID: <FF499E4E-B2F1-4795-B9F9-AD73CDDE417A@petdance.com>
References: <09511913-0ED3-41C0-A4F0-9F2D452C00D7@petdance.com> <alpine.LNX.1.00.0904221407160.10753@iabervon.org> <20090422190337.GA13424@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:08:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwhnd-0007eb-F1
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 21:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756437AbZDVTG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 15:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756761AbZDVTGY
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 15:06:24 -0400
Received: from huggy.petdance.com ([72.14.176.61]:56542 "EHLO
	huggy.petdance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756105AbZDVTGY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 15:06:24 -0400
Received: from alester.flr.follett.com (host3130.follett.com [12.47.12.130])
	by huggy.petdance.com (Postfix) with ESMTP id 56FEB22DE74;
	Wed, 22 Apr 2009 15:06:23 -0400 (EDT)
In-Reply-To: <20090422190337.GA13424@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117230>


On Apr 22, 2009, at 2:03 PM, Jeff King wrote:

> I think Andy was referring to (2), and I think that should be cleaned
> up, as the different versions have a tendency to diverge. Probably
> addressing (1) by moving send_pack() to transport.c makes sense as  
> part
> of the same cleanup.


Yes, exactly.  I was applying const to function parameters in builtin- 
send-pack.c, and discovered the duplication.  I sure don't want to  
patch twice if we don't need to.

So it sounds like what I'll do is start a send-pack.c and hoist out  
the common functions from builtin-send-pack.c and transport.c.

xoxo,
Andy

--
Andy Lester => andy@petdance.com => www.theworkinggeek.com => AIM:petdance
