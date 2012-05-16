From: Eric Wong <normalperson@yhbt.net>
Subject: Re: PATCH: git-svn: support rebase --preserve-merges
Date: Wed, 16 May 2012 00:36:23 +0000
Message-ID: <20120516003623.GA7283@dcvr.yhbt.net>
References: <CAHkK2boHtwbpbfQiqWFWn3BaGfJkojVPLisaghY256m+irE3ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Avishay Lavie <avishay.lavie@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 16 02:36:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUSEI-0006AP-NK
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 02:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967161Ab2EPAg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 20:36:28 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41198 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967097Ab2EPAgY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2012 20:36:24 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 898213338B;
	Wed, 16 May 2012 00:36:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAHkK2boHtwbpbfQiqWFWn3BaGfJkojVPLisaghY256m+irE3ow@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197860>

Avishay Lavie <avishay.lavie@gmail.com> wrote:
> +++ b/git-svn.perl
> @@ -233,6 +233,7 @@ my %cmd = (
>  			  'local|l' => \$_local,
>  			  'fetch-all|all' => \$_fetch_all,
>  			  'dry-run|n' => \$_dry_run,
> +			  'preserve-merges|p' => \$_preserve_merges
>  			  %fc_opts } ],
>  	'commit-diff' => [ \&cmd_commit_diff,
>  	                   'Commit a diff between two trees',

You're missing a comma in the above hunk, but otherwise your patch
looks trivially correct (no need to resend, I'll fix up on my end).
