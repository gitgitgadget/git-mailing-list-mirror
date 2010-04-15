From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Building Git on Tru64
Date: Thu, 15 Apr 2010 16:04:23 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004151603290.7232@xanadu.home>
References: <1271358589.19032.1370170305@webmail.messagingengine.com>
 <r2n81b0412b1004151229g6fe840a1v23a9d06f72e8d36a@mail.gmail.com>
 <1271360809.25304.1370186353@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: "Daniel Richard G." <skunk@iSKUNK.ORG>
X-From: git-owner@vger.kernel.org Thu Apr 15 22:04:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2VId-0000G4-TB
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 22:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756546Ab0DOUEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 16:04:25 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53972 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756530Ab0DOUEY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 16:04:24 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L0X00MB0P3BKD10@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 15 Apr 2010 16:04:24 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <1271360809.25304.1370186353@webmail.messagingengine.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145020>

On Thu, 15 Apr 2010, Daniel Richard G. wrote:

> On Thu, 2010 Apr 15 21:29+0200, Alex Riesen wrote:
> >
> > That one may be better handled at one place (git-compat-util.h?) with
> > something like:
> >
> >   #ifdef Tru64
> >   #define MAP_FAILED ((void *)MAP_FAILED)
> >   #endif
> 
> I agree with the sentiment, but you can't have a macro refer to itself
> :]

you may undefine and redefine it appropriately instead.


Nicolas
