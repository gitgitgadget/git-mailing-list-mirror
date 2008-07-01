From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [OT] Your branch is ahead of the tracked remote branch
	'origin/master' by 50 commits.
Date: Tue, 1 Jul 2008 13:22:35 +0200
Message-ID: <20080701112235.GC11809@elte.hu>
References: <20080701091347.GA11817@elte.hu> <7vlk0mne5d.fsf@gitster.siamese.dyndns.org> <20080701100725.GE31309@elte.hu> <20080701111601.GT4729@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jul 01 13:24:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDdxz-0003HR-SQ
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 13:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288AbYGALXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 07:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754188AbYGALW7
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 07:22:59 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:40732 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753499AbYGALW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 07:22:58 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KDdwW-0003Qm-JE
	from <mingo@elte.hu>; Tue, 01 Jul 2008 13:22:46 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 198313E2205; Tue,  1 Jul 2008 13:22:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080701111601.GT4729@genesis.frugalware.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87024>


* Miklos Vajna <vmiklos@frugalware.org> wrote:

> On Tue, Jul 01, 2008 at 12:07:25PM +0200, Ingo Molnar <mingo@elte.hu> wrote:
> > !! You have installed git-* commands to new gitexecdir.
> > !! Old version git-* commands still remain in bindir.
> > !! Mixing two versions of Git will lead to problems.
> > !! Please remove old version commands in bindir now.
> > 
> > that's an easily overlooked detail.
> 
> There is a 10-lines-length note about this in RelNotes, but I think 
> removing the old version is a task of the package manager. At least 
> till the git Makefile does not have an 'uninstall' target.

random (likely stupid) idea: perhaps git could use ... a separate Git 
repo to track gitexecdir installations in $HOME/bin/? That could be 
tagged appropriately so you'd always know what to uninstall and whether 
there are clashes or incompatibilities.

[ Oh, and i could switch between git versions without having to rebuild
  ;-) ]

	Ingo
