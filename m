From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] git-daemon: Worked around uclibc buffer problem
Date: Thu, 09 Oct 2008 20:16:03 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810092010370.26244@xanadu.home>
References: <20081009213448.GA11204@derf.homelinux.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Lars Stoltenow <penma@derf.homelinux.org>
X-From: git-owner@vger.kernel.org Fri Oct 10 02:17:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko5h5-0006FX-1W
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 02:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbYJJAQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 20:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752740AbYJJAQJ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 20:16:09 -0400
Received: from relais.videotron.ca ([24.201.245.36]:10951 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbYJJAQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 20:16:09 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K8H006AXY2RK4I2@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 09 Oct 2008 20:16:03 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081009213448.GA11204@derf.homelinux.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97906>

On Thu, 9 Oct 2008, Lars Stoltenow wrote:

> uclibc immediately write()s every string argument to fprintf, which causes
> superfluous 'remote: ' strings to appear when cloning repos. This patch
> makes it write the message in one shot.

What is your client version?  From v1.6.0.2 and later (with commit 
6b9c42b4da) this shouldn't matter as things are properly handled on the 
receiving end.


Nicolas
