From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current
 branch reflog
Date: Thu, 01 Feb 2007 17:12:52 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702011710120.3021@xanadu.home>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home>
 <20070201191323.GA18608@spearce.org> <7vmz3xoas9.fsf@assigned-by-dhcp.cox.net>
 <45C25BA6.1000301@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Thu Feb 01 23:13:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCkAt-0004th-R8
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 23:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbXBAWMy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 17:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbXBAWMy
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 17:12:54 -0500
Received: from relais.videotron.ca ([24.201.245.36]:63213 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbXBAWMx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 17:12:53 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCT007201PG10B0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 01 Feb 2007 17:12:52 -0500 (EST)
In-reply-to: <45C25BA6.1000301@fs.ei.tum.de>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38415>

On Thu, 1 Feb 2007, Simon 'corecode' Schubert wrote:

> I don't know how people are used to type HEAD@{..}, but why not:
> 
> 1.  have .@{..} or @@{..} for "the current branch i am on" and have HEAD@{..}
> behave like nicolas is aiming to do.

I really like "@{...}" to mean whatever branch I'm on.  Given that it 
has no real name it can happily change meaning with branch switches.


Nicolas
