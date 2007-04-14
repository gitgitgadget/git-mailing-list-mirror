From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: GIT and the current -stable
Date: Sat, 14 Apr 2007 10:19:08 -0700
Message-ID: <20070414171908.GU10574@sequoia.sous-sol.org>
References: <46206842.80203@gmail.com> <20070414083410.GU6602@sequoia.sous-sol.org> <5A4D6434-3DF2-4CC7-B363-260E5F945F72@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Wright <chrisw@sous-sol.org>,
	Rene Herman <rene.herman@gmail.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>, git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 19:19:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcluL-0003Ex-O0
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 19:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243AbXDNRTZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 13:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754244AbXDNRTZ
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 13:19:25 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:35619 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754242AbXDNRTY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 13:19:24 -0400
Received: from sous-sol.org (localhost.localdomain [127.0.0.1])
	by sous-sol.org (8.13.8/8.13.7) with ESMTP id l3EHJ910022442;
	Sat, 14 Apr 2007 10:19:09 -0700
Received: (from chrisw@localhost)
	by sous-sol.org (8.13.8/8.13.7/Submit) id l3EHJ8Vb022439;
	Sat, 14 Apr 2007 10:19:08 -0700
Content-Disposition: inline
In-Reply-To: <5A4D6434-3DF2-4CC7-B363-260E5F945F72@silverinsanity.com>
User-Agent: Mutt/1.4.2.2i
X-Spam-Status: No, score=-2.4 required=5.0 tests=AWL,BAYES_00,
	UNPARSEABLE_RELAY autolearn=ham version=3.1.4
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	sequoia.sous-sol.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44461>

* Brian Gernhardt (benji@silverinsanity.com) wrote:
> On Apr 14, 2007, at 4:34 AM, Chris Wright wrote:
> >I've already put a tree like this up on kernel.org.  The master branch
> >is Linus' tree, and there's branches for each of the stable releases
> >called linux-2.6.[12-20].y (I didn't add 2.6.11.y).
> >
> >http://git.kernel.org/?p=linux/kernel/git/stable/linux-2.6-stable.git;a=summary
> 
> Is HEAD for that repo the most recent stable branch, or (as gitweb  
> makes it look) Linus's head.  I'd expect a "-stable" repo to point at  
> the most recent stable commit, not the most recent development  
> commit.  And I'd also expect gitweb's summary page to show the  
> shortlog for HEAd.  One of my assumptions are being broken and I  
> don't like it.  It leaves me all confused...

As I mentioned.  The master branch (HEAD) is Linus' tree, and each
stable tree is on its own branch.  You'll find shortlog summarizes the
main branch, so yes, gitweb's summary is a bit confusing based on your
assumptions.  This is a new tree and hasn't been publicized until now.
It does make sense to have its head be the newest stable, I'll switch
that around.

thanks,
-chris
