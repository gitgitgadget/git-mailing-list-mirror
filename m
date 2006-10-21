From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 18:13:56 +0200
Message-ID: <200610211813.57374.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <453656F8.3000504@utoronto.ca> <20061021155624.GF29843@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	bazaar-ng@lists.canonical.com, Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, Petr Baudis <pasky@suse.cz>,
	Carl Worth <cworth@cworth.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 18:13:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbJTu-0007Kt-58
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 18:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992784AbWJUQNu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 12:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992785AbWJUQNu
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 12:13:50 -0400
Received: from hu-out-0506.google.com ([72.14.214.225]:46774 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S2992784AbWJUQNt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 12:13:49 -0400
Received: by hu-out-0506.google.com with SMTP id 28so575139hub
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 09:13:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=n3EjrL1+qxE733wEZ7TXZbMO1SerUOcOm4PqndHn8327BpENev+y4csCU4K+4okd0gKZnBDxPOKU3fji+VNC2s2KnGi4cj/rJHi11tx4LxyYESH1Ony68mqq9uy4oNDzeN5HW+IVy6I5+/p0ibufFpBuGxtbnHXlsLRx2ToIriI=
Received: by 10.67.93.7 with SMTP id v7mr3574855ugl;
        Sat, 21 Oct 2006 09:13:47 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id e34sm39605ugd.2006.10.21.09.13.46;
        Sat, 21 Oct 2006 09:13:47 -0700 (PDT)
To: Jan Hudec <bulb@ucw.cz>
User-Agent: KMail/1.9.3
In-Reply-To: <20061021155624.GF29843@artax.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29629>

Jan Hudec wrote:

> Also programmers usually don't develop even the single logical step as a
> single commit. Instead they they also commit to backup their work,

In git you can backup your work on temporary branch; besides there
is git commit --amend to correct last commit.

> when they try something they think they may in future return, when they
> need to continue on another computer and so on. And these commits are
> generally not logical steps. Also the steps are often not in a logical
> order. Therefore showing diff for each commit in the bundle often does
> not make sense.

That is why before sending patch series based on some feature branch,
you should at least rebase the branch on top of current work, to ensure
that the series would apply cleanly.

If feature branch/patch series needs cleanup (going from "answer" to
"solution" http://lkml.org/lkml/2005/4/7/176), i.e. patch (commit)
reordering, joining two patches into one, patch splitting, you can
use git-cherry-pick, git-cherry-pick --no-commit and git commit --amend
combination, or git-format-patch, patch editing and reordering, and git-am.
Or just use StGit or pg.

-- 
Jakub Narebski
Poland
