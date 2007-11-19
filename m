From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] config: correct and clarify core.*compression documentation
Date: Mon, 19 Nov 2007 11:43:56 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711191139240.19105@xanadu.home>
References: <20071119152853.GH6212@lavos.net>
 <alpine.LFD.0.99999.0711191049440.19105@xanadu.home>
 <20071119162307.GI6212@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonas Juselius <jonas.juselius@chem.uit.no>
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Mon Nov 19 17:45:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu9js-0000ec-Eg
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 17:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbXKSQob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 11:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752990AbXKSQob
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 11:44:31 -0500
Received: from relais.videotron.ca ([24.201.245.36]:44876 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342AbXKSQoa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 11:44:30 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JRR00G48IH861S0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 19 Nov 2007 11:43:57 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071119162307.GI6212@lavos.net>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65462>

On Mon, 19 Nov 2007, Brian Downing wrote:

> On Mon, Nov 19, 2007 at 10:51:31AM -0500, Nicolas Pitre wrote:
> > > * Explain that the default of core.compression is -1, zlib default, and
> > >   add a quote from zlib.h explaining what that actually means.
> > 
> > No, this is wrong.  core.compression has no default.  It is meaningful 
> > only when an explicit value is configured.
> 
> Would you prefer this?
> 
>        If not set, packs will be compressed to the zlib default level,
>        which is "a default compromise between speed and compression
>        (currently equivalent to level 6)."

This is still rather incorrect.  If you want to be thorough, you should 
say that this setting provides a global default for pack.compression and 
core.loosecompression when those settings are not set.  Otherwise 
pack.compression and core.loosecompression have a default of their own 
when neither is set.


Nicolas
