From: Nicolas Pitre <nico@cam.org>
Subject: Re: git pull failure, truncated object
Date: Tue, 08 May 2007 11:41:14 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705081140000.24220@xanadu.home>
References: <17984.35097.568689.482933@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue May 08 17:49:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlRwa-0000Iz-Eb
	for gcvg-git@gmane.org; Tue, 08 May 2007 17:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934572AbXEHPqL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 11:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755610AbXEHPpr
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 11:45:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:48605 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934347AbXEHPl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 11:41:27 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHQ007FTBKQFYE0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 08 May 2007 11:41:15 -0400 (EDT)
In-reply-to: <17984.35097.568689.482933@lisa.zopyra.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46594>

On Tue, 8 May 2007, Bill Lear wrote:

> He did a git-gc, twice, and retried.  Still failed.
> 
> So, he called me in and we tried to see if the server was acting up
> --- perhaps an NFS problem, as we've had those before, but got very
> different error messages.  Watched the log file from git-daemon, and
> saw nothing.  Finally we took a look at the local repos
> .git/objects/4b, and 4b93eb81265ea4f2b436618a4b1c3bea2bedf06d was of
> length 0.
> 
> So, I looked in the man page of git-gc and thought to try --prune,
> as this was not an active repository.  This worked, and then
> the pull did as well.
> 
> I'm wondering why git-gc did not at least warn us of this problem when
> we tried it.  It appeared to us that git-gc gave our repo a clean bill
> of health, and so we turned our attention to the remote and
> investigated there, instead of continuing in the local repo.

git-gc != git-fsck.


Nicolas
