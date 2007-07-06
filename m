From: "Sean Kelley" <svk.sweng@gmail.com>
Subject: Re: Cherry-picking to remote branches
Date: Fri, 6 Jul 2007 09:39:47 -0500
Message-ID: <a2e879e50707060739s4c8e751dj494618d3d545277b@mail.gmail.com>
References: <a2e879e50707060709oc9fe8b3k8e594f1cb6e10437@mail.gmail.com>
	 <Pine.LNX.4.64.0707061524180.4093@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 06 16:40:14 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6oyi-0002w9-Hc
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 16:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755956AbXGFOju (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 10:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755917AbXGFOjt
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 10:39:49 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:7004 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754843AbXGFOjs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 10:39:48 -0400
Received: by wa-out-1112.google.com with SMTP id v27so290720wah
        for <git@vger.kernel.org>; Fri, 06 Jul 2007 07:39:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NrI9ig9BUWAB4Uc6xYK+iJYkHU5eZ2+Mj1n8qmvqD4Gk87dv6bKZ1R3/3C4mlN7Em4sc9w0b+YVuZfFLxBbSE6vqapRtkIiUz0+nIH5JWRpm7OvZrn3C2yzD1P2kxZlHx3OFJ4CWfW/qBZvRBIf268/OnsuN7msmArDFdRXSwi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i26V4QLo3llN6/Hl4QtffujxexTaU56TGJYx8+/hvS/9Tu2a/hAJg4iDWvS7FmWIqeGcCnEv9nZH2XedO/MLPDlbUl9cZO1h2Hr+WGhklmkHDYO9NxKuh5GatwzQNmyjrCvuWAjkdUM42cAUbXENtHQtXtdGtfQPq9/9iYNo0Qo=
Received: by 10.114.25.3 with SMTP id 3mr714998way.1183732787916;
        Fri, 06 Jul 2007 07:39:47 -0700 (PDT)
Received: by 10.114.203.4 with HTTP; Fri, 6 Jul 2007 07:39:47 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707061524180.4093@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51753>

Hi

On 7/6/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 6 Jul 2007, Sean Kelley wrote:
>
> > [...]
> >
> > git checkout -b stable linux-stable/master
> >
> > git cherry-pick  b3b1eea69a   (a commit from linux-devel)
> >
> > git push linux-stable
> >
> > error: remote 'refs/heads/master' is not a strict subset of local ref
> > 'refs/heads/master'. maybe you are not up-to-date and need to pull
> > first?
> > error: failed to push to 'git://mysite.com/data/git/linux-stable.git'
>
> Since you are obviously only interested in pushing the stable branch, why
> don't you
>
>         git push linux-stable stable
>
> Hm?
>
> If you do not specify which branches to push, "git push" will find all
> refnames which are present both locally and remotely, and push those.
> Evidently, however, your local "master" disagrees with the remote
> "master".

It is not entirely clear to me from the documentation.  So I was
trying to cobble together something that seemed to make sense.  I want
to work from the devel clone.  On occasion I want to cherry-pick
changesets and push those to the stable branch.  I don't want
everything that goes into devel to go into stable.

Sean
>
> Hth,
> Dscho
>
>
