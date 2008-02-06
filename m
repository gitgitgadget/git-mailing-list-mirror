From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] git-rebase.sh: Change .dotest directory to .git-dotest
Date: Tue, 05 Feb 2008 20:37:50 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802052031240.2732@xanadu.home>
References: <ve53xwob.fsf@blue.sea.net>
 <alpine.LSU.1.00.0802051524580.8543@racer.site> <prvbxfhl.fsf@blue.sea.net>
 <alpine.LFD.1.00.0802051334070.3110@woody.linux-foundation.org>
 <alpine.LSU.1.00.0802052236220.8543@racer.site>
 <1202253890.26144.8.camel@gaara.boston.redhat.com>
 <alpine.LSU.1.00.0802060053570.8543@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 06 02:38:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMZFG-0000Ep-WA
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 02:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757621AbYBFBh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 20:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759362AbYBFBh5
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 20:37:57 -0500
Received: from relais.videotron.ca ([24.201.245.36]:46891 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757600AbYBFBh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 20:37:56 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JVS00GTUN72TI60@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 05 Feb 2008 20:37:51 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LSU.1.00.0802060053570.8543@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72744>

On Wed, 6 Feb 2008, Johannes Schindelin wrote:

> So yes, it is an implementation detail.  But one that we could not 
> _possibly_ hide.
> 
> What's so wrong with using a symlink first, trying hard not to break 
> peoples' assumptions, then tell them that they should change their scripts 
> (which they can do lazily now, since both .dotest/ _and_ .git/rebase/ 
> are valid)?
> 
> How is being nice to people wrong?

Johannes,

Why don't you simply manually add the symlink to your repo, or better 
yet, fix your script?

I don't think many people will think they've been screwed just because 
this .dotest directory has moved, since not so many people might be 
relying on it.  And for those who do, well they certainly have the 
knowledge to help themselves out of this very complicated matter.  ;-)

So I'd suggest simply moving it and see if other people, if any, start 
screaming.


Nicolas
