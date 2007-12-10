From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Adding Git to Better SCM Initiative : Comparison
Date: Mon, 10 Dec 2007 15:49:39 +0100
Message-ID: <87ve76mwos.fsf@mid.deneb.enyo.de>
References: <200712101357.49325.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 10 15:50:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1jxO-0006ld-Mr
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 15:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181AbXLJOto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 09:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752688AbXLJOto
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 09:49:44 -0500
Received: from mail.enyo.de ([212.9.189.167]:1698 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752604AbXLJOtn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 09:49:43 -0500
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1J1jwy-0005y4-O6
	for git@vger.kernel.org; Mon, 10 Dec 2007 15:49:41 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.68)
	(envelope-from <fw@deneb.enyo.de>)
	id 1J1jwx-0003yU-G6
	for git@vger.kernel.org; Mon, 10 Dec 2007 15:49:39 +0100
In-Reply-To: <200712101357.49325.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 10 Dec 2007 13:57:48 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67717>

* Jakub Narebski:

> +                <s id="git">
> +                    Yes (or no depending on interpretation). Git

This should be "No." (same for copies below).

> +                <s id="git">
> +                    Partial (?). It is possible to lock down repository
> +                    (access to branches and tags) using hooks.
> +                </s>

I doubt this works reliably.  You still can access data once you've got
its SHA1 hash, for instance.

> +                <s id="git">
> +                    Yes. Changesets are supported.<br />
> +                    Actually Git is snapshot based which means Git records
> +                    the full state in every commit.  This means that any two
> +                    commits can be compared directly very quickly, although the
> +                    repository is typically browsed as a series of changesets.
> +                </s>

I don't think this explanation is necessary.  What does Subversion say?

> +                <s id="git">
> +                    Yes. (git blame, git gui blame).
> +                    It can also detect the origin of copied and moved source
> +                    lines, and can ignore whitespace changes.
> +                </s>

A simple "Yes." should suffice.

> @@ -636,6 +677,10 @@ <title>Tracking Uncommited Changes</title>
>                      Yes, using "darcs whatsnew".
>                  </s>
>                  <s id="aegis">Yes. Using aediff</s>
> +                <s id="git">
> +                    Yes, of course. Using git diff.
> +                    Note that git uses staging area for commits (index).
> +                </s>

Simply "Yes.".  "git diff" is wrong, it's actually "git diff HEAD".

> @@ -681,6 +726,11 @@ <title>Per-File Commit Messages</title>
>                  <s id="darcs">
>                      No.
>                  </s>
> +                <s id="git">
> +                    No.  The message applies to the commit as a whole.
> +                    But you can tag (with description) given contents
> +                    of a file (blob).
> +                </s>

Have we got any real tool support for this?  This should be "No.".

> @@ -1006,6 +1075,13 @@ <title>Command Set</title>
>                      but since the model is different most commands are
>                      unique.
>                  </s>
> +                <s id="git">
> +                    Tries to follow CVS conventions, but deviates where there
> +                    is a different design (following BitKeeper for DVCS).

I don't think this is true.  Is there any command that closely matches
what CVS does?

> @@ -1203,6 +1286,11 @@ <title>Portability</title>
>                      Very good. Supports many UNIXes, Mac OS X, and Windows,
>                      and is written in a portable language.
>                  </s>
> +                <s id="git">
> +                    Good to very good.  Portable across all POSIX systems.
> +                    There exists Win32 binary using MinGW (msysGit),
> +                    or you can use binary provided by Cygwin.
> +                </s>

Isn't Windows support still a bit lacking in terms of performance?
