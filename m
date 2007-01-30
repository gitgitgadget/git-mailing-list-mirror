From: Bill Lear <rael@zopyra.com>
Subject: Re: Why is git clone not checking out files?
Date: Tue, 30 Jan 2007 13:11:28 -0600
Message-ID: <17855.39008.920685.62837@lisa.zopyra.com>
References: <17855.35058.967318.546726@lisa.zopyra.com>
	<17855.36470.309129.391271@lisa.zopyra.com>
	<Pine.LNX.4.64.0701301040200.3611@woody.linux-foundation.org>
	<200701301950.00195.jnareb@gmail.com>
	<Pine.LNX.4.64.0701301058250.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 20:11:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HByOP-0005UG-2P
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 20:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbXA3TLm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 14:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbXA3TLm
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 14:11:42 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60252 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630AbXA3TLk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 14:11:40 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0UJBWL02626;
	Tue, 30 Jan 2007 13:11:32 -0600
In-Reply-To: <Pine.LNX.4.64.0701301058250.3611@woody.linux-foundation.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38189>

On Tuesday, January 30, 2007 at 11:04:57 (-0800) Linus Torvalds writes:
>...
>Of course, I do agree that it'sa fairly confusing way to set up a repo, 
>and you generally shouldn't do it, but Bill did it that way explicitly. 
>Maybe he didn't do it "on purpose", but git at no point in time had any 
>way to know that Bill wanted somethign else. Nothing he did was "wrong", 
>and it's quite possible that it's what he could have meant to do.

My setup was prompted by advice I got here.  Perhaps I misunderstood.
I thought the way to set up a shared public repo for my collaborators
was to git --bare init-db --shared, then do a git fetch from the upstream
repo.  I want to be able to push into my public repo from one or more
of my private repos, hence the need (I was told) for he bare option.

>Anyway, it's certainly easy to fix. Bill, you can either:
>
> - just rename the "topic" branch to "master"

I don't think I want this.  I want to know I'm on the topic branch of
that repo, anything else really makes me nervous.

> - change the HEAD to point to "topic" rather than "master".

Same for this...[Thanks for the advice, nevertheless.]

I wonder if the original repo I pulled from is just messed up.  Ahh --
I see Shawn just replied saying I needed to fetch in a different way.
I shall peruse that and report clarity of vision when achieved...


Bill
