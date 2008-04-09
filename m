From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] git-remote: show all remotes with "git remote show"
Date: Wed, 9 Apr 2008 22:07:08 +0200
Message-ID: <20080409200708.GB18968@elte.hu>
References: <20080409101428.GA2637@elte.hu> <20080409145758.GB20874@sigill.intra.peff.net> <20080409151551.GA30439@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 09 22:08:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjgaj-0007T7-FU
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 22:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754291AbYDIUHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 16:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754285AbYDIUHe
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 16:07:34 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:60540 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753612AbYDIUHe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 16:07:34 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1JjgZg-0000xo-2q
	from <mingo@elte.hu>; Wed, 09 Apr 2008 22:07:22 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id CB5C13E21D8; Wed,  9 Apr 2008 22:07:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080409151551.GA30439@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79127>


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
> 
> Signed-off-by: Jeff King <peff@peff.net>

cool, thanks!

	Ingo
