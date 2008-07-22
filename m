From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Documentation/git-ls-tree.txt: Add a caveat about
	prefixing pathspec
Date: Wed, 23 Jul 2008 00:47:59 +0200
Message-ID: <20080722224759.GJ32184@machine.or.cz>
References: <20080720233956.GH10151@machine.or.cz> <20080721075618.14163.45309.stgit@localhost> <7v1w1nvf7q.fsf@gitster.siamese.dyndns.org> <20080721210452.GP10151@machine.or.cz> <7vd4l6sqqz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 00:49:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLQfM-00056K-Bk
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 00:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbYGVWsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 18:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbYGVWsE
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 18:48:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49458 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751802AbYGVWsD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 18:48:03 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 25C53393B282; Wed, 23 Jul 2008 00:47:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vd4l6sqqz.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89555>

On Mon, Jul 21, 2008 at 05:32:20PM -0700, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> >> 	commit.  E.g.
> >> 
> >> 		$ cd some/deep/path
> >> 		$ git ls-tree --name-only -r HEAD~20
> >> 
> >> 	will list the files in some/deep/path (i.e. where you are) 20
> >> 	commits ago, just like running "/bin/ls" there will give you the
> >> 	list of files you have right now.
> >
> > Frankly, I think this is overdoing it. I'm all for being positive, but
> > it is obvious why this is good thing when you inspect a root tree and
> > there's no need to be too wordy about it...
> 
> I mildly disagree.

We may throw a dice or go with your version, I don't care *that* much
about this change, I just wouldn't make it personally.

> If the person had truly understood that, why do we even have this thread
> to begin with?

To nudge the person to the "aha" moment.

> Description on *what* it does (i.e. "like what ls -a does in the current
> working directory" we have in the Description section) obviously was not
> good enough.

I don't understand; what does auto-prefixing have to do with the
"ls -a" mention?

> It will be better understood if you describe *why* it does
> it that way at the same time.

My version implies that for examining the root tree, without surplusage.

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
