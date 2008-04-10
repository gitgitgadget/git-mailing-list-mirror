From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] git-remote: show all remotes with "git remote show"
Date: Thu, 10 Apr 2008 21:59:10 +0200
Message-ID: <20080410195910.GB26779@elte.hu>
References: <20080409101428.GA2637@elte.hu> <20080409145758.GB20874@sigill.intra.peff.net> <20080409151551.GA30439@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 10 22:03:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jk2wl-00007F-KN
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 22:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756198AbYDJT7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 15:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758633AbYDJT7f
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 15:59:35 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:56675 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756721AbYDJT7e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 15:59:34 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1Jk2vU-0003o0-02
	from <mingo@elte.hu>; Thu, 10 Apr 2008 21:59:22 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 4ECB63E21D8; Thu, 10 Apr 2008 21:59:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080409151551.GA30439@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79245>


* Jeff King <peff@peff.net> wrote:

> Many other commands use the "no arguments" form to show a
> list (e.g., git-branch, git-tag). While we did show all
> remotes for just "git remote", we displayed a usage error
> for "git remote show" with no arguments. This is
> counterintuitive, since by giving it _more_ information, we
> get _less_ result.
> 
> The usage model can now be thought of as:
> 
>   - "git remote show <remote>": show a remote
>   - "git remote show": show all remotes
>   - "git remote": assume "show"; i.e., shorthand for "git remote show"

btw., another suggestion: because i use 'git-remote show' rather 
frequently, i recently typoed "git-bisect show" and then realized that 
it was "git-bisect visualize". Shouldnt there be a "git-bisect show" 
alias?

I think using 'show' for all such 'display state' things would be rather 
intuitive, if it was applied consistently all across the board. 
('visualize' could still remain indefinitely, for compatibility - and 
'git-bisect log' would still do the log of the bisection decisions that 
were entered.)

Or is there some purpose behind this deviation that i missed?

	Ingo
