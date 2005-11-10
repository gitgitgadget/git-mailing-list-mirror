From: Petr Baudis <pasky@suse.cz>
Subject: Re: Strange merge conflicts against earlier merge.
Date: Thu, 10 Nov 2005 11:20:43 +0100
Message-ID: <20051110102043.GQ30496@pasky.or.cz>
References: <46a038f90511091638k726d605r170717539225a712@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 10 11:20:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ea9Y0-0003UH-W0
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 11:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVKJKUp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 05:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVKJKUp
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 05:20:45 -0500
Received: from w241.dkm.cz ([62.24.88.241]:6629 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750767AbVKJKUp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 05:20:45 -0500
Received: (qmail 15413 invoked by uid 2001); 10 Nov 2005 11:20:43 +0100
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90511091638k726d605r170717539225a712@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11478>

Dear diary, on Thu, Nov 10, 2005 at 01:38:35AM CET, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> said that...
> We are working with a series of closely related heads, and merging
> among them. I am sometimes finding merge conflicts that I don't think
> I should be seeing. Assuming two branches, 'local' and 'remote', where
> local has with remote before (*), and I have no conflicting changes in
> local...
> 
>  1 - pull and merge from remote. The merge touches file A, B and C
>  2 - on local, develop on unrelated files O,P,Q, commit
>  3 - pull and merge from remote. The merge touches file B, C and D. I
> am sometimes seeing conflicts on file B and C, which was never touched
> on local.

Interesting. Could you check what the merge base is?

	git-merge-base local remote

It should be the merge from (1).

> For an example, clone
> http://locke.catalyst.net.nz/git/moodle.git#mdl-artena-tairawhiti and
> register also the
> http://locke.catalyst.net.nz/git/moodle.git#mdl-local branch. Create
> two heads:

Could you please run git-update-server-info over there?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
