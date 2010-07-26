From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Mon, 26 Jul 2010 12:37:00 -0400
Message-ID: <4C4DB9AC.9000306@xiplink.com>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> 	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com> 	<4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> 	<m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com> 	<4C49B31F.8000102@xiplink.com> <AANLkTi=LHYDhY=424YZpO3yGqGGsxpY2Sj8=ULNKvAQX@mail.gmail.com> 	<AANLkTinhd2DYh7WXzMvhMkqp98fYtTWWuQi0RSL9Rome@mail.gmail.com> <AANLkTimLayG_HFxGdq+Tt8hU_MApBpSdHHiYPxcakpRJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: skillzero@gmail.com, Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 18:37:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdQfy-0006tv-Qh
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 18:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187Ab0GZQhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 12:37:08 -0400
Received: from smtp112.dfw.emailsrvr.com ([67.192.241.112]:38327 "EHLO
	smtp112.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485Ab0GZQhH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 12:37:07 -0400
Received: from relay11.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay11.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id F013A17FB08;
	Mon, 26 Jul 2010 12:37:04 -0400 (EDT)
Received: by relay11.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id B0BBC180D0C;
	Mon, 26 Jul 2010 12:37:00 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100528 Thunderbird/3.0.5
In-Reply-To: <AANLkTimLayG_HFxGdq+Tt8hU_MApBpSdHHiYPxcakpRJ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151855>

On 10-07-23 09:20 PM, Avery Pennarun wrote:
> 
> I'm pushing extra hard on this because I believe there are lots of
> opportunities to just improve git performance on huge repositories.
> And if the only *real* reason people need to split repositories is
> that performance goes down, then that's fixable, and you may need
> neither git-submodule nor git-subtree.

I think I should mention one aspect of what we're doing, which is that a lot
of our submodules are based on external code, and that we occasionally need
to modify or customize some of that code.  So it's quite nice for us to
maintain private git mirrors of the external repos, with our own private
branches that contain our modifications.  Although we want to get much of our
changes incorporated into the upstream code bases, upstream release cycles
are rarely in sync with ours.

So it's very convenient for use to have our external-code modifications
contained in private branches in our private mirrors, and to rebase those
branches to keep up with upstream releases.  We also often use these private
branches to maintain the code that integrates the external code bases into
our overall build system.

I mention this purely because this pattern is so convenient that I don't want
to see it get lost in whatever may arise from this discussion.

		M.
