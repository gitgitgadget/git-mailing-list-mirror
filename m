From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2009 - trial run
Date: Fri, 26 Jun 2009 15:08:43 +0200
Message-ID: <200906261508.46176.jnareb@gmail.com>
References: <200906252122.51737.jnareb@gmail.com> <200906260932.43826.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Jun 26 15:10:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKBB7-0003Qt-PW
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 15:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565AbZFZNIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 09:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753510AbZFZNIr
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 09:08:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:57461 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357AbZFZNIq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 09:08:46 -0400
Received: by fg-out-1718.google.com with SMTP id e12so35347fga.17
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 06:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=BXRmhKrtIqzz5EySYIG9LxoMBuRXZ9t1ngQylhQFrB0=;
        b=ScIHvIG6HVQigzJWV8nr0Y75nI6T6y0eXs7cb9Q/pTa7gzxRm99Dj7M6hhZ982enuf
         dSZVpoX8IRs612Ierm6IEBQdzgLkoTQ/JDcdah/nAqTTIj1Cq8kCa333/aSoISPVZWly
         4WF5fLsS5DhJTb3qOZQlifcRtgFXsMbne4iMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=d5GGgFKeNTi6McmCjfDNZuftThHyKCCJF6DaBxlwt/cSeg3BRQNBznLksB1DYpVYZd
         cddZ+VpOCmyOhe8R9aUKNMuQl2JtO5LsA5eTeKbIdIv5IS5zykT/ELPJmrF69uIa3fpj
         py0Y/UEYuMI7z9ESd8csDloW6troHs5RjXZlw=
Received: by 10.86.57.9 with SMTP id f9mr3674511fga.62.1246021728735;
        Fri, 26 Jun 2009 06:08:48 -0700 (PDT)
Received: from ?192.168.1.13? (abwa104.neoplus.adsl.tpnet.pl [83.8.224.104])
        by mx.google.com with ESMTPS id 4sm406289fge.18.2009.06.26.06.08.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Jun 2009 06:08:48 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200906260932.43826.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122296>

On Fri, 26 June 2009, Johan Herland wrote:
> On Thursday 25 June 2009, Jakub Narebski wrote:

> > Current version of survey has 30 questions, as compared to
> > 60 questions last year; the number of free-form essay questions
> > were also greatly reduced.
> 
> Good. :)

Too large number of questions in the survey, and filling survey taking
too long were, I think, the most common complaints about survey in the
year before.

A number of free-form essay questions from previous survey are still
not analyzed (even now).

> > The *test* version of this year survey can be now found at
> > the following URL (as in previous year, we use Survs.com)
> >
> >   http://www.survs.com/survey?id=2PIMZGU0&channel=TFN2Y52K7Y
> >
> > Please tell me what you think about questions and about selection
> > of possible answers in single choice/multiple choice questions.
> 
> There seems to be some unnecessary overlap among questions 11, 16/17 and 18. 

Just a reminder; those questions are:

11. What Git interfaces, implementations, frontends and tools do you use?

16. How often do you use the following forms of git commands
    or extra git tools?
17. How often do you use the following forms of git commands
    or extra git tools? (continued)

18. Which of the following features do or did you use?

Overlap between questions 16/17 and 18 is, to some extent, intended.  
Those two questions ask about similar area but from the two different
points of view: question 16/17 is about git commands, 18 about features.

In first two drafts there were no question 16/17; it was brought back
at the request on #git channel.  I am a bit ambivalent about this 
question; on one hand side it allows responders to get to know some
git commands or form of git commands they didn't know about, on the
other hand side it is one of most work-intensive and time-consuming
questions.  It brings interesting information, but the same could
have been (perhaps better) gathered from a filtered list of commands
in history, or from list of commands generated by special 'statistic
gathering' compiled version of git.

It there are votes for removing questions 16/17 I can remove it from
survey (again).

> Examples: I found myself ticking off equivalent options like:
> - 11/gitk, 17/gitk and 18/"gitk or other history viewer"
> - 17/"git gui" and 18/"git-gui or other commit tool"

This can be easily corrected by removing extra tools which are
mentioned in question 11. about tools used from possible answers
to question 18. about features used.  I am not so sure about removing
'gitk' and 'git gui' from 16/17.

