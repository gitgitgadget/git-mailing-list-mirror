From: Petr Baudis <pasky@suse.cz>
Subject: Re: Moving a file back to an earlier revision.
Date: Sun, 2 Apr 2006 01:01:44 +0200
Message-ID: <20060401230144.GL27689@pasky.or.cz>
References: <4dd15d180603311313t7781f2ebk616276e9134f6472@mail.gmail.com> <4dd15d180603311332p60fa1867nc303bd92d515b4e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 02 01:01:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPp6E-0001z4-RS
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 01:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWDAXB2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Apr 2006 18:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbWDAXB1
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Apr 2006 18:01:27 -0500
Received: from w241.dkm.cz ([62.24.88.241]:27829 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751642AbWDAXBZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Apr 2006 18:01:25 -0500
Received: (qmail 26076 invoked by uid 2001); 2 Apr 2006 01:01:44 +0200
To: David Ho <davidkwho@gmail.com>
Content-Disposition: inline
In-Reply-To: <4dd15d180603311332p60fa1867nc303bd92d515b4e0@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18250>

Dear diary, on Fri, Mar 31, 2006 at 11:32:16PM CEST, I got a letter
where David Ho <davidkwho@gmail.com> said that...
> Sorry I might already have found it.
> 
> File revisions
> 
> +----+----+
> 1    2    3
> 
> git diff commit(3)..commit(1) filename | git-apply

Note that it might be more convenient to just say "restore the file to
the contents as of commit X" - in pure Git this would involve dances
with git-ls-tree and git-cat-file, I'm not sure if the core Git
porcelain has an interface for doing this easily.

In Cogito, you can just do:

	cg-restore -f -r commitid filename

-- 
				Petr "Pasky on a dialup" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
