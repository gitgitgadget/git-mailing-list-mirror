From: Junio C Hamano <gitster@pobox.com>
Subject: Re: '.git file' alternative, native (cross-platform)
 workdir support.
Date: Fri, 29 Feb 2008 12:02:42 -0800
Message-ID: <7vabljcyzh.fsf@gitster.siamese.dyndns.org>
References: <47C7FA49.9010001@trolltech.com> <alpine.LSU.1.00.0802291248510.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marius Storm-Olsen <marius@trolltech.com>,  Git Mailing List <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Fri Feb 29 21:03:34 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ag-out-0910.google.com ([72.14.246.186])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVBS7-000299-Sh
	for gcvm-msysgit@m.gmane.org; Fri, 29 Feb 2008 21:03:32 +0100
Received: by ag-out-0910.google.com with SMTP id 32so4234186agc.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 29 Feb 2008 12:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:from:to:cc:subject:references:date:in-reply-to:message-id:user-agent:mime-version:content-type:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=bQY9+zdHwrl8I+igetiNTYFtuNW6aaziqXiqIbDGjlc=;
        b=Y9Icgs5sBkiXaFCvvBw2ULk8FoakB6DCD5BSNf50VSsv5Kn7FQGo7A4n2DNW36YlnhNjI/la4nbFLn25wphJY6E87iWU8lVkhfbIB0LqSrSSKl6OYhF1IJaCpl0blIw9vyYtmk8BoSA8A11I5qSyOqHEtNHZgTXDb488qA3q/ZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from:to:cc:subject:references:date:in-reply-to:message-id:user-agent:mime-version:content-type:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=xZER7RVHYUqwkqmxe0elsAPBWhgwfbFCRBszHBd0NGawSk+tM4Z7R8TzltvKAG6NYPZpqPGBqlcuezRLr++4MS0ICg9rhaKShQiCyhyBFu+6zToRJ9AgS/piTAmw93DWIpPrK9eVhkRYg7fotKrNExG4BZOiDyuoKyZ3PewVLZ0=
Received: by 10.100.164.10 with SMTP id m10mr886144ane.3.1204315376023;
        Fri, 29 Feb 2008 12:02:56 -0800 (PST)
Received: by 10.106.177.2 with SMTP id z2gr1861pre.0;
	Fri, 29 Feb 2008 12:02:55 -0800 (PST)
X-Sender: gitster@pobox.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.193.1 with SMTP id q1mr7577288waf.27.1204315375500; Fri, 29 Feb 2008 12:02:55 -0800 (PST)
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com [207.106.133.19]) by mx.google.com with ESMTP id k36si3268006waf.0.2008.02.29.12.02.54; Fri, 29 Feb 2008 12:02:55 -0800 (PST)
Received-SPF: pass (google.com: domain of gitster@pobox.com designates 207.106.133.19 as permitted sender) client-ip=207.106.133.19;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of gitster@pobox.com designates 207.106.133.19 as permitted sender) smtp.mail=gitster@pobox.com
Received: from localhost.localdomain (localhost [127.0.0.1]) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2FBBD2E4F; Fri, 29 Feb 2008 15:02:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77]) (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 310C02E4C; Fri, 29 Feb 2008 15:02:45 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802291248510.22527@racer.site> (Johannes Schindelin's message of "Fri, 29 Feb 2008 12:54:11 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75556>


Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 29 Feb 2008, Marius Storm-Olsen wrote:
>
>> I just caught a glimpse of the '.git file' efforts, as a file for 
>> redirection to a real repository.
>> 
>> As far as I can tell, the reason for adding the support is to in the end 
>> provide a cross-platform way of supporting workdirs. (If this is not the 
>> [main] point, please point me to the thread describing the real reason, 
>> I couldn't find it.)
>
> This is the main reason, yes.

I do not think so.  For repository and work tree separation, we already
have core.worktree.  Multiple work trees attached to a single repository
is what contrib/workdir/ does, and it could probably be extended, but that
one needs more than "redirect .git elsewhere".

The primary reason we may want to do the ".git file" thing is to sanely
support switching between branches (or checking out a different revision,
which amounts to the same thing) when one has a submodule and the other
one either does not have that submodule anywhere or have it in a different
location in its tree.

Suppose the HEAD one binds a submodule "gitk" at gitk-git.  Then suppose
we want to switch to an old branch that did not have that submodule bound
yet.  Or the branch we are switching to has the submodule at modules/gitk.
What happens?

Currently, when we are on HEAD, we create a directory at gitk-git and make
gitk-git/.git directory its controlling repository (i.e. GIT_DIR).
Switching to a branch that did not have the submodule bound will need to
rmdir gitk-git (this needs to happen no matter what) but as a side effect
we will lose gitk-git/.git repository.  Switching back to where we were
would require reloading that repository from somewhere else, but if you
are "the upstream", that somewhere else may not even exist.

One way to solve this would be to add .git/submodules/paulus.git
repository inside the controlling reopsitory of the toplevel project, and
point that with the ".git file" installed at gitk-git/.git, when we are on
HEAD.  We can lose gitk-git directory and everything below it when
switching away from the revision, but when we come back, we can recreate
gitk-git directory, point gitk-git/.git back to .git/submodules/paulus.git
kept in the toplevel repository, and check the appropriate commit out there.

After switching to an old revision that did not have the submodule,
further switching to a branch that has the submodule at modules/gitk would
be the same deal.  Instead of creating gitk-git directory and installing
the ".git file" there (which is what we did when we came back to the
original HEAD), create modules/gitk and install the ".git file" there, to
point at the same .git/submodules/paulus.git/.

We should be able to do this today without ".git file" using symlinks.
It's just a Porcelain hackery, so I'll leave it to interested parties as
an exercise.
