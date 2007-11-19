From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH] config: correct and clarify core.*compression documentation
Date: Mon, 19 Nov 2007 10:23:08 -0600
Message-ID: <20071119162307.GI6212@lavos.net>
References: <20071119152853.GH6212@lavos.net> <alpine.LFD.0.99999.0711191049440.19105@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonas Juselius <jonas.juselius@chem.uit.no>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Nov 19 17:23:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu9PF-0000fU-K1
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 17:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213AbXKSQXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 11:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752933AbXKSQXL
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 11:23:11 -0500
Received: from mxsf05.insightbb.com ([74.128.0.75]:38089 "EHLO
	mxsf05.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbXKSQXK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 11:23:10 -0500
X-IronPort-AV: E=Sophos;i="4.21,437,1188792000"; 
   d="scan'208";a="119846806"
Received: from unknown (HELO asav00.insightbb.com) ([172.31.249.124])
  by mxsf05.insightbb.com with ESMTP; 19 Nov 2007 11:23:09 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAG9HQUdKhvkY/2dsb2JhbACBWA
X-IronPort-AV: E=Sophos;i="4.21,437,1188792000"; 
   d="scan'208";a="134543442"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav00.insightbb.com with ESMTP; 19 Nov 2007 11:23:08 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 8C3BB309F21; Mon, 19 Nov 2007 10:23:08 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.99999.0711191049440.19105@xanadu.home>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65460>

On Mon, Nov 19, 2007 at 10:51:31AM -0500, Nicolas Pitre wrote:
> > * Explain that the default of core.compression is -1, zlib default, and
> >   add a quote from zlib.h explaining what that actually means.
> 
> No, this is wrong.  core.compression has no default.  It is meaningful 
> only when an explicit value is configured.

Would you prefer this?

       If not set, packs will be compressed to the zlib default level,
       which is "a default compromise between speed and compression
       (currently equivalent to level 6)."

I'm trying to make it reassuring as to the fact that, "yes, packs are
compressed plenty, you really don't need to mess with this unless you
want to."  As it stands I could see the potential confusion that no
(or poor) compression will occur in packs unless this is set.

-bcd
