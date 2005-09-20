From: Petr Baudis <pasky@suse.cz>
Subject: Re: GIT - breaking backward compatibility
Date: Tue, 20 Sep 2005 15:23:51 +0200
Message-ID: <20050920132351.GB1884@pasky.or.cz>
References: <7vpsr4cx0f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 15:25:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHi6S-0006SP-4n
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 15:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbVITNXy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 09:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbVITNXy
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 09:23:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10894 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964963AbVITNXx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 09:23:53 -0400
Received: (qmail 5546 invoked by uid 2001); 20 Sep 2005 15:23:51 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsr4cx0f.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8995>

Dear diary, on Tue, Sep 20, 2005 at 04:07:28AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> I raised the following issues in my previous messages but did
> not hear many opinions [*1*].  I do not want to take it as a
> blank check from the community to do whatever I please.  So here
> is a recap.

When I'm active on the mailing list, you can be sure that I'd complain
if I didn't like it. ;-)

>  * Tools renaming plan calls for removal of the backward
>    compatible command names (e.g. git-fsck-cache and
>    git-update-cache) sometime in the future.  This is scheduled
>    for 0.99.8 around beginning of October.  If somebody wants
>    extended amnesty period, this can be pushed back but unless I
>    hear otherwise...

I think the start of October is fine for Cogito. Cogito users usually
upgrade both Cogito and GIT at once, it seems.

>  * After reviewing the current set of commands, the following do
>    not seem to be useful anymore; Linus said he feels they can
>    go, and nobody else objected:
> 
>    git-diff-helper git-diff-stages git-export git-rev-tree
> 
>    I'd like to remove them before 1.0, and planning to do it
>    within the 0.99.8 timeframe unless I hear otherwise.

Cogito does not use any of those.

>  * After Brian Gerst posted a patch to show 'modified' files in
>    ls-files [*2*], there was a brief discussion to change the
>    tagged output markings to make them more readable, but
>    neither Cogito nor StGIT seems to use tagged output.  I am
>    currently thinking about removing '-t' altogether.
> 
>    Again, unless I hear otherwise, I'd like to remove it within
>    the 0.99.8 timeframe.

Well, if it should be kept, it should certainly be in sync with
git-diff-* tag letters. But Cogito uses only the diff tag letters and
I'm not sure if tag letters for all files in repository would really be
useful for anything.

> [Footnote]
> 
> *1* Well, Pasky indicated he does not like some of the terms in
> the glossary in his recent Cogito release announcement, but that
> was unfortunately after the fact.

Yes. I would complain loudly during the discussion, but I unwisely
skipped it at first and then didn't read the list for a few weeks.
My fault, I have to make the best way out of the terminology mess I'm
in now.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
