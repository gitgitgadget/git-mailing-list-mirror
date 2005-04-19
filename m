From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Change "pull" to _only_ download, and "git update"=pull+merge?
Date: Tue, 19 Apr 2005 19:20:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504191908290.30848-100000@iabervon.org>
References: <42658888.60007@dwheeler.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>,
	Martin Schlemmer <azarah@nosferatu.za.org>,
	David Greaves <david@dgreaves.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 01:24:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO24p-0003Q5-2p
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 01:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVDSX0u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 19:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVDSXYN
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 19:24:13 -0400
Received: from iabervon.org ([66.92.72.58]:57349 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261739AbVDSXUf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 19:20:35 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DO21J-0000bQ-00; Tue, 19 Apr 2005 19:20:41 -0400
To: "David A. Wheeler" <dwheeler@dwheeler.com>
In-Reply-To: <42658888.60007@dwheeler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 19 Apr 2005, David A. Wheeler wrote:

> In a _logical_ sense that's true; I'd only want to pull data if I intended
> to (possibly) do something with it.  But as a _practical_ matter,
> I can see lots of reasons for doing a pull as a separate operation.
> One is disconnected operation; (...)

That's true. I think I actually like "git pull" as the operation for "make
sure I have everything I need, so I can lose net".

> What command would you suggest for the common case
> of "update with current track?"  I've proposed "git update [NAME]".
> "git merge" with update-from-current-track as default seems unclear, and
> I worry that I might accidentally press RETURN too soon & merge with
> the wrong thing.  And I like the idea of "git update" doing the same thing
> (essentially) as "cvs update" and "svn update"; LOTS of people "know"
> what update does, so using the same command name for one of the most
> common operations smooths transition (GNU Arch's "tla update"
> is almost, though not exactly, the same too.)

I think that having "git update" update a tracked branch is best, if only as
an aid to discoverability. And "git merge" should require you to say what
you want to merge with, because it's too easy to pick a wrong default, and
the user had better know.

It seems to me like this makes "update" identical to "merge <tracked>", so
"update [NAME]" and "merge" don't make sense, since they'd do the other
command, but less intuitively.

	-Daniel
*This .sig left intentionally blank*

