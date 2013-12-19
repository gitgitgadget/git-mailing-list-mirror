From: Johan Herland <johan@herland.net>
Subject: Re: I have end-of-lifed cvsps
Date: Thu, 19 Dec 2013 02:11:53 +0100
Message-ID: <CALKQrgdin=8h9dr=h+VfGjX3suOGRXNsvzzcF=_L9cQDYtKPgg@mail.gmail.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com>
	<CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
	<20131212042624.GB8909@thyrsus.com>
	<CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
	<52B02DFF.5010408@gmail.com>
	<CALKQrgf3kuXRpbWmSp_nk8+zDFYNzkgV+dSBHaBbmUkxqjaDUA@mail.gmail.com>
	<20131217145809.GC15010@thyrsus.com>
	<CALKQrgeegcsO7YVqEmQxD4=HfR4eitodAov0tEh7MRvBxtRKUA@mail.gmail.com>
	<20131217184724.GA17709@thyrsus.com>
	<52B2335D.2030607@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Raymond <esr@thyrsus.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Dec 19 02:12:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtS9t-0007XS-FE
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 02:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050Ab3LSBMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 20:12:08 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:41723 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872Ab3LSBMH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 20:12:07 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VtS9g-0004ai-FS
	for git@vger.kernel.org; Thu, 19 Dec 2013 02:12:01 +0100
Received: from mail-pd0-f175.google.com ([209.85.192.175])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VtS9d-000Euk-U1
	for git@vger.kernel.org; Thu, 19 Dec 2013 02:11:58 +0100
Received: by mail-pd0-f175.google.com with SMTP id w10so404028pde.6
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 17:11:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IzeSAT73leCxg6xo8hVlurjUE/MxC8lxWGYZEfb7A/8=;
        b=eudnZORBlVFtSD+8kdx/YzcW94wdV/FwPba36HTRBUVjeGzjk/ctICeteHATRHrRdV
         1/bcLs3VydJ6FdqPi6n7c9I+eJQKpJiOqSt9kqFBFY410A5ylT/bmRcNBeC/suV8ocC3
         m9ps33IXAwFI1n4F6hH2LnnTZ2agbndas7U0qKUOo0eB0t5yH1Xm+jeTUNdJJFEl5Yia
         nKdrkdV9q+cWOW3UO1LYvcugp/3l1khsv+GTYWfTo944k4XI6vcImyVeHNQaPmqzeQbo
         mcDxNLIpYYyjsm2VFi90YR0okZEUf3+WhNtmJJ6Z5DEIsTm8TQY8xA+1Adfdsnp4lGyi
         5F/A==
X-Received: by 10.68.134.200 with SMTP id pm8mr37883804pbb.123.1387415514001;
 Wed, 18 Dec 2013 17:11:54 -0800 (PST)
Received: by 10.70.24.226 with HTTP; Wed, 18 Dec 2013 17:11:53 -0800 (PST)
In-Reply-To: <52B2335D.2030607@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239510>

On Thu, Dec 19, 2013 at 12:44 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> A correct incremental converter could be done (as long as the CVS users
> don't literally change history retroactively) but it would be a lot of work.

Although I agree with that sentence as it is stated, I also believe
that the parenthesized condition rules out a _majority_ of CVS repo of
non-trivial size/history. So even though a correct incremental
converter could be built, it would be pretty much useless if it did
not gracefully handle rewritten history. And in the face of rewritten
history it becomes pretty much impossible to define what a "correct"
conversion should even look like (not to mention the difficulty of
actually implementing that converter...).

Here are just a couple of things a CVS user can do (and that happened
fairly regularly at my previous $dayjob) that would make life
difficult for an incremental converter (and that also makes stable
output from a non-incremental converter hard to solve in practice):

 - A user "deletes" $file from $branch by simply removing the $branch
symbol on $file (cvs tag -B -d $branch $file). CVS stores no record of
this. Many non-incremental importers will see $file as never having
existed on $branch. An incremental importer starting from a previously
converted state, must somehow deal with that previous state no longer
existing from the POV of CVS.

 - A user moves a release tag on a few files to include a late bugfix
into an upcoming release (cvs tag -F -r $new_rev $tag $file). There
might be no single point in time where the tagged state existed in the
repo, it has become a "Frankentag". You could claim user error here,
and that such shortcuts should not happen, but that doesn't really
prevent it from ever happening. Recreating the tree state of the
Frankentag in Git is easy, but what kind of history do you construct
to lead up to that tree?

 - A modularized project develops code on HEAD, and make regular
releases of each module by tagging the files in the module dir with
"$modulename-$version". Afterwards a project-wide "stable" tag is
moved on that subset of files to include the new module release into
the "stable" tag. ("stable" is conceptually a branch, but the CVS
mechanism used here is still the tag, since CVS branches cannot
"follow" eachother like in Git). This is pretty much the same
Frankentag scenario as above, except that in this case it might be
considered Best Practice (it was at our $dayjob), and not a
shortcut/user error made by a single user.

(None of these examples even involve the "cvs admin" which allows you
to do some truly scary and demented things to your CVS history...)

My point here is that people will use whatever available tools they
have to solve whatever problems they are currently having. And when
CVS is your tool, you will sooner or later end up with a "solution"
that irrevocably rewrites your CVS history.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
