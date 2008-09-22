From: Petr Baudis <pasky@suse.cz>
Subject: Re: [TopGit PATCH] prev/next/tsort: commands to explore
	dependencies
Date: Mon, 22 Sep 2008 17:36:14 +0200
Message-ID: <20080922153614.GO10360@machine.or.cz>
References: <1221818101-14333-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 17:37:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhnTa-0003VI-8H
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 17:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbYIVPgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 11:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753325AbYIVPgR
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 11:36:17 -0400
Received: from w241.dkm.cz ([62.24.88.241]:46926 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753239AbYIVPgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 11:36:16 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id E2A17393A2DD; Mon, 22 Sep 2008 17:36:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1221818101-14333-1-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96483>

  Hi,

On Fri, Sep 19, 2008 at 11:55:00AM +0200, Bert Wesarg wrote:
> I hacked 3 commands to explore the dependencies of TopGit patches:

  thanks, the idea of all three commands is good,

>   I) tg prev [NAME]
>      outputs the dependencies of NAME
> 
>  II) tg next [NAME]
>      outputs patches that depends on NAME

  but I think it would be cleaner to add this functionality to
tg info...

> III) tg tsort [PATTERN]
>      outputs a topological order of all patches starting with PATTERN

...and tg summary (overally, to have a tree view of branches).

> diff --git a/tg-tsort.sh b/tg-tsort.sh
> new file mode 100644
> index 0000000..8a7376a
> --- /dev/null
> +++ b/tg-tsort.sh
..snip..
> +					printf "%s\t%q\n" "${dep_rev}" "${dep}" >&3
> +					printf "%s\t%s\n" "${topic_rev}" "${dep_rev}"

%q?

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
