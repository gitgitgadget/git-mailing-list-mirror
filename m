From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [q] git-diff --reverse 7def2be1..7def2be1^
Date: Thu, 26 Jun 2008 13:08:26 +0200
Message-ID: <20080626110826.GA25701@elte.hu>
References: <20080620082034.GA24913@elte.hu> <m34p7ombie.fsf@localhost.localdomain> <20080626093726.GA24577@elte.hu> <200806261302.03952.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 13:10:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBpMD-0002f2-B6
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 13:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757997AbYFZLIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 07:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757963AbYFZLIp
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 07:08:45 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:50788 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757316AbYFZLIo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 07:08:44 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KBpL3-0004wd-NJ
	from <mingo@elte.hu>; Thu, 26 Jun 2008 13:08:40 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 7012B3E21DD; Thu, 26 Jun 2008 13:08:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200806261302.03952.jnareb@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86431>


* Jakub Narebski <jnareb@gmail.com> wrote:

> On Thu, 26. Jun 2008, Ingo Molnar wrote:
> > * Jakub Narebski <jnareb@gmail.com> wrote:
> >> Ingo Molnar <mingo@elte.hu> writes:
> >>> * Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> >>> 
> >>>> (BTW, git-foo is being obsoleted in favor of "git foo")
> >>> 
> >>> hm, can Bash be taught to do command completion on 'git rer<tab>', like 
> >>> it is able to do on git-rer<tab> ?
> >> 
> >> contrib/completion/git-completion.bash in git repository.  
> > 
> > btw., i had to turn this off - it made certain types of file completions 
> > almost unusable, by adding a 2-3 seconds delay (during which bash would 
> > just spin around burning CPU time calculating its completion guesses).
> 
> Perhaps it would be better when "ceiling dir" feature in git, and
> configured, so git don't waste time searching for git repositories
> where there aren't any.
> 
> > and that was on a 3 GHz dual-core box ...
> 
> I think this might depend more on filesystem used, and file hierarchy. 
> And also probably on the number of branches...

well i wanted to say it's a box fast enough.

ext3, kernel tree, -tip repository with 142 local branches and 277 total 
branches.

	Ingo
