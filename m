From: Ryan Anderson <ryan@michonline.com>
Subject: Re: Last mile to 1.0?
Date: Sat, 23 Jul 2005 04:15:49 -0400
Message-ID: <20050723081549.GC3255@mythryan2.michonline.com>
References: <7vwtnqhcfb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 10:16:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwFBC-0004K0-Ph
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 10:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVGWIPz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 04:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVGWIPz
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 04:15:55 -0400
Received: from mail.autoweb.net ([198.172.237.26]:50349 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261568AbVGWIPv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jul 2005 04:15:51 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DwFAk-0005LI-G1; Sat, 23 Jul 2005 04:15:50 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DwFJ4-0004XZ-00; Sat, 23 Jul 2005 04:24:26 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DwFAj-0001eM-Tj; Sat, 23 Jul 2005 04:15:49 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtnqhcfb.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 16, 2005 at 10:46:00AM -0700, Junio C Hamano wrote:
> I do not know what release plan Linus has in mind, and also
> expect things to be quieter next week during OLS and kernel
> summit, but I think we are getting really really close.

Looking at the set of patches we just all dumped on Linus, I think they
pretty much show us that we don't have any major issues.

As I see it, the status is currently like this:

Revision control - Stable
Pulling locally or over rsync - Stable
Pushing over ssh - Stable

Remote, anonymous pulls not using rsync - Beta
Usability features[1] - Beta

Documentation - Alpha

My feeling is that we're pretty well set to do a 1.0 release.

1 - Usability features are all the things around git-apply,
git-format-patch, etc, that we're clearly working on to make life more
pleasant, but aren't really critical.

-- 

Ryan Anderson
  sometimes Pug Majere
