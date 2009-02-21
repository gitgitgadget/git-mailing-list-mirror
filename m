From: Nicolas Pitre <nico@cam.org>
Subject: Re: whitespace checking in git-add?
Date: Fri, 20 Feb 2009 21:14:25 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902202109010.5511@xanadu.home>
References: <20090220230454.GA10112@foursquare.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Chris Frey <cdfrey@foursquare.net>
X-From: git-owner@vger.kernel.org Sat Feb 21 03:16:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LahPS-0001MW-S1
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 03:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756249AbZBUCOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 21:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754796AbZBUCOc
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 21:14:32 -0500
Received: from relais.videotron.ca ([24.201.245.36]:55284 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754825AbZBUCOc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 21:14:32 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KFE00EVY8W1AUB0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 20 Feb 2009 21:14:25 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090220230454.GA10112@foursquare.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110923>

On Fri, 20 Feb 2009, Chris Frey wrote:

> Hi,
> 
> Is it possible to somehow enable whitespace checking during git-add?
> In my searches, I can only seem to find mention of it in git-diff.

One thing you can do is:

 1) 'git add' and 'git commit' as usual

 2) run 'git rebase -f --whitespace=fix HEAD~'


Nicolas
