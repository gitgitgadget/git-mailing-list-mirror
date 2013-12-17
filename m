From: Johan Herland <johan@herland.net>
Subject: Re: I have end-of-lifed cvsps
Date: Tue, 17 Dec 2013 22:26:57 +0100
Message-ID: <CALKQrgeRKosOSOhcbUArkh03mwJLPkcOH-DROCCnmbTdQ8afyg@mail.gmail.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com>
	<CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
	<20131212042624.GB8909@thyrsus.com>
	<CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
	<52B02DFF.5010408@gmail.com>
	<CALKQrgf3kuXRpbWmSp_nk8+zDFYNzkgV+dSBHaBbmUkxqjaDUA@mail.gmail.com>
	<20131217145809.GC15010@thyrsus.com>
	<CALKQrgeegcsO7YVqEmQxD4=HfR4eitodAov0tEh7MRvBxtRKUA@mail.gmail.com>
	<20131217184724.GA17709@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Tue Dec 17 22:27:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vt2AY-0007sd-Mu
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 22:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472Ab3LQV1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 16:27:06 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:38088 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab3LQV1E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 16:27:04 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1Vt2AP-0000AD-QV
	for git@vger.kernel.org; Tue, 17 Dec 2013 22:27:01 +0100
Received: from mail-pa0-f44.google.com ([209.85.220.44])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Vt2AP-0009dP-H2
	for git@vger.kernel.org; Tue, 17 Dec 2013 22:27:01 +0100
Received: by mail-pa0-f44.google.com with SMTP id fa1so5041043pad.3
        for <git@vger.kernel.org>; Tue, 17 Dec 2013 13:26:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zQWFhz5hG68esQBcwXWTX8+uqhLsT85Cl4h6ItaulVg=;
        b=f9Tm24Pe3Uin8TJbPMH14IQCFSzqx/iUTGKt+CDtvUiVziqUORzrsKg4KZPMFaeJHE
         lKFWVs21M/nf4W463Iu1mGKYpSOAHdxJS6gdr6aw+jX0MyA1l9hZXbgXcORd2Upskvnz
         6h87B85aLdxiQ4+D8f3mn08zIYhGus/rNH+d6h7WVBBhoMcI4ZoD1ejBTPQRIi0ib/G6
         SFtld9Imxz8N05nsNXvuZV0bmnl8pHZJIZ6Y+GDwOXvpw/Fn/mDXSNW7WPnZmo8U5WnF
         CXc0lMIZ6xL+v97acq6OJ+EPu4dGIIJAr9wS+hD75u598SmzO5sVe1gNUlCjHRabMOaO
         RL3Q==
X-Received: by 10.68.212.37 with SMTP id nh5mr30015504pbc.16.1387315617476;
 Tue, 17 Dec 2013 13:26:57 -0800 (PST)
Received: by 10.70.24.226 with HTTP; Tue, 17 Dec 2013 13:26:57 -0800 (PST)
In-Reply-To: <20131217184724.GA17709@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239405>

On Tue, Dec 17, 2013 at 7:47 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> I'm working with Alan Barret now on trying to convert the NetBSD
> repositories. They break cvs-fast-export through sheer bulk of
> metadata, by running the machine out of core.  This is exactly
> the kind of huge case that you're talking about.
>
> Alan and I are going to take a good hard whack at modifying cvs-fast-export
> to make this work. Because there really aren't any feasible alternatives.
> The analysis code in cvsps was never good enough. cvs2git, being written
> in Python, would hit the core limit faster than anything written in C.

Depends on how it organizes its data structures. Have you actually
tried running cvs2git on it? I'm not saying you are wrong, but I had
similar problems with my custom converter (also written in Python),
and solved them by adding multiple passes/phases instead of trying to
do too much work in fewer passes. In the end I ended up storing the
largest inter-phase data structures outside of Python (sqlite in my
case) to save memory. Obviously it cost a lot in runtime, but it meant
that I could actually chew through our largest CVS modules without
running out of memory.

> It is certainly the case that a sufficiently large CVS repo will break
> anything, like a star with a mass over the Chandrasekhar limit becoming a
> black hole :-)

:) True, although it's not the sheer size of the files themselves that
is the actual problem. Most of those bytes are (deltified) file data,
which you can pretty much stream through and convert to a
corresponding fast-export stream of blob objects. The code for that
should be fairly straightforward (and should also be eminently
parallelizable, given enough cores and available I/O), resulting in a
table mapping CVS file:revision pairs to corresponding Git blob SHA1s,
and an accompanying (set of) packfile(s) holding said blobs.

The hard part comes when trying to correlate the metadata for all the
per-file revisions, and distill that into a consistent sequence/DAG of
changesets/commits across the entire CVS repo. And then, of course,
trying to fit all the branches and tags into that DAG of commits is
what really drives you mad... ;-)

> The question is how common such supermassive cases are. My own guess is that
> the *BSD repos and a handful of the oldest GNU projects are pretty much the
> whole set; everybody else converted to Subversion within the last decade.

You may be right. At least for the open-source cases. I suspect
there's still a considerable number of huge CVS repos within
companies' walls...

> I find the very idea of writing anything that encourages
> non-history-correct conversions disturbing and want no part of it.
>
> Which matters, because right now the set of people working on CVS lifters
> begins with me and ends with Michael Rafferty (cvs2git),

s/Rafferty/Haggerty/?

> who seems even
> less interested in incremental conversion than I am.  Unless somebody
> comes out of nowhere and wants to own that problem, it's not going
> to get solved.

Agreed. It would be nice to have something to point to for people that
want something similar to git-svn for CVS, but without a motivated
owner, it won't happen.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
