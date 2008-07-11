From: Theodore Tso <tytso@mit.edu>
Subject: Re: Ext4 patchqueue corrupted ?
Date: Fri, 11 Jul 2008 08:26:17 -0400
Message-ID: <20080711122617.GA8154@mit.edu>
References: <20080711034606.GA779@skywalker> <20080711084715.GT10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	Ming Ming Cao <cmm@us.ibm.com>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jul 11 14:27:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHHis-0003du-I8
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 14:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758010AbYGKM0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 08:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754971AbYGKM0l
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 08:26:41 -0400
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:44515 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757905AbYGKM0i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 08:26:38 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KHHhk-0007Oz-8R; Fri, 11 Jul 2008 08:26:28 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KHHhZ-00057I-E4; Fri, 11 Jul 2008 08:26:17 -0400
Content-Disposition: inline
In-Reply-To: <20080711084715.GT10151@machine.or.cz>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88111>

On Fri, Jul 11, 2008 at 10:47:15AM +0200, Petr Baudis wrote:
>   very puzzling; I have backed up the broken objects store, can you
> repush, please? I'm curious about how this could have happenned;
> repo.or.cz now uses Git from latest next, which is a rather strange
> coincidence. ;-) Or did any of the pushers do anything special about
> pushin to the repository recently?

Aneesh, did you try repushing?  It looks like the objects store is
broken again.

Pasky, in case it helps, and for the benefit of Linux-ext4 folks, I
have a copy of my repository (which I last pushed to repo.or.cz around
noon US/Eastern yesterday) here:

     git://git.kernel.org/pub/scm/fs/ext2/ext4-patch-queue.git

My most recent HEAD is ec90e411; if anyone has something more recent,
they can send it to me via:

     git bundle create /tmp/to-send ec90e411

... and then e-mailing me as an attachment the resulting binary file
in /tmp/to-send.

						- Ted
