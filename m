From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: failed to push
Date: Tue, 02 Mar 2010 11:09:15 -0800 (PST)
Message-ID: <m3tysylexh.fsf@localhost.localdomain>
References: <4B8C2E68.3020507@gnu.org> <4B8C303E.7050605@gmail.com>
	<a038bef51003011342j3d761d0cmd96d8641f96ed15@mail.gmail.com>
	<4B8C38E5.7090305@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Packham <judge.packham@gmail.com>, GIT <git@vger.kernel.org>
To: bkorb@gnu.org
X-From: git-owner@vger.kernel.org Tue Mar 02 20:09:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmXTF-0004XU-5Z
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 20:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab0CBTJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 14:09:23 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:59869 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab0CBTJW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 14:09:22 -0500
Received: by bwz1 with SMTP id 1so18454bwz.21
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 11:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=V3mdDvhAcMrozhmNq4k0lmtHTWgacWlVVeEfoegjmPg=;
        b=bAR8UKF7uhMgaaUOuHXld9GbLSreNjFZ3FyvGzr221IaDFBFDEBuxo21il6JwaiLAP
         c4T6zdJ/aMvop/PXmLbw5emnTkjRd6TQZ+xHBjxdw8Rh/6ob7yvAExznnAAVSadUy/Rr
         K2vhPnX+o8Bm7qgsIWl8PK7ZfP+gbpit2NukE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=wvvc4tSzcgZvYo+1QiIQ5JlFg0Sf7irNJ4vE8HYXKsmxqmwdN/5folkpm43kPFKwn9
         rp3ALJbfN+Qpsf4S+uKnT3DXd3wts6+PnOARjFhMAVzN8k43yYym355Nzxib2sX7RmFR
         pAjxihMWGP4ctScekm1yiMMYv7iLrSBtHT32Y=
Received: by 10.204.36.70 with SMTP id s6mr60618bkd.22.1267556960583;
        Tue, 02 Mar 2010 11:09:20 -0800 (PST)
Received: from localhost.localdomain (abvb141.neoplus.adsl.tpnet.pl [83.8.199.141])
        by mx.google.com with ESMTPS id 15sm3112427bwz.0.2010.03.02.11.09.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Mar 2010 11:09:15 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o22J8go3017843;
	Tue, 2 Mar 2010 20:08:48 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o22J8RoL017827;
	Tue, 2 Mar 2010 20:08:27 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4B8C38E5.7090305@gnu.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141409>

Bruce Korb <bkorb@gnu.org> writes:
> Chris Packham wrote:
> >>> To ssh://bkorb@autogen.git.sourceforge.net/gitroot/autogen/autogen
> >>>  ! [rejected]        master -> master (non-fast forward)
> >>> error: failed to push some refs to 'ssh://bkorb@autogen.git.sourceforge.net/gitroot/autogen/autogen'
> 
> CF:
> > It tells you right there at the end of the rejected line. The push
> > would have resulted in a non-fast-forward update of the branch.
> 
> "non-fast forward" is not very helpful either.

It is part of git jargon, and can be found in gitglossary.
 
> > This basically means that the push you have attempted is not a simple
> > fast forward. This basically means that the commit your work is based
> > on is not present in the remote or that there have been other pushes
> > to the remote and you need to pull them into your repository to handle
> > any merging.
> 
> Since the sequence was:
>   git commit
>   git push
>   <more editing>
>   git commit --amend
>   git push
> 
> the neophyte (me) is not going to know that this produces an un-pulled
> delta.

Well, all of us old gitters know: 1) that you should not change
published (pushed) history, 2) that commits are immutable, and 3) that
amending a commit generates new commit with correction and therefore
changes history.

It is true that git documentation ("Git User's Manual", "Git Community
Book", "Pro Git") can be lacking... unfortunately by the time somebody
is knowledgeable enough to write git documentaions, he/she is usally
used to git way of doing things, and the documentation might not be
newbie-friendly.
 
> > In a DVCS like git all commits happen locally, the only time commits
> > are sent to the remote repo are when you've pushed so 'git commit
> > --amend' or 'git gui' with the amend box ticked only makes the change
> > locally it won't implicitly figure out that a commit has been pushed
> > out into the ether. One rule of thumb with git (I think it applies to
> > most DVCSes) is not to amend a commit that has been pushed for this
> > very reason.
> 
> Then please be kind enough to put a *CAUTION* button next to
> the amend button and have it bring up something that gives you
> a little warning.  GIT *could* have been written in a way that
> causes the remote repo to become synced with my local repo,
> but apparently it was not and there was not adequate warning.

What git-gui (and other git interaces) could do is to check if there
is indicator that the part of history you want to change (via amending
a commit, or via [interactive] rebase) is published.  On the other
hand you probably would not want for git to access network to check it
before history-rewriting commands...
 
> > Strictly speaking all commits are immutable, when you
> > amend a commit you actually create a whole new commit and your old one
> > is marked for garbage collection (if nothing else is based off it).
> > 
> > In terms of recovering from your present situation I'd try the
> > following (Disclaimer: maybe you shouldn't try these based solely on
> > my advice. I'm still learning too)
> > 
> >   git pull
> >   <resolve merge issue, 'git mergetool' is your friend>
> >   git push
> > 
> >   I think this will basically sort things out but you may need to hand
> > hold a few things through a merge depending on how different the 2
> > commits are.
> 
> I will be trying this procedure momentarily.  Meanwhile, since I am
> the only person on the planet authorized to commit to the public repo:
> 
> >  - or -
> > 
> >   git push -f
> 
> This fails with the same "non-fast forward" rejection message.  :(

Whether you are able to force pushing non fast-forward changes depends
on configuration on remote side (receive.denyNonFastForwards), and on
the update / pre-receive hooks which can also forbid forcing non
fasf-forward changes.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
