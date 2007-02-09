From: Theodore Tso <tytso@mit.edu>
Subject: Re: Git rescue mission
Date: Thu, 8 Feb 2007 20:48:52 -0500
Message-ID: <20070209014852.GA13207@thunk.org>
References: <17866.27739.701406.722074@lisa.zopyra.com> <Pine.LNX.4.64.0702080858430.8424@woody.linux-foundation.org> <87fy9gz9vu.fsf@host94.eke.fi> <Pine.LNX.4.64.0702081321040.8424@woody.linux-foundation.org> <87bqk4z4qw.fsf@host94.eke.fi> <20070208221023.GB1091@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kalle Pokki <kalle.pokki@iki.fi>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 09 02:49:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFKt3-0003hQ-Nw
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 02:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946011AbXBIBtP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 20:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946012AbXBIBtO
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 20:49:14 -0500
Received: from thunk.org ([69.25.196.29]:46755 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946011AbXBIBtO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 20:49:14 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HFKxm-0002GW-LL; Thu, 08 Feb 2007 20:54:10 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HFKse-000521-FG; Thu, 08 Feb 2007 20:48:52 -0500
Content-Disposition: inline
In-Reply-To: <20070208221023.GB1091@spearce.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39146>

On Thu, Feb 08, 2007 at 05:10:23PM -0500, Shawn O. Pearce wrote:
> 	git config alias.new "gitk --all --not ORIG_HEAD"
> 
> Would give you a new git subcommand:
> 
> 	git new
> 
> which shows all of the new stuff, on all branches, but doesn't show
> your prior commit history.

Aliases don't seem to be working for me; I'm using git 1.5.0-rc4.  Am
I doing something wrong?

<tytso@candygram> {/usr/projects/linux/linux-2.6}  [master]
37% git version
git version 1.5.0.rc4
<tytso@candygram> {/usr/projects/linux/linux-2.6}  [master]
38% git config alias.new "gitk --all --not ORIG_HEAD"
<tytso@candygram> {/usr/projects/linux/linux-2.6}  [master]
39% git new
git: 'new' is not a git-command

The most commonly used git commands are:
    add            Add file contents to the changeset to be committed next
    apply          Apply a patch on a git index file and a working tree
    archive        Creates an archive of files from a named tree
	...

<tytso@candygram> {/usr/projects/linux/linux-2.6}  [master]
40% tail .git/config 

[user]
        name = Theodore Ts'o
        email = tytso@mit.edu

[remote "iwlwifi"]
        url = http://bughost.org/repos/iwlwifi.git/
        fetch = +refs/heads/*:refs/remotes/iwlwifi/*
[alias]
        new = gitk --all --not ORIG_HEAD
					
