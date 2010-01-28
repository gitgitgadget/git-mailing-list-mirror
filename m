From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Questions about branches in git
Date: Thu, 28 Jan 2010 17:04:36 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001281656440.1681@xanadu.home>
References: <69b754db1001281044y39e52f77hcc8f83144776c78f@mail.gmail.com>
 <b4087cc51001281203q1f467480sdf848c9d3ced323b@mail.gmail.com>
 <69b754db1001281317o69f8c3f9y412a8524407bacbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Mike Linck <mgl@absolute-performance.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 23:05:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NacTz-0001rY-HK
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 23:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428Ab0A1WEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 17:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703Ab0A1WEj
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 17:04:39 -0500
Received: from relais.videotron.ca ([24.201.245.36]:34707 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932161Ab0A1WEi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 17:04:38 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KWZ00L4B9BOWI50@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 28 Jan 2010 17:04:37 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <69b754db1001281317o69f8c3f9y412a8524407bacbf@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138277>

On Thu, 28 Jan 2010, Mike Linck wrote:

> Well, even gitk can't show me the information I'm looking for if the
> parent branch ended up fast-forwarding to include the changes made in
> the topic branch.  As far as I can tell there is *no way* to tell what
> changes were made in a particular branch after a fast-forward has
> taken place, which seems to make it hard to organize fixes for
> specific topics/bugs/tickets.

You should consider using tags in conjunction with your bugs/tickets 
system.  The fork point for a bug fix may be tagged, as well as the last 
commit representing the bugfix completion (not the merge point though).  
This way you can always retrieve the exact set of commits forming up 
that bugfix, regardless if it was merged back into the main branch with 
a fast forward or not.


Nicolas
