From: Junio C Hamano <junkio@cox.net>
Subject: Re: Multi-head pulling series
Date: Mon, 22 Aug 2005 18:07:15 -0700
Message-ID: <7vbr3p1mws.fsf@assigned-by-dhcp.cox.net>
References: <7vek8rlnbn.fsf@assigned-by-dhcp.cox.net>
	<200508181245.58250.Josef.Weidendorfer@gmx.de>
	<7vfyt4l9q9.fsf@assigned-by-dhcp.cox.net>
	<200508221835.31275.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 03:07:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7NG6-0006hJ-4h
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 03:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVHWBHS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Aug 2005 21:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbVHWBHS
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Aug 2005 21:07:18 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:29928 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750728AbVHWBHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2005 21:07:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050823010714.DZZE550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 22 Aug 2005 21:07:14 -0400
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> I think that both, default and non-default persistant
> mappings, are only a handy convenience issue for less
> typing. If GIT core is not doing this, some (most?) porcelains
> will invent their own way for storing these mappings (like
> Cogito is doing with branches/). I think it is better if this
> is "standardized".

I agree in principle, and it should not be hard to add support
for optional "Default-pull" and "Default-push" keywords to
remotes/ files (lack of which means to use LHS of refspecs on
"Pull" or "Push" lines) to git-parse-remote-script.  Patches
welcome.

> Currently missing here is automatic detection of the remote
> repository for a given head to be pulled/pushed. But this is
> no format issue.

"git ls-remote <repo>" perhaps?
