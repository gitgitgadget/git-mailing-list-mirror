From: Pietro Battiston <me@pietrobattiston.it>
Subject: Re: git-repack & big files
Date: Thu, 13 Jan 2011 09:00:40 +0100
Message-ID: <1294905640.4033.920.camel@voubian.casa>
References: <1294731438.3300.973.camel@voubian.casa>
	 <4D2C7AA9.1020506@cfl.rr.com> <1294772603.3435.67.camel@voubian.casa>
	 <4D2CB3F5.106@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Thu Jan 13 09:01:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdI7K-0002AC-1L
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 09:01:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749Ab1AMIBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 03:01:04 -0500
Received: from pietrobattiston.it ([92.243.7.39]:39800 "EHLO
	jauntuale.pietrobattiston.it" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752601Ab1AMIBD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jan 2011 03:01:03 -0500
Received: from [192.168.1.2] (net-188-218-44-247.cust.dsl.vodafone.it [188.218.44.247])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jauntuale.pietrobattiston.it (Postfix) with ESMTPSA id 3750713560;
	Thu, 13 Jan 2011 08:01:00 +0000 (UTC)
In-Reply-To: <4D2CB3F5.106@cfl.rr.com>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165042>

Il giorno mar, 11/01/2011 alle 14.48 -0500, Phillip Susi ha scritto: 
> On 1/11/2011 2:03 PM, Pietro Battiston wrote:
> > That's unfortunate - I think I prefer to split my mailboxes than to
> > loose many of the nice features git provides. But thanks a lot for the
> > suggestion.
> 
> I'm curious what features of git you find helpful for this purpose.  

Many more, I guess, that the ones I'll be able to remember now. But for
instance some features that make it better than rdiff-backup are:

1) I like to see how a given file changed at a given point in time with
a comfortable interface - not just "restore this there", or search for
the right diff gzipped somewhere

2) I like to delete some given files/folders that I forgot to
(.git)ignore from all the backups with a single command

3) I love the fact that if I move/rename a file/folder, git notices it
(and doesn't think I just deleted some files and created some others).
Since I often move/rename files/folders, when I knew git I really though
"after years of waiting, finally backups will be smart".

4) in principle - though I admit I still never tried - I like the idea
that if I have two copies of the git repo, I can backup once on each
(think of one staying home and one following me when I travel) and then
rebase one on the other

5) to backup my home the first time, rdiff-backup takes slightly less
than 5 hours and uses 32 GB , git takes around 2 hours and uses 17 GB

6) in general, just having a powerful interface I'm used to

> The
> history log doesn't seem useful at all. 

I also like the fact that my commits have comments such as "before
changing PC", "after system upgrade", "before reordering mail"...


> Generally mail is only added,
> and sometimes deleted, never changed, so it also does not seem useful to
> keep multiple revisions.  

I'm not sure I get what you mean - mail is added and deleted, hence the
mailbox is changed, hence I find it useful to keep multiple revisions.


> If you really want that though, rdiff-backup
> will do that and keep the old revisions delta compressed.
> 

Yes, I think I will live with rdiff-backup. And miss git, but I
perfectly understand that git simply doesn't aim at solving my problem,
and that's fair.


> I use Maildir instead of mbox and do a nightly incremental backup of the
> whole system with dump, so any mail I might loose by accident I can pull
> from the backup if it is older than a day, and I never delete mail.

Yep, Maildir is nice from this point of view. But nope, it is not
practical for me to change now.

thanks to all for suggestions (and sorry for the OT)

Pietro
