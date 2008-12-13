From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] autodetect number of CPUs by default when using threads
Date: Sat, 13 Dec 2008 14:27:04 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812131425540.30035@xanadu.home>
References: <alpine.LFD.2.00.0812111524370.14328@xanadu.home>
 <20081213133238.GA6718@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 13 20:28:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBaA9-0005JF-RI
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 20:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbYLMT1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 14:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbYLMT1M
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 14:27:12 -0500
Received: from relais.videotron.ca ([24.201.245.36]:37152 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbYLMT1L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 14:27:11 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KBT00HUXY14RZ00@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 13 Dec 2008 14:27:05 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081213133238.GA6718@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103013>

On Sat, 13 Dec 2008, Jeff King wrote:

> On Thu, Dec 11, 2008 at 03:36:47PM -0500, Nicolas Pitre wrote:
> 
> > ... and display the actual number of threads used when locally 
> > repacking.  A remote server still won't tell you how many threads it 
> > uses during a fetch though.
> 
> Hrm. I have no idea how, but this patch reliably causes t5300 to fail on
> my FreeBSD test box ("next" is broken, bisection pointed to 43cc2b42).
> Sample verbose output is below.

Hmmm... Interesting.


Nicolas
