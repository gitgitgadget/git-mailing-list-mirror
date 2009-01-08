From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [PATCH (topgit)] tg-patch: add support for generating patches
	against worktree and index
Date: Thu, 8 Jan 2009 23:16:15 +0300
Organization: St.Petersburg State University
Message-ID: <20090108201614.GA4185@roro3>
References: <1231438975-13624-1-git-send-email-kirr@landau.phys.spbu.ru> <20090108195356.GA14644@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Git Mailing List <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Jan 08 21:49:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL1Ix-00073h-Mo
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 21:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759286AbZAHUPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 15:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762552AbZAHUPD
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 15:15:03 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:4371 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762321AbZAHUPA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 15:15:00 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id 443CE17B65E; Thu,  8 Jan 2009 23:14:59 +0300 (MSK)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.69)
	(envelope-from <kirr@roro3>)
	id 1LL1Id-00051O-0W; Thu, 08 Jan 2009 23:16:15 +0300
Content-Disposition: inline
In-Reply-To: <20090108195356.GA14644@lapse.rw.madduck.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104961>

On Fri, Jan 09, 2009 at 08:53:56AM +1300, martin f krafft wrote:
> also sprach Kirill Smelkov <kirr@landau.phys.spbu.ru> [2009.01.09.0722 +1300]:
> > This implements `tg patch -i` and `tg patch -w` to see current
> > patch as generated against not-yet-committed index and worktree.
> 
> I think at this early stage, it would make sense to use long options
> and not reserve short options yet. Unless Petr disagrees, I'd kindly
> ask you to use long options instead. Once TopGit has been around for
> a while, we can provide short options for the most important long
> options.
> 
> This is possibly too conservative, but I've been bitten by lack of
> new letters before because I've used them all up for options that
> later turned out not to be needed.

I agree, but when I found myself needing something like
`tg patch --index`, I've spot this in README:


    --- a/README
    +++ b/README
    @@ -284,8 +284,9 @@ tg patch
            tg patch will be able to automatically send the patches by mail
            or save them to files. (TODO)
    
    -       TODO: tg patch -i to base at index instead of branch,
    -               -w for working tree

So I concluded -i/-w was planned from the beginning.


I myself would call these options --index and --work or something
like that, but I'll be ok with any option.


Thanks,
Kirill
