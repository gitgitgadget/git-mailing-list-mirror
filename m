From: Bill Lear <rael@zopyra.com>
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 09:45:28 -0500
Message-ID: <18032.776.784080.321044@lisa.zopyra.com>
References: <18031.64456.948230.375333@lisa.zopyra.com>
	<20070613143845.GD5311@artemis.intersec.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jun 13 16:46:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyU77-0002MQ-87
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 16:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757642AbXFMOqG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 10:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757740AbXFMOqE
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 10:46:04 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60959 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757642AbXFMOqD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 10:46:03 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l5DEjVp11212;
	Wed, 13 Jun 2007 09:45:31 -0500
In-Reply-To: <20070613143845.GD5311@artemis.intersec.eu>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50064>

[Pierre writes:]
>  I suppose the following way would work:
>
>  $ git commit -a -m "temporary commit"  # save current work
>  $ git branch -f dirty                  # ..in a separate branch
>  $ git reset --hard HEAD~1              # unwind this commit
>  $ git pull                             # perform a clean pull
>  $ git rebase master dirty              # rewrite the work
>  <you may have to fix some conficts here>
>  $ git reset master                     # "undo" the commit
>
>  So that's definitely doable.
>
>  Though, in git, if you really work in a "pure" git environment, you
>never pull until your work in your topic branch is ready for a merge.
>It's a very bad habit to do otherwise: you don't _need_ to pull until
>you have a clean slate.

I know, but I can't throw git purity at them as an explanation, they
won't understand.  And they would disagree about the "need" to pull.
That's for them to say: they WANT to pull without having to move aside
the makefile that they modified to add the '-wingit' option to the
compile line and just get on with their work without having to run 14
different git commands.

I'm not trying to justify their habits, but to try to see if there is
any clinching reason why this habit is not only "bad", but positively
harmful.


Bill
