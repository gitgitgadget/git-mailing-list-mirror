From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Add --no-reuse-delta, --window,
 and --depth options to git-gc
Date: Mon, 07 May 2007 23:13:58 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705072305270.24220@xanadu.home>
References: <E1HlFqU-0002ir-GK@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue May 08 05:14:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlGA1-00072n-9T
	for gcvg-git@gmane.org; Tue, 08 May 2007 05:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757AbXEHDON (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 23:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754787AbXEHDON
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 23:14:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:38142 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757AbXEHDOM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 23:14:12 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHP00MDICZC1VA0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 07 May 2007 23:14:00 -0400 (EDT)
In-reply-to: <E1HlFqU-0002ir-GK@candygram.thunk.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46521>

On Mon, 7 May 2007, Theodore Ts'o wrote:

> Sometimes users might want to use more aggressive packing options
> when doing a git-gc.  This allows them to do so without having
> to use the low-level plumbing commands.

The 'git repack' command isn't _that_ low level, is it?  
git-pack-objects is plumbing for sure, but not git-repack?

Especially if you're aware and interested in those options, you won't be 
afraid of 'git repack -a -f -d --window=...".

In the context of "gc", having an option that reads "window" looks a bit 
strange too.

Maybe it's just me...


Nicolas
