From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 0/2] diff-tree/diff-cache helper
Date: Mon, 25 Apr 2005 22:08:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0504252159590.26129@localhost.localdomain>
References: <Pine.LNX.4.58.0504232202340.19877@ppc970.osdl.org>
 <7v1x8zsamn.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504251832480.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 04:03:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQFQT-00051j-F4
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 04:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVDZCIZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 22:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVDZCIZ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 22:08:25 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36486 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261256AbVDZCIL
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 22:08:11 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR010.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IFJ007H679JM0@VL-MO-MR010.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 25 Apr 2005 22:08:07 -0400 (EDT)
In-reply-to: <Pine.LNX.4.58.0504251832480.18901@ppc970.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 25 Apr 2005, Linus Torvalds wrote:

> This also makes me think that we should just make "show-diff" show the
> same format, at which point show-diff actually matches all the other
> tools, and it is likely to make show-diff more useful to boot.
> 
> The thing I personally use "show-diff" for these days is actually just to
> check whether I have anything dirty in my tree, and then it would actually
> be preferable to just get the filenaname printout (in the same old
> "diff-cache" format) rather than the full diff.

That makes a lot of sense.  And I think that path filtering in diff-tree 
should be factored out and supported into all of the diff-* commands as 
well (not necessarily in diff-tree-helper).


Nicolas
