From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Change "pull" to _only_ download, and "git update"=pull+merge?
Date: Wed, 20 Apr 2005 22:45:51 +0200
Message-ID: <20050420204551.GA13944@elte.hu>
References: <20050416233305.GO19099@pasky.ji.cz> <Pine.LNX.4.21.0504161951160.30848-100000@iabervon.org> <20050419011206.GT5554@pasky.ji.cz> <42646967.9030903@dwheeler.com> <4264CCFF.30400@dgreaves.com> <20050419092812.GE2393@pasky.ji.cz> <1113905110.1262.1.camel@nosferatu.lan> <20050419105008.GB12757@pasky.ji.cz> <20050420070157.GA12584@elte.hu> <20050420200504.GB19112@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Schlemmer <azarah@nosferatu.za.org>,
	David Greaves <david@dgreaves.com>, dwheeler@dwheeler.com,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 22:42:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOM1E-0001Zc-Qu
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 22:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVDTUqN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 16:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVDTUqN
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 16:46:13 -0400
Received: from mx1.elte.hu ([157.181.1.137]:1213 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261798AbVDTUqJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 16:46:09 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id 5557731D858;
	Wed, 20 Apr 2005 22:45:10 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 74E041FC2; Wed, 20 Apr 2005 22:45:54 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050420200504.GB19112@pasky.ji.cz>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Petr Baudis <pasky@ucw.cz> wrote:

> Dear diary, on Wed, Apr 20, 2005 at 09:01:57AM CEST, I got a letter
> where Ingo Molnar <mingo@elte.hu> told me that...
> >  [...]
> >  fatal: unable to execute 'gitmerge-file.sh'
> >  fatal: merge program failed
> 
> Pure stupidity of mine, I forgot to add gitmerge-file.sh to the list of
> scripts which get installed.

another thing is this annoying message:

 rsync: link_stat "/linux/kernel/people/torvalds/git.git/tags" (in pub) 
 failed: No such file or directory (2)
 rsync error: some files could not be transferred (code 23) at 
 main.c(812)
 client: nothing to do: perhaps you need to specify some filenames or 
 the --recursive option?

you said before that it's "harmless", but it's annoying nevertheless as 
one doesnt know for sure whether the pull went fine.

	Ingo
