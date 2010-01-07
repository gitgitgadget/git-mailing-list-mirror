From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: What's cooking in git.git (Jan 2010, #02 draft; Wed, 06)
Date: Thu, 07 Jan 2010 12:23:34 +0900
Message-ID: <20100107122334.6117@nanako3.lavabit.com>
References: <7vvdfenaar.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 04:24:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSiyy-0000nB-EW
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 04:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756713Ab0AGDYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 22:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756712Ab0AGDYN
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 22:24:13 -0500
Received: from karen.lavabit.com ([72.249.41.33]:44431 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755919Ab0AGDYM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 22:24:12 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 8B98316F51C;
	Wed,  6 Jan 2010 21:24:11 -0600 (CST)
Received: from 8278.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id INO1YL0N0UCX; Wed, 06 Jan 2010 21:24:11 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=b3/lnQaFQTNTCBtz9JVLPacvsXpc4oZjoW36YayPyKpLenTdsnE4lBxwKagRXaQTYDaHzYz06i8MMsqBSlcgKsQL5YjQjyfUxoZnC7iNzV+9SXgYuJYQqY2Fss28Vft/pSMADeubZCHrtIC4gHgFiXHoH9UCz8OHWKcpdA8026g=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vvdfenaar.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136318>

Quoting Junio C Hamano <gitster@pobox.com>

> I am experimenting with ideas to better manage the periodic "What's
> cooking" messages, and here is one of such attempt based on the current
> draft of the upcoming "2010 Jan, issue #02".
>
> This is an incremental update (the full version will follow shortly) that
> shows the changes since the previous issue, and was generated with a
> custom diff driver.  One of the things to notice is that the ones that
> only moved across sections (e.g. bg/maint-remote-update-default) without
> any other changes are shown without the list of commits.
>
> ----------------------------------------------------------------
>
> -What's cooking in git.git (Jan 2010, #01; Mon, 04)
> +What's cooking in git.git (Jan 2010, #02 draft; Wed, 06)
>
> --------------------------------------------------
> Born topics
>
> [New Topics]
>
>  * jc/maint-1.6.1-checkout-m-custom-merge (2010-01-06) 1 commit
>   - checkout -m path: fix recreating conflicts
>
>  * jn/makefile (2010-01-06) 4 commits
>   - Makefile: consolidate .FORCE-* targets
>   - Makefile: learn to generate listings for targets requiring special flags
>   - Makefile: use target-specific variable to pass flags to cc
>   - Makefile: regenerate assembler listings when asked
>
> --------------------------------------------------
> Moved from [New Topics] to [Cooking]
>
>  * da/difftool (2009-12-22) 2 commits
> - - git-difftool: Add '--gui' for selecting a GUI tool
> - - t7800-difftool: Set a bogus tool for use by tests
> +  (merged to 'next' on 2010-01-06 at e957395)
> + + git-difftool: Add '--gui' for selecting a GUI tool
> + + t7800-difftool: Set a bogus tool for use by tests
>
>  * jh/gitweb-cached (2010-01-03) 4 commits
>   - gitweb: Makefile improvements
>   - gitweb: Optionally add "git" links in project list page
>   - gitweb: Add option to force version match
>   - gitweb: Load checking
> +
> +Will merge to 'next', unless I hear objections within a few days.

For what it's worth, I think this new format very easy to spot the differences and much nicer.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
