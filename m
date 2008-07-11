From: Petr Baudis <pasky@suse.cz>
Subject: Re: Ext4 patchqueue corrupted ?
Date: Fri, 11 Jul 2008 10:47:15 +0200
Message-ID: <20080711084715.GT10151@machine.or.cz>
References: <20080711034606.GA779@skywalker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Ming Ming Cao <cmm@us.ibm.com>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	git@vger.kernel.org
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 10:48:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHEId-0003Nv-Dn
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 10:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075AbYGKIrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 04:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753615AbYGKIrU
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 04:47:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37571 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753101AbYGKIrT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 04:47:19 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 6D2402C4C039; Fri, 11 Jul 2008 10:47:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080711034606.GA779@skywalker>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88099>

  Hi,

On Fri, Jul 11, 2008 at 09:16:06AM +0530, Aneesh Kumar K.V wrote:
> [master@ext4-patch-queue]$ git pull
> warning: no common commits
> remote: Total 0 (delta 0), reused 0 (delta 0)
> error: unable to find ec90e41198ede71d186bb7075e2edea7a6daae5a
> fatal: object ec90e41198ede71d186bb7075e2edea7a6daae5a not found
> 
> kvaneesh@skywalker:/tmp$git clone git://repo.or.cz/ext4-patch-queue.git
> Initialized empty Git repository in /tmp/ext4-patch-queue/.git/
> remote: Total 0 (delta 0), reused 0 (delta 0)
> remote: aborting due to possible repository corruption on the remote side.
> error: waitpid (async) failed
> fatal: error in sideband demultiplexer
> 
> The web interface doesn't list any commits.

  very puzzling; I have backed up the broken objects store, can you
repush, please? I'm curious about how this could have happenned;
repo.or.cz now uses Git from latest next, which is a rather strange
coincidence. ;-) Or did any of the pushers do anything special about
pushin to the repository recently?

  Huge amount of objects is missing, the repository has only few loose
objects and

-rw-rw-r-- 1 repo 65657 1408 2008-07-10 18:56 pack-503b8e3e6f3a650c8bc37df88e8a9d7b6193c900.idx
-rw-rw-r-- 1 repo 65657 3364 2008-07-10 18:56 pack-503b8e3e6f3a650c8bc37df88e8a9d7b6193c900.pack

  (By the way, how do I list objects in a pack again? I keep forgetting
the trick...)

-- 
				Petr "Pasky" Baudis
The last good thing written in C++ was the Pachelbel Canon. -- J. Olson
