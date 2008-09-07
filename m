From: David Brown <git@davidb.org>
Subject: Re: rsync vs. git-push/pull ? (+kudus)
Date: Sun, 7 Sep 2008 00:38:21 -0700
Message-ID: <20080907073821.GA28289@linode.davidb.org>
References: <dfb262380809062311i3fffb900m5d73f5396b403dbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Ramagudi Naziir <naziirr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 09:39:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcErr-0003MA-Uy
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 09:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446AbYIGHiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 03:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752500AbYIGHiW
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 03:38:22 -0400
Received: from linode.davidb.org ([72.14.176.16]:53099 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752406AbYIGHiW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 03:38:22 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1KcEqj-0007UI-G6; Sun, 07 Sep 2008 00:38:21 -0700
Content-Disposition: inline
In-Reply-To: <dfb262380809062311i3fffb900m5d73f5396b403dbe@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95123>

On Sun, Sep 07, 2008 at 09:11:47AM +0300, Ramagudi Naziir wrote:

>I really prefer rsync to git-push/pull since it is much more easier -
>It's one command that syncs my whole working folder, including the git
>repositories..

I used to do this quite a bit until after a few times I forgot to sync
before changing things.  I solved this by creating a bare repo I could
push/pull from, and pushing one of them to it, then fetching and
merging in the other.

After getting more familiar with git, I now use git with push/pull for
pretty much anything I want synchronized.  It nicely keeps track of
what I've done, whereas it is easier with rsync, or even unison, to
forget to do the sync.

David
