From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [q] git-diff --reverse 7def2be1..7def2be1^
Date: Fri, 20 Jun 2008 15:52:37 +0200
Message-ID: <20080620135236.GC8135@elte.hu>
References: <20080620082034.GA24913@elte.hu> <m3d4mcmq20.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 15:53:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9h3e-0006uP-P7
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 15:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbYFTNwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 09:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754607AbYFTNwr
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 09:52:47 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:50513 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752410AbYFTNwr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 09:52:47 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1K9h2c-0004HX-AT
	from <mingo@elte.hu>; Fri, 20 Jun 2008 15:52:44 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id B57903E21DC; Fri, 20 Jun 2008 15:52:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m3d4mcmq20.fsf@localhost.localdomain>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85648>


* Jakub Narebski <jnareb@gmail.com> wrote:

> >    But Git didnt recognize that as a valid commit range.
> 
> There is shortcut for rev^..rev, namely rev^! (I'm not sure if it is 
> documented anywhere, though), so you could have used
> 
>         git diff 7def2be1^!

nice! :-)

> >    [ time passes as i read the manpage - the final thing i do when
> >      every other measure fails ;-) ]
> > 
> >    Ah, there's "git-log -R" that would achieve this. 
> 
> I think you should have done this first...

to read the man page? Nobody reads the manuals, except in grave 
circumstances ;-)

(Seriously, i usually try to guess around a lot with shell commands just 
to figure out new things, and to see how intuitive they are.)

	Ingo
