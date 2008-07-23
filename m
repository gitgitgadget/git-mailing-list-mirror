From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2008
Date: Wed, 23 Jul 2008 13:06:42 +0200
Message-ID: <200807231306.43953.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <7vsku1gqny.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 13:07:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLcBw-0000EE-GD
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 13:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbYGWLGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 07:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752473AbYGWLGd
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 07:06:33 -0400
Received: from ik-out-1112.google.com ([66.249.90.182]:42768 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbYGWLGc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 07:06:32 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1801090ika.5
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 04:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vraS3erCnMUyzXImLYHiRrORxkldSITGb+RKQI5H0D0=;
        b=dKzrZoKK12+MWfEO5hWzumicEEHChQKkPh/74o3ftQ8kx9hL+tpXcxyQ1sFKp3VtG6
         FDTKkDn59maGQTTs7fa2SQ+P6L9MD/VReeAPEbUyIZQBcMotibwuYKgAXZvpfbEWfvm/
         EtVrV5SWB3H6inyY95dJpIe8/o73IahKZlTf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=FDFg3WM6v3wOB1kq1rkeZgN6RYlXCosZ0iT9Esij5AUkBQAQfwIqw2ixsJmmw5l6Qi
         L9NYxvxVY4No2NuCWlSXWeUDlseOnQ5lD7GWI0jhBQel6couclwjr2yuDmQNJ2SrJxtP
         hQdrXaJWodZdnORoyy9C4IHEPuhdjV6iBR51M=
Received: by 10.210.135.18 with SMTP id i18mr3939960ebd.122.1216811190208;
        Wed, 23 Jul 2008 04:06:30 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.213.1])
        by mx.google.com with ESMTPS id c14sm4593689nfi.16.2008.07.23.04.06.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 04:06:28 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vsku1gqny.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89630>

On Wed, 23 Jul 2008, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> >    15. What operating system do you use Git on?
> >        (one or more: multiple choice, as one can use more than one OS)
> >      - Linux, *BSD (FreeBSD, OpenBSD, etc.), MS Windows/Cygwin,
> >        MS Windows/msysGit, MacOS X, other UNIX, other
> 
> Shouldn't we at least name the ones we have specific support in our
> Makefile instead of blanketting them into one "other Unices"?  We may not
> necessarily want to list all of them, but at least major ones like SunOS,
> HP-UX and AIX deserve to be listed, methinks.

There will be a place to specify what "other Unices" one uses; in last
survey (see http://git.or.cz/gitwiki/GitSurvey2007) there were 5 SunOS
users, and only 1 for HP-UX and 1 for AIX (unless I have miscounted:
it was free form question in 2007 survey).

But perhaps it would be good idea to add Solaris, SunOS, AIX, HP-UX,
and perhaps also "MS Windows (unknown)" to the list.

> >      + "What hardware platforms do you use GIT on?" question was
> >        removed; should it stay?
> 
> I think the removal of "hardware platform" question is a good idea.

I was thinking about adding "Number of cores, and number of CPUs"
question instead; it might be also interesting how many people use
32-bit machine (e.g. i386), and how much 64-bit (e.g. x86_64).

But this is just curiosity; I don't think it matters to Git code what
machine it is run on.  Operating system info is more important, as
some of OS are either not POSIX, or have default filesystems with
strange features.

And I'd rather limit number of questions in the survey...

> >    24. If you want to see Git more widely used, what do you
> >        think we could do to make this happen?
> >      + Is this question necessary/useful?  Do we need wider adoption?
> 
> My stance on this has always been that wider adoption, even though it
> might eventually come as a consequence of being the best in the field, is
> never a goal.

O.K.  I'll remove this question, then.  Which is nice, as I'd rather
have this survey be shorter (it is easier both on survey takers, and
also later in survey analysis).

> >    27. Which of the following features do you use?
> >        (zero or more: multiple choice)
> >      - git-gui or other commit tool, gitk or other history viewer, patch
> >        management interface (e.g. StGIT), bundle, eol conversion,
> >        gitattributes, submodules, separate worktree, reflog, stash,
> >        shallow clone, detaching HEAD, mergetool, interactive rebase,
> >        add --interactive or other partial commit helper, commit
> >        templates, bisect, other (not mentioned here)
> >      + should probably be sorted in some resemblance of order
> >      + are there any new features which should be listed here?

I forgot about "keeping uncommitted changes in working tree", aka
"working with dirty tree" (I don't know if it is popular enough
to be included, but it _is_ one of distinguishing features).
 
> The above is a valid and interesting question, but "Which features do you
> find unique and useful ones, compared to other systems?" would be another
> interesting question to ask to people with experience with other systems.

Good idea.  I think I add it to the survey.

> >    28. If you use some important Git features not mentioned above,
> >        what are it?
> >        (free form)
> 
> "rerere"?

As it is not visible feature, one might use it without knowledge of it.
That is why I am reluctant to include it in the above list.  One can
always add it in free-form.

> >    40. Do you read the mailing list?
> >     -  yes/no
> 
> Which mailing list?  Do we want to ask about alternative lists?
> 
> I am not sure how and where, but I think j/egit should also be
> mentioned and/or asked about.

Good idea. So it would be... err, I realized that I don't know if
j/egit has separate mailing list, and what it is.  egit is listed
in "porcelains" one can use.

Nevertheless it would be good, I think, to expand list of possible
choices for this question:

    40. Do you read the mailing list?
        (multiple choice: zero or more; "none" is just in case)
     -  none/git@vger.kernel.org/Git For Human Beings/msysGit

-- 
Jakub Narebski
Poland
