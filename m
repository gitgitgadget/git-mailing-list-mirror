From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: On git 1.6 (novice's opinion)
Date: Wed, 01 Apr 2009 11:38:59 +0200
Organization: Universitaetsklinikum Regensburg
Message-ID: <49D35254.4137.CB56FE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <49D32CE5.21780.391D18@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de> (Ulrich Windl's message of "Wed\, 01 Apr 2009 08\:59\:16 +0200"), <vpq63horepl.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Apr 01 11:41:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LowwG-00047u-Vo
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 11:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbZDAJjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 05:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbZDAJjV
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 05:39:21 -0400
Received: from rrzmta1.rz.uni-regensburg.de ([194.94.155.51]:14266 "EHLO
	rrzmta1.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750974AbZDAJjU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Apr 2009 05:39:20 -0400
Received: from rrzmta1.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id EB382ABC6D;
	Wed,  1 Apr 2009 11:39:21 +0200 (CEST)
Received: from mailgate.dvm.klinik.uni-regensburg.de (kgate2.klinik.uni-regensburg.de [132.199.176.19])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by rrzmta1.rz.uni-regensburg.de (Postfix) with ESMTP id CDBD2ABC31;
	Wed,  1 Apr 2009 11:39:20 +0200 (CEST)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by mailgate.dvm.klinik.uni-regensburg.de (8.13.6/8.13.6/20060824MT-1) with ESMTP id n319dBhM027496;
	Wed, 1 Apr 2009 11:39:11 +0200
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    1 Apr 09 11:39:10 +0100
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 1 Apr 09 11:39:08 +0100
In-reply-to: <vpq63horepl.fsf@bauges.imag.fr>
X-mailer: Pegasus Mail for Windows (4.41)
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.29/Sophos-P=4.37.0+V=4.37+U=2.07.219+R=05 January 2009+T=589357@20090401.093558Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115360>

On 1 Apr 2009 at 9:54, Matthieu Moy wrote:

> "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:
> 
> >> Not to mention that you can have multiple roots (multiple commits with
> >> no parent) in git repository; besides independent branches (like
> >> 'man', 'html' or 'todo') it is usually result of absorbing or
> >> subtree-merging other projects.  In 'master' branch there are 5 roots
> >> or more: joined 'git-tools' (mailinfo / mailsplit), absorbed gitweb,
> >> and subtree-merged gitk and git-gui.  And here you would again have
> >> multiple commits with the same number...
> >
> > Which would not harm, because it would be version N from committer X. Any if 
> > committer X merges from anything else, the next number would be > N. I did not 
> > claim that my method makes a total ordering of commits and merges possible.
> 
> Neither does it make the numbers unique for committer X.
> 
> If commiter X commits a successor to commit N, it's labeled N+1. If
> later, he creates another branch from commit N, and commit, the new,
> other commit will be labeled N+1.

Correct: They live in a parallel universe. But on the long term they will either 
vanish or be merged in which case the number will be "> N+1" (on the main branch). 
So we have a branch plus a sequence number all the time.

> 
> This means even within a repository, you cannot say things like
> "commit number N", so, OK, you have numerical IDs, but you can't use
> them.

I never wanted to have such a thing (using those numbers for commit).

> 
> What can be interesting is that a commit takes 
> max{all commits in repository}+1, not just max{parents} + 1. Then, you
> have local revision numbers, but they're not stable. Indeed, that's
> precisely what Mercurial does.

That would be a (temporary) total ordering, which I did not want, exactly for that 
reason.

[I did not intend the following use case]

Ulrich

> 
> But I'm not sure how much simplicity it adds compared to the confusion
> it adds. Newbies will see Mercurial identifiers as
> 
> changeset:   2:699b81a5851b
> changeset:   1:fd4b6597548f
> changeset:   0:58cff172192e
> 
> And think "OK, the revision numbers are 0, 1, 2, and the hexadecimal
> stuff beside is useless". And one day, he'll send a mail, post a
> bugreport, or whatever, saying "I have a problem with revision number
> 42", and no one else but him will know which revision is called "42".
> 
> > I truly believe in unique IDs, but they are just not handy in every situation.
> 
> Usually, people find Git IDs to be non-handy until the find out they
> can cut-and-paste only the first few digits in most cases, like
> 442dd42 instead of 442dd42d6d4903640b0dc5561481a77c88dcea90 ;-).
> 
> -- 
> Matthieu
