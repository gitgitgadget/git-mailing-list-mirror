From: =?utf-8?Q?Peter_M=C3=BCnster?= <pmlists@free.fr>
Subject: Re: feature request: git svn dommit --preserve-timestamps
Date: Sun, 12 Jun 2016 12:23:54 +0200
Message-ID: <87a8iqiu2t.fsf@roche-blanche.net>
References: <87a8iy6s4e.fsf@free.fr> <20160607000902.GA4445@dcvr.yhbt.net>
	<87ziqx5z9h.fsf@free.fr> <20160611013948.GA5793@dcvr.yhbt.net>
	<878tycmejb.fsf@free.fr> <20160611114331.GA1678@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Sun Jun 12 12:24:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC2Z4-0008V7-NK
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbcFLKYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2016 06:24:13 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:47969 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbcFLKYM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:24:12 -0400
Received: from micropit.roche-blanche.homenet.org ([86.215.209.32])
	by mwinf5d14 with ME
	id 5mPu1t00R0iVAr203mPvSj; Sun, 12 Jun 2016 12:24:10 +0200
X-ME-Helo: micropit.roche-blanche.homenet.org
X-ME-Auth: ZHJwbUB3YW5hZG9vLmZy
X-ME-Date: Sun, 12 Jun 2016 12:24:10 +0200
X-ME-IP: 86.215.209.32
Received: by micropit.roche-blanche.homenet.org (Postfix, from userid 1000)
	id D1AA7135D6; Sun, 12 Jun 2016 12:23:54 +0200 (CEST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297103>

On Sat, Jun 11 2016, Eric Wong wrote:

> I'm sorry for your situation and hoping you migrate off SVN
> entirely, soon :)

I've done so, but my customer won't. He wants the code in his svn-repo.


> Maybe you could look at how the _use_log_author and
> _add_author_from options work.  I've forgotten their existence
> until now and I've never used them myself; but apparently
> they're still there.

That would mean adding "Date: ..." to the log message.
Of course, I could do that. But then my customer would get confused
about these extra lines in the svn log.


It seems really to complicated, I think I'll just make a script, that
saves all important information (date, message, etc.) at every
git-commit to some kind of personal log-file, that I can use when I need
to search the history by date.

Nevertheless thanks for your efforts.
Kind regards,
-- 
           Peter
