From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Change "pull" to _only_ download, and "git update"=pull+merge?
Date: Wed, 20 Apr 2005 22:05:04 +0200
Message-ID: <20050420200504.GB19112@pasky.ji.cz>
References: <20050416233305.GO19099@pasky.ji.cz> <Pine.LNX.4.21.0504161951160.30848-100000@iabervon.org> <20050419011206.GT5554@pasky.ji.cz> <42646967.9030903@dwheeler.com> <4264CCFF.30400@dgreaves.com> <20050419092812.GE2393@pasky.ji.cz> <1113905110.1262.1.camel@nosferatu.lan> <20050419105008.GB12757@pasky.ji.cz> <20050420070157.GA12584@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Schlemmer <azarah@nosferatu.za.org>,
	David Greaves <david@dgreaves.com>, dwheeler@dwheeler.com,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 22:01:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOLNe-00030m-QH
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 22:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVDTUFR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 16:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVDTUFR
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 16:05:17 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41692 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261773AbVDTUFK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 16:05:10 -0400
Received: (qmail 27275 invoked by uid 2001); 20 Apr 2005 20:05:04 -0000
To: Ingo Molnar <mingo@elte.hu>
Content-Disposition: inline
In-Reply-To: <20050420070157.GA12584@elte.hu>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Apr 20, 2005 at 09:01:57AM CEST, I got a letter
where Ingo Molnar <mingo@elte.hu> told me that...
>  [...]
>  fatal: unable to execute 'gitmerge-file.sh'
>  fatal: merge program failed

Pure stupidity of mine, I forgot to add gitmerge-file.sh to the list of
scripts which get installed.

> another thing: it's confusing that during 'git pull', the rsync output 
> is not visible. Especially during large rsyncs, it would be nice to see 
> some progress. So i usually use a raw rsync not 'git pull', due to this.

Fixed. For further reference, you can also set RSYNC_FLAGS and put
whatever pleases you there.

> yet another thing: what is the canonical 'pasky way' of simply nuking 
> the current files and checking out the latest tree (according to 
> .git/HEAD). Right now i'm using a script to:
> 
>   read-tree $(tree-id $(cat .git/HEAD))
>   checkout-cache -a
> 
> (i first do an 'rm -f *' in the working directory)
> 
> i guess there's an existing command for this already?

git cancel

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
