From: Dave Kleikamp <shaggy@austin.ibm.com>
Subject: Re: [git pull] jfs update
Date: Wed, 04 May 2005 17:05:24 -0500
Message-ID: <1115244324.8279.72.camel@localhost>
References: <20050504204744.DA0A0849AD@kleikamp.dyn.webahead.ibm.com>
	 <Pine.LNX.4.58.0505041437060.2328@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 23:59:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTRtf-0004Y5-Un
	for gcvg-git@gmane.org; Wed, 04 May 2005 23:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVEDWFg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 18:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVEDWFg
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 18:05:36 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:30959 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261797AbVEDWF3
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 4 May 2005 18:05:29 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e35.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j44M5QT9155812
	for <git@vger.kernel.org>; Wed, 4 May 2005 18:05:27 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j44M5Qmf367420
	for <git@vger.kernel.org>; Wed, 4 May 2005 16:05:26 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j44M5PtO028995
	for <git@vger.kernel.org>; Wed, 4 May 2005 16:05:25 -0600
Received: from kleikamp.austin.ibm.com (dyn95390155.austin.ibm.com [9.53.90.155])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j44M5Pg5028985;
	Wed, 4 May 2005 16:05:25 -0600
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505041437060.2328@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

cc'ing the git mailing list, dropping linux-kernel

On Wed, 2005-05-04 at 14:37 -0700, Linus Torvalds wrote:
> 
> On Wed, 4 May 2005, Dave Kleikamp wrote:
> >
> > I think I've got this set up right.  I have created a HEAD-for-linus and
> > HEAD-for-mm in the same git repo.
> 
> Ok, my scripts don't handle that very well yet (they just want HEAD), but 
> that was easy enough to hack around. I'll be able to work with that 
> format.

After looking at the documentation and playing around, I'm wondering if
I should instead have created jfs-2.6.git/refs/heads/for-linus.  Then
the url would be:
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git#for-linus

I think this currently works.  Which would be the preferred format?

> 
> > Please pull from
> > 
> > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git/HEAD-for-linus
> 
> Pulled, and pushed out.
> 
> 		Linus
-- 
David Kleikamp
IBM Linux Technology Center

