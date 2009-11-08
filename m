From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: performance issue: git clone compression
Date: Sat, 07 Nov 2009 21:17:32 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911072115270.16711@xanadu.home>
References: <72877ab10911071657p568b3b98v6fd90e84e098c107@mail.gmail.com>
 <72877ab10911071709s200696d4mf12dc797da20be18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Tim Webster <tdwebste@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 08 03:17:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6xLW-0004AG-Ke
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 03:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920AbZKHCR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2009 21:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752826AbZKHCR1
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 21:17:27 -0500
Received: from relais.videotron.ca ([24.201.245.36]:18541 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbZKHCR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2009 21:17:27 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KSR00HMUQD8DH90@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 07 Nov 2009 21:17:32 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <72877ab10911071709s200696d4mf12dc797da20be18@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132383>

On Sat, 7 Nov 2009, Tim Webster wrote:

> git clone gitosis@gitserver:code.git
> 
> After remote counting objects, remote compressing objects
> transfer begins...
> This compression operation results in excess of swapage on the remote server.
> 
> --------------------
> 
> I need to avoiding the clone compression step for servers with limited memory.

Make sure the remote repository is fully packed.  To do so, just go into
the remote repository and run 'git gc'.


Nicolas
