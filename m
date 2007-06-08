From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] fsck: do not crash on tag objects which do not contain an
 empty line
Date: Thu, 07 Jun 2007 22:04:22 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706072158160.12885@xanadu.home>
References: <Pine.LNX.4.64.0706072338260.4046@racer.site>
 <200706080108.50042.johan@herland.net>
 <Pine.LNX.4.64.0706080011430.4046@racer.site>
 <200706080128.48637.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Jun 08 04:05:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwTqj-0006rh-W8
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 04:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937564AbXFHCFE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 22:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937539AbXFHCFE
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 22:05:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:11131 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937482AbXFHCFB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 22:05:01 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JJA00GLFOFAQE90@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 07 Jun 2007 22:04:23 -0400 (EDT)
In-reply-to: <200706080128.48637.johan@herland.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49423>

On Fri, 8 Jun 2007, Johan Herland wrote:

> I agree that we should fail gracefully, and my code is clearly not doing 
> that in this case. My bad.
> 
> But the code should also detect invalid tag objects, and in this case I'm 
> not yet convinced that the tag object causing the failure is in fact valid. 
> If someone can convince me that the blank line after headers is optional, 
> then I'll gladly fix the code.

That's irrelevant.

Because you are fed invalid data is no excuse for crashing.

Especially in a tool like fsck, you should _expect_ and cope with 
invalid data. That's why it exists in the first place: to identify such
data.


Nicolas
