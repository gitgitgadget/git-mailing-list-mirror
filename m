From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/2] git-svn: Allow deep branch names by supporting multi-globs
Date: Thu, 7 Aug 2008 02:00:08 -0700
Message-ID: <20080807090008.GA9161@untitled>
References: <489A025C.50507@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Thu Aug 07 14:28:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KR4bE-00074H-9T
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 14:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755691AbYHGM00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 08:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754782AbYHGM0Y
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 08:26:24 -0400
Received: from hand.yhbt.net ([66.150.188.102]:55314 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753772AbYHGMYD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 08:24:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id BAA9A2DC01B;
	Thu,  7 Aug 2008 02:00:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <489A025C.50507@griep.us>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91574>

Marcus Griep <marcus@griep.us> wrote:
> Some repositories use a deep branching strategy, such as:
> branches/1.0/1.0.rc1
> branches/1.0/1.0.rc2
> branches/1.0/1.0.rtm
> branches/1.0/1.0.gold
> 
> Only allowing a single glob stiffles this.
> 
> This change allows for a single glob 'set' to accept this deep branching
> strategy.
> 
> The ref glob depth must match the branch glob depth.  When using the -b or -t
> options for init or clone, this is automatically done.
> 
> For example, using the above branches:
>   svn-remote.svn.branches = branches/*/*:refs/remote/*/*
> gives the following branch names:
>   1.0/1.0.rc1
>   1.0/1.0.rc2
>   1.0/1.0.rtm
>   1.0/1.0.gold

Hi Marcus,

This looks awesome.  Some folks have been wanting to do this for a
long time but I was always too lazy to touch this code.

Unfortunately, I'm having trouble applying your patches due to
whitespace conversion issues with your MUA.  I suggest taking a look at
Documentation/SubmittingPatches on how to submit easily applyable
patches to the mailing list.

I usually use git-send-email myself, but sometimes mutt, too.

Also, there are some long lines that need to be wrapped at
80 characters or less to conform to the existing coding
conventions.

I look forward to applying and testing your patches,

Thank you!

-- 
Eric Wong