OTOH some tools can be uses both as history viewer, and as commit tool.
This answer allow to distinguish between those two distinct usages.

> - 14/"via git-bundle", 15/"git bundle", 16/"git bundle" and 18/"git bundle"

14. How do you fetch/get changes from upstream repository?
15. How do you publish/propagate your changes?

These are about different directions, and I think different ways of
using git-bundle.  For fetching (or rather cloning) via bundle I would
think that project would publish ready for download bundles to reduce
traffic and load on server (HTTP download can be resumed, git-clone
currently cannot; you can distribute bundle using P2P, GitTorrent and
git mirror-sync are not implemented (yet)).  For publishing via bundle
I would think about sending bundle via email, or posting it on review
board (BTW IIRC Gerrit uses git-bundle).

About 16/17 (git commands) and 18 (features): I guess I can remove
git-bundle from the list of features we ask about.

About 14, 15 (get / publish) and 16/17 (git commands): the command
list is meant to be comprehensive list of porcelain and porcelanish
git commands, so I don't think it would be good to remove bundle from
16/17.  OTOH git-bundle can be used neither for fetching nor for 
publishing, but for example only for review, or for syncing between
_own_ repositories.

> - 11/StGIT/Guilt/TopGit and 18/"patch management interface"

I could remove "patch management interface" / "topic branch management
interface" from 18 (features), as they are in 11 (tools), but I am less
sure about this than about removing "history viewers" and "commit tools".

> - 17/"git reflog" and 18/reflog

I think I'll remove 'reflog' from 18 (features), not because it is
present in 16/17 (git commands), but because this is feature one uses,
I think, quite often and less 'conscious'.

OTOH one can use reflog feature without using "git reflog" or 
"git log -g" ("git log --walk-reflogs") -- HEAD@{1} or @{yesterday}
uses reflog feature without using mentioned git commands :-)

> - 17/"git stash" and 18/stash

True. Nevertheless I'd rather leave this duplication (well, unless
question 16/17 (git commands) would be voted to be removed).

> - 16/"git difftool" and 18/"mergetool and/or difftool"
> - 16/"git mergetool" and 18/"mergetool and/or difftool"

Well, it is even more clear that the issue of gitk etc. in 16/17 and 18;
I think I can safely remove "mergetool and/or difftool" from 
18 (features).  IIRC it was here because initially there were no
16/17 (git commands) question.

> - 17/"git rebase -i" and 18/"interactive rebase"

Hmmm... I would think about this.

> - 16/"git add -i" and 18/"interactive commit/..."

Actually here "interactive commit/..." in 18 (features) covers more than
just "git add -i", as it is also about per-chunk committing feature
of git-gui and other commit tools.

> - 16/"git filter-branch", 18/"git-filter-branch or cg-admin-rewritehist" and 
>   18/"git-filter-branch or equivalent"

Ooops.  Certainly "git-filter-branch or cg-admin-rewritehist" and 
"git-filter-branch or equivalent" answers should be concatenated.
My mistake.

About having it both in 16/17 (git commands) and 18 (features): I wonder
if "git filter-branch" in 16/17 should be split into filterless version
(make grafts into history, add 'encoding' header) and version with some
filter specified...

> - 11/"editor/IDE VC integration" and 18/"integration with IDE/editor"

O.K. I think I can safely remove this from 18 (features), as it is
present in 11 (tools).

> 
> Some of this overlap is probably unavoidable, but I think some of it 
> (especially between 16/17 and 18) can be eliminated without compromising the 
> survey. Maybe we can integrate the non-overlapping parts of 18 into the 
> other questions, thereby further decreasing the number of questions?

Questions 16/17 (git commands) and 18 (features) are about the same area,
but orthogonal (different) approach.  I was not sure (and still I am not)
whether to include 16/17 (git commands) question in the survey.

> 
> BTW, 17 is just a continuation of 16, AFAICS. Is it possible to just repeat 
> the column headers (to break up the table length) and still keep it as one 
> question?

This is _technical_ limitation of Survs.com on number of answers in
a single question (I think it is 50 answers maximum, or something).

> > How long does it take to fill survey?
> 
> ~ 5-7 minutes

Thanks for this information.

-- 
Jakub Narebski
Poland
