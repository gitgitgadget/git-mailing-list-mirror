From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [OT] Your branch is ahead of the tracked remote branch
	'origin/master' by 50 commits.
Date: Tue, 1 Jul 2008 12:14:15 +0200
Message-ID: <20080701101414.GG31309@elte.hu>
References: <20080701091347.GA11817@elte.hu> <80iqvq2bw0.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bruce Stephens <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 12:15:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDctS-00045e-8U
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 12:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbYGAKOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 06:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbYGAKOa
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 06:14:30 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:59104 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751386AbYGAKO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 06:14:29 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1KDcsL-0004oL-VT
	from <mingo@elte.hu>; Tue, 01 Jul 2008 12:14:28 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id DD4CB3E2205; Tue,  1 Jul 2008 12:14:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <80iqvq2bw0.fsf@tiny.isode.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87022>

* Bruce Stephens <bruce.stephens@isode.com> wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> 
> > i recently switched to 1.5.6.1.89.gd5446 and i'm getting this:
> >
> >   Switched to branch "master"
> >   Your branch is ahead of the tracked remote branch 'origin/master' by 50 commits.
> >
> > it's a very useful detail! It's especially useful when two branches 
> > diverge in a non-trivial way.
> 
> I agree, it's a really nice little feature.  Indeed, I occasionally do 
> "git checkout master" just to get the message (to see where I am).
> 
> It feels logical for "git status" to offer the same information (when 
> the information is appropriate).
> 
> [...]

i have a tip-curr (shortcut: 'tc') scriptlet to answer the "where I am 
amongst 100+ branches" question:

  earth4:~/tip> tc
  tip/master 200a86b: Merge branch 'x86/unify-setup'

which is just a thin wrapper around git-log:

  earth4:~/tip> cat ~/bin/tip/tip-curr
  #!/bin/bash

  . ~/bin/tip/tip-lib

  echo "tip/"$(get_current_branch)" "$(git log -1 --pretty=format:"%h: %s")

	Ingo
