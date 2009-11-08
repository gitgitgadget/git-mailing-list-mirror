From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: performance issue: git clone compression
Date: Sat, 07 Nov 2009 22:04:50 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911072155180.16711@xanadu.home>
References: <72877ab10911071657p568b3b98v6fd90e84e098c107@mail.gmail.com>
 <72877ab10911071709s200696d4mf12dc797da20be18@mail.gmail.com>
 <alpine.LFD.2.00.0911072115270.16711@xanadu.home>
 <72877ab10911071845q1c60e2b0kfe6f0509b5728912@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Tim Webster <tdwebste@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 08 04:04:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6y5J-0006hI-Ar
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 04:04:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428AbZKHDEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2009 22:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753403AbZKHDEq
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 22:04:46 -0500
Received: from relais.videotron.ca ([24.201.245.36]:61265 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365AbZKHDEp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2009 22:04:45 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KSR00M4LSK2C5C0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 07 Nov 2009 22:04:51 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <72877ab10911071845q1c60e2b0kfe6f0509b5728912@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132385>

On Sat, 7 Nov 2009, Tim Webster wrote:

> On servers with limit memory it is not piratical to run git gc.
> I can run git gc on a bare mirror and rsync back to the server.

That is fine.  As long as you end up with a single pack, then a clone 
would basically be a sinple file transfer.

Also you might want to investigate the following config variable for a 
low-memory server:

	core.packedGitWindowSize
	core.packedGitLimit
	pack.windowMemory
	pack.deltaCacheSize
	pack.deltaCacheLimit


Nicolas
