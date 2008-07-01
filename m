From: Ingo Molnar <mingo@elte.hu>
Subject: [OT] Your branch is ahead of the tracked remote branch
	'origin/master' by 50 commits.
Date: Tue, 1 Jul 2008 11:13:47 +0200
Message-ID: <20080701091347.GA11817@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 11:15:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDbwy-0000iR-Bw
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 11:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364AbYGAJN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 05:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754165AbYGAJN6
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 05:13:58 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:42740 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755013AbYGAJN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 05:13:57 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KDbvq-0008QW-Fq
	from <mingo@elte.hu>
	for <git@vger.kernel.org>; Tue, 01 Jul 2008 11:13:56 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id B53F93E2205; Tue,  1 Jul 2008 11:13:47 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87012>


i recently switched to 1.5.6.1.89.gd5446 and i'm getting this:

  Switched to branch "master"
  Your branch is ahead of the tracked remote branch 'origin/master' by 50 commits.

it's a very useful detail! It's especially useful when two branches 
diverge in a non-trivial way.

I used to have ad-hoc scripts to discover this in the past:

 earth4:~/tip> tip-compare-remote
 master                        : differs from remote (-50 commits)
 tip                           : differs from remote (-1 commits)
 x86/ptrace                    : differs from remote (-1 commits)
 x86/unify-setup               : differs from remote (-2 commits)
 x86/xen-64bit                 : differs from remote (-1 commits)

but having a reminder at checkout time is even better (and faster as 
well). Kudos.

	Ingo
