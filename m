From: "Sean Kelley" <svk.sweng@gmail.com>
Subject: Re: Cherry-picking to remote branches
Date: Fri, 6 Jul 2007 10:10:00 -0500
Message-ID: <a2e879e50707060810v6b3f0a9ctda4f3fa12c284e0e@mail.gmail.com>
References: <a2e879e50707060709oc9fe8b3k8e594f1cb6e10437@mail.gmail.com>
	 <Pine.LNX.4.64.0707061524180.4093@racer.site>
	 <a2e879e50707060739s4c8e751dj494618d3d545277b@mail.gmail.com>
	 <20070706150155.GV32766@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: VMiklos <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jul 06 17:10:17 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6pRh-0001mq-19
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 17:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756234AbXGFPKE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 11:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754850AbXGFPKE
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 11:10:04 -0400
Received: from nz-out-0506.google.com ([64.233.162.224]:41129 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755917AbXGFPKB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 11:10:01 -0400
Received: by nz-out-0506.google.com with SMTP id s18so228157nze
        for <git@vger.kernel.org>; Fri, 06 Jul 2007 08:10:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nCDII+Xx2SYGkMp7jlqUdNGMFfrGfCKo5YmhesVAFgJ/wke7KLgeDgqZAguUq8cMKZp7g1Q1tDWMo1m1lrJoZ2NeEmV7OAL3DW/V7J7IAkuvvVSJOoDfa1dHBqg7MORVd6wwi17iMEw3MRCGHz2HALCjRMIwNoBRciYCoB/Gqrg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CVr+TtINd33H+WLKQzygrIjusDLRY1FVZwZQR0p4D8C6uP5TPIDI7dPRHsiuEZeh81KIC0cqsz0zZq7XLXmOXxXnZCaLU4xHizN+Tyrx9j9EJXbEZTqiH5F99iESpffZ0REDFFTKF1A1L3WzMN5BvdKYuevkKTXrdgurwMHDnrY=
Received: by 10.115.108.1 with SMTP id k1mr732766wam.1183734600300;
        Fri, 06 Jul 2007 08:10:00 -0700 (PDT)
Received: by 10.114.203.4 with HTTP; Fri, 6 Jul 2007 08:10:00 -0700 (PDT)
In-Reply-To: <20070706150155.GV32766@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51761>

Hi,

On 7/6/07, VMiklos <vmiklos@frugalware.org> wrote:
> Na Fri, Jul 06, 2007 at 09:39:47AM -0500, Sean Kelley <svk.sweng@gmail.com> pisal(a):
> >> > git checkout -b stable linux-stable/master
> >> >
> >> > git cherry-pick  b3b1eea69a   (a commit from linux-devel)
> >> >
> >> > git push linux-stable
> >> >
> >> > error: remote 'refs/heads/master' is not a strict subset of local ref
> >> > 'refs/heads/master'. maybe you are not up-to-date and need to pull
> >> > first?
> >> > error: failed to push to 'git://mysite.com/data/git/linux-stable.git'
> >>
> >> Since you are obviously only interested in pushing the stable branch, why
> >> don't you
> >>
> >>         git push linux-stable stable
> >>
> >> Hm?
> >>
> >> If you do not specify which branches to push, "git push" will find all
> >> refnames which are present both locally and remotely, and push those.
> >> Evidently, however, your local "master" disagrees with the remote
> >> "master".
> >
> > It is not entirely clear to me from the documentation.  So I was
> > trying to cobble together something that seemed to make sense.  I want
> > to work from the devel clone.  On occasion I want to cherry-pick
> > changesets and push those to the stable branch.  I don't want
> > everything that goes into devel to go into stable.
>
> what about this?
>
>         git push linux-stable stable:master

That creates a new head on my remote server.  Where as I wanted to
push to the remotes head.

Sean
>
> VMiklos
>
> --
> developer of Frugalware Linux - http://frugalware.org
>
>
