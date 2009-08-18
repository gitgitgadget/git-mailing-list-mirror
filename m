From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH v2] remove ARM and Mozilla SHA1 implementations
Date: Tue, 18 Aug 2009 08:42:53 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908180841400.6044@xanadu.home>
References: <alpine.LFD.2.00.0908171940540.6044@xanadu.home>
 <alpine.LFD.2.00.0908172007590.6044@xanadu.home>
 <20090818054913.GB37966@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 14:43:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdO24-0001Kg-7c
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 14:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbZHRMnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 08:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbZHRMnK
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 08:43:10 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37365 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbZHRMnK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 08:43:10 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOK00AG6O4TL450@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 18 Aug 2009 08:31:41 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090818054913.GB37966@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126387>

On Mon, 17 Aug 2009, David Aguilar wrote:

> 
> On Mon, Aug 17, 2009 at 08:09:56PM -0400, Nicolas Pitre wrote:
> > 
> >  Makefile            |   26 +------
> >
> > -ifneq (,$(findstring arm,$(uname_M)))
> > -	ARM_SHA1 = YesPlease
> > -	NO_MKSTEMPS = YesPlease
> > -endif
> 
> When I added NO_MKSTEMPS I was being conservative when defining
> it on arm (I wasn't able to test that platform).
> Looks like it wasn't needed afterall.

It is a Linux platform after all, which is already taken care of.


Nicolas
