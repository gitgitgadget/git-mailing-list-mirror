From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [q] git-diff --reverse 7def2be1..7def2be1^
Date: Thu, 26 Jun 2008 11:37:26 +0200
Message-ID: <20080626093726.GA24577@elte.hu>
References: <20080620082034.GA24913@elte.hu> <vpqiqw42vk6.fsf@bauges.imag.fr> <20080620135004.GB8135@elte.hu> <m34p7ombie.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 11:40:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBnw0-0003in-Pd
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 11:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755058AbYFZJhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 05:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755035AbYFZJhi
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 05:37:38 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:43485 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754931AbYFZJhh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 05:37:37 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1KBnuy-0006D9-TR
	from <mingo@elte.hu>; Thu, 26 Jun 2008 11:37:34 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 6F4D53E21DD; Thu, 26 Jun 2008 11:37:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m34p7ombie.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86422>


* Jakub Narebski <jnareb@gmail.com> wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> 
> > * Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> > 
> > > (BTW, git-foo is being obsoleted in favor of "git foo")
> > 
> > hm, can Bash be taught to do command completion on 'git rer<tab>', like 
> > it is able to do on git-rer<tab> ?
> 
> contrib/completion/git-completion.bash in git repository.  

btw., i had to turn this off - it made certain types of file completions 
almost unusable, by adding a 2-3 seconds delay (during which bash would 
just spin around burning CPU time calculating its completion guesses).

and that was on a 3 GHz dual-core box ...

so please do not remove the git-* commands, they are really useful.

	Ingo
