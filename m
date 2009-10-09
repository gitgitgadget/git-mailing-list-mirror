From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: Re: [PATCH 7/9] Documentation: clarify branch creation
Date: Fri, 9 Oct 2009 09:21:51 -0700
Message-ID: <BLU0-SMTP425A9541141B09D790814EAECB0@phx.gbl>
References: <20091009101400.GA16549@progeny.tock>
	<20091009101940.GG16558@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 18:25:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwIHp-0006Nt-8p
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 18:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933826AbZJIQXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 12:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933751AbZJIQXR
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 12:23:17 -0400
Received: from blu0-omc3-s36.blu0.hotmail.com ([65.55.116.111]:48544 "EHLO
	blu0-omc3-s36.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760992AbZJIQXQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Oct 2009 12:23:16 -0400
Received: from BLU0-SMTP42 ([65.55.116.73]) by blu0-omc3-s36.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 9 Oct 2009 09:21:55 -0700
X-Originating-IP: [66.183.105.58]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from localhost ([66.183.105.58]) by BLU0-SMTP42.blu0.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 9 Oct 2009 09:21:54 -0700
In-Reply-To: <20091009101940.GG16558@progeny.tock>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.16.6; i586-redhat-linux-gnu)
X-OriginalArrivalTime: 09 Oct 2009 16:21:54.0385 (UTC) FILETIME=[9D70BC10:01CA48FC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129824>

On Fri, 9 Oct 2009 05:19:40 -0500
Jonathan Nieder <jrnieder@gmail.com> wrote:

> +In the command's second form, creates a new branch named <branchname>.
> +The branch will start out with head pointing to the commit
> +<start-point>.  If no <start-point> is given, the branch will start
> +out with head pointing to the tip of the currently checked out branch,
> +or the currently checked out commit if no branch is checked out.

The first sentence here doesn't quite work, perhaps drop the "In".  But
the whole thing is a bit verbose, what about just:

The command's second form creates a new branch named <branchname> which
points to the current HEAD or <start-point> if given.

>  <start-point>::
> -	The new branch will be created with a HEAD equal to this.  It may
> -	be given as a branch name, a commit-id, or a tag.  If this option
> -	is omitted, the current branch is assumed.
> +	The new branch head will point to this commit.  It may be
> +	given as a branch name, a commit-id, or a tag.  If this
> +	option is omitted, the currently checked out branch head
> +	is used, or the current commit if no branch is checked
> +	out.

Maybe it's not worth worrying about, but couldn't the last sentence
be just:

   If this option is omitted, the current HEAD will be used instead.

Sean

P.S.  Patches 3 and 4 in this series would be better as a single patch.
