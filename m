From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Teach start_push_anywhere_action{} to notice
	when remote is a mirror.
Date: Tue, 2 Dec 2008 07:30:07 -0800
Message-ID: <20081202153007.GJ23984@spearce.org>
References: <20081202151502.3f30ced4@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Burton <markb@ordern.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 16:31:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7XDi-0003Mu-C3
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 16:31:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754554AbYLBPaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 10:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754550AbYLBPaJ
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 10:30:09 -0500
Received: from george.spearce.org ([209.20.77.23]:55686 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754547AbYLBPaI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 10:30:08 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7508938200; Tue,  2 Dec 2008 15:30:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081202151502.3f30ced4@crow>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102143>

Mark Burton <markb@ordern.com> wrote:
> When the destination repository is a mirror, this function goofed by still
> passing a refspec to git-push. Now it notices that the remote is a mirror
> and holds the refspec.
> 
> Signed-off-by: Mark Burton <markb@ordern.com>

Thanks.

>  This patch stops git-gui from annoying git-push when the remote is a
>  mirror. A further enhancement would be to disable the branch names list
>  in the dialog when the selected destination is a mirror. As it stands, you can
>  select a branch name from the list but it will be ignored (this could possibly
>  confuse/annoy people). But that's a bunch more work so I'm stopping here for
>  now.

Yea, it is a chunk of work.  I thought about trying to do it myself
right now, but realized I won't be able to do it in 15 minutes and
gave up.  :-)

Unfortunately this patch adds a new string to be translated and I've
already made a request for the translators to update their languages,
and several have.  I'll send out another request to let them know
there's this new string; we should have enough time before 1.6.1
goes final.

-- 
Shawn.
