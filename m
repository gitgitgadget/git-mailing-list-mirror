From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] git-svn: ignore changeless commits when checking
	for a cherry-pick
Date: Thu, 7 Jan 2010 01:50:17 -0800
Message-ID: <20100107095016.GA2647@dcvr.yhbt.net>
References: <E10FB265-0C47-44C7-9347-687A9F447603@apple.com> <1262823922-3415-1-git-send-email-amyrick@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sam@vilain.net,
	Andrew Myrick <amyrick@apple.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 10:50:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSp0a-0002LA-HI
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 10:50:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272Ab0AGJuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 04:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135Ab0AGJuT
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 04:50:19 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:35453 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751112Ab0AGJuS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 04:50:18 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C3211F4FA;
	Thu,  7 Jan 2010 09:50:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1262823922-3415-1-git-send-email-amyrick@apple.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136335>

Andrew Myrick <amyrick@apple.com> wrote:
> Update git-svn to ignore commits that do not change the tree when it is
> deciding if an svn merge ticket represents a real branch merge or just a
> cherry-pick.
> 
> Consider the following integration model in the svn repository:
> 
>    F---G  branch1
>   /     \
>  D  tag1 \   E  tag2
> /         \ /
> A---B      C  trunk
> 
> branch1 is merged to trunk in commit C.
> 
> With this patch, git-svn will correctly identify branch1 as a proper merge
> parent, instead of incorrectly ignoring it as a cherry-pick.
> 
> Signed-off-by: Andrew Myrick <amyrick@apple.com>
> ---

Thanks Andrew,

I've added Acks for Sam and myself for this series and pushed out to
git://git.bogomips.org/git-svn:

Andrew Myrick (2):
      git-svn: ignore changeless commits when checking for a cherry-pick
      git-svn: handle merge-base failures

-- 
Eric Wong
