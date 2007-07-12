From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 0/5] Memory-limited pack-object window support
Date: Thu, 12 Jul 2007 00:38:27 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707120036200.32552@xanadu.home>
References: <11842100581060-git-send-email-bdowning@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Thu Jul 12 06:38:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8qRj-0000Hj-Gk
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 06:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbXGLEi2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 00:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbXGLEi2
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 00:38:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20404 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbXGLEi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 00:38:27 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JL100NCKU832SD0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 12 Jul 2007 00:38:27 -0400 (EDT)
In-reply-to: <11842100581060-git-send-email-bdowning@lavos.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52244>

On Wed, 11 Jul 2007, Brian Downing wrote:

> This patch series implements a memory limit on the window size for
> pack-objects and repack.  Basically, the window size will temporarily
> grow smaller than the --window option specifies if the total memory
> usage of the window is over the specified limit.

Besides the small issues I've pointed out already, I think this is a 
very good thing.


Nicolas
