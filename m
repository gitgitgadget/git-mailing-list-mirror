From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-fast-import
Date: Mon, 05 Feb 2007 22:18:46 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702052211360.19212@xanadu.home>
References: <20070206023111.GB9222@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 06 04:18:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEGr7-0008HR-5u
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 04:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965244AbXBFDSs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 22:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965251AbXBFDSs
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 22:18:48 -0500
Received: from relais.videotron.ca ([24.201.245.36]:21109 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965244AbXBFDSr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 22:18:47 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JD0004FAUJAL851@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 05 Feb 2007 22:18:47 -0500 (EST)
In-reply-to: <20070206023111.GB9222@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38806>

On Mon, 5 Feb 2007, Shawn O. Pearce wrote:

> When exactly we merge it in will depend a lot on Junio.  It should
> be safe to merge before 1.5.0 as its strictly new source files,
> but we may still want to wait until after 1.5.0 is out.

For that reason I think it should go in now.

> I'm mainly worried about breaking compliation on odd architectures.

Well, if it doesn't build then just don't make it a fatal build error.  
That won't be worse than not having it included at all.
And if it compiles then consider it as a bonus!


Nicolas
