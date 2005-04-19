From: Petr Baudis <pasky@ucw.cz>
Subject: Re: GIT Web Interface
Date: Tue, 19 Apr 2005 02:52:45 +0200
Message-ID: <20050419005244.GR5554@pasky.ji.cz>
References: <20050419004415.GA10628@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 02:53:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNgz4-0005rI-1m
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 02:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVDSA4o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 20:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVDSAyd
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 20:54:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57010 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261235AbVDSAwu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 20:52:50 -0400
Received: (qmail 27715 invoked by uid 2001); 19 Apr 2005 00:52:45 -0000
To: Kay Sievers <kay.sievers@vrfy.org>
Content-Disposition: inline
In-Reply-To: <20050419004415.GA10628@vrfy.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 19, 2005 at 02:44:15AM CEST, I got a letter
where Kay Sievers <kay.sievers@vrfy.org> told me that...
> I'm hacking on a simple web interface, cause I missed the bkweb too much.
> It can't do much more than browse through the source tree and show the
> log now, but that should change... :)
>   http://ehlo.org/~kay/gitweb.pl?project=linux-2.6

Hmm, looks nice for a start. (But you have obsolete git-pasky tree there! ;-)

> How can I get the files touched with a changeset and the corresponding
> diffs belonging to it?

diff-tree to get the list of files, you can do the corresponding diffs
e.g. by doing git diff -r tree1:tree2. Preferably make a patch for it
first to make it possible to diff individual files this way.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
