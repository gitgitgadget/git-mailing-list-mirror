From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-status: support always/auto/never in colorization
Date: Sat, 05 Aug 2006 17:38:02 -0700
Message-ID: <7vac6id7h1.fsf@assigned-by-dhcp.cox.net>
References: <20060805235756.GA15075@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 06 02:38:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9Wee-00087R-Rn
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 02:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWHFAiF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 20:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWHFAiF
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 20:38:05 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:21435 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751470AbWHFAiE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 20:38:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060806003803.HBFV6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 5 Aug 2006 20:38:03 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060805235756.GA15075@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 5 Aug 2006 19:57:56 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24951>

Jeff King <peff@peff.net> writes:

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is on top of the previous two patches:
>     git-status: colorize status output (me)
>     git-status: do not use colors all the time (Matthias)
>
> I was hoping to join the term selection logic with the diff.color logic
> in git_config_termbool or similar (and a git-repo-config --termbool),
> but unfortunately that doesn't work since git-repo-config can't do an
> isatty test (since we call it as `git-repo-config`). In general, config
> parsing is a little awkward (and inefficient) in sh. Is there any
> interest in me converting git-commit/git-status to C builtins (I know
> Johannes will be happy...)?

I was planning to do only the status part in C anyway.
