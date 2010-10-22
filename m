From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv4 00/21] git notes merge
Date: Sat, 23 Oct 2010 00:28:33 +0200
Message-ID: <201010230028.34255.johan@herland.net>
References: <1287626936-32232-1-git-send-email-johan@herland.net>
 <AANLkTi=YJd023C3rX_G+NEM_0N-nZqd0uP7yyTSt1tHj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 23 00:28:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Q6L-0005tb-UR
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 00:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145Ab0JVW2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 18:28:37 -0400
Received: from smtp.getmail.no ([84.208.15.66]:61292 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750855Ab0JVW2g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 18:28:36 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAP001LFQFNR230@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 23 Oct 2010 00:28:35 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 7CA761EA58A6_CC21013B	for <git@vger.kernel.org>; Fri,
 22 Oct 2010 22:28:35 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 5B9FF1EA2B43_CC21013F	for <git@vger.kernel.org>; Fri,
 22 Oct 2010 22:28:35 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAP00BS3QFMOK00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 23 Oct 2010 00:28:35 +0200 (MEST)
User-Agent: KMail/1.13.5 (Linux/2.6.35-ARCH; KDE/4.5.2; x86_64; ; )
In-reply-to: <AANLkTi=YJd023C3rX_G+NEM_0N-nZqd0uP7yyTSt1tHj@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159760>

(fragmenting this thread for the last time, I promise...)

On Thursday 21 October 2010, Sverre Rabbelier wrote:
> On Wed, Oct 20, 2010 at 21:08, Johan Herland wrote:
> > - When resolving notes merge conflicts, you can add/remove files/notes
> >  in .git/NOTES_MERGE_WORKTREE; 'git notes merge --commit' does not
> >  check that the notes have any relationship to the notes originally
> >  put there by 'git notes merge'. Should we warn about removed and
> >  added notes in .git/NOTES_MERGE_WORKTREE? Currently we don't, and
> >  I'm not sure it's worth it. Users can always review the merge commit
> >  afterwards.
> 
> If it's easy to do, it would be useful.

Well, currently I don't store a separate list of conflicts anywhere, so I 
would need to add that in order to have 'git notes merge --commit' warn 
about deletions/additions in .git/NOTES_MERGE_WORKTREE.

Also, for conflicts where a note is modified in one branch and deleted in 
the other, I don't think it makes sense to warn about their deletion (since 
that in many cases is a perfectly valid resolution of those conflicts).

Which leaves warning about "other" additions/deletions. We could certainly 
do this, but I'd frankly rather get the current patch series through without 
broadening its scope. I've been sitting on this far too long as it is. I'll 
keep it on my TODO list for a future series (if nobody else beats me to it).


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
