From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] commit: detect misspelled pathspec while making a partial commit.
Date: Tue, 14 Feb 2006 22:25:52 +0100
Message-ID: <20060214212552.GH31278@pasky.or.cz>
References: <7vfymlr7n8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 22:25:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F97fb-0003KD-Pm
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 22:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422796AbWBNVZH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 16:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422685AbWBNVZH
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 16:25:07 -0500
Received: from w241.dkm.cz ([62.24.88.241]:55983 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1422796AbWBNVZF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 16:25:05 -0500
Received: (qmail 12284 invoked by uid 2001); 14 Feb 2006 22:25:52 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfymlr7n8.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16177>

Dear diary, on Tue, Feb 14, 2006 at 09:46:03PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> When you say "git commit Documentaiton" to make partial commit
> for the files only in that directory, we did not detect that as
> a misspelled pathname and attempted to commit index without
> change.  If nothing matched, there is no harm done, but if the
> index gets modified otherwise by having another valid pathspec
> or after an explicit update-index, a user will not notice
> without paying attention to the "git status" preview.
> 
> This introduces --error-unmatch option to ls-files, and uses it
> to detect this common user error.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> 
> ---
> 
>  * Pasky, does this address the issue you mentioned earlier on
>    the #git channnel?

Yes, this is what I meant. I actually have no practical experience with
this since I'm not a git-commit user, I merely expressed horror ;) on
what you mentioned during the night. BUT it turns out that this affects
Cogito as well, albeit in a milder version - only when you pass multiple
explicit paths to cg-commit and some of them are misspelled, they are
ignored quietly (unless all of them are misspelled).

So, thanks for the fix on behalf of Cogito users as well. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
