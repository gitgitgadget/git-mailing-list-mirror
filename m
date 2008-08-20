From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFC v2] Git User's Survey 2008
Date: Wed, 20 Aug 2008 23:18:52 +0200
Message-ID: <20080820211852.GA27226@leksak.fem-net>
References: <200807230325.04184.jnareb@gmail.com> <200808200308.26308.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 23:20:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVv62-0008UN-7C
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 23:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbYHTVS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 17:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753086AbYHTVS4
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 17:18:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:58406 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752565AbYHTVS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 17:18:56 -0400
Received: (qmail invoked by alias); 20 Aug 2008 21:18:54 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp016) with SMTP; 20 Aug 2008 23:18:54 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/NGpRYtW3NPoy739blZ4lSvHgFG55Gt5TvLIaLtk
	dLd2h0gnOhKy4f
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KVv4u-0007Us-Oj; Wed, 20 Aug 2008 23:18:52 +0200
Content-Disposition: inline
In-Reply-To: <200808200308.26308.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93049>

Hi,

Jakub Narebski wrote:
> This is second revision (version) of proposed questions 
> for Git User's Survey 2008.

Great!

> By the way, should the survey be divided in pages, or simply use
> headers to divide survey into sections?

Divided pages have a psychological impact, they don't look much and you
can say "Almost there!" on each page.

But headers and one-page surveys have a big advantage for users that pay
for Internet access per time unit: they can go offline, answer the
questions, and go online again to submit the survey.

So I've scrolled across your test survey on survs.com and I think it
should be kept on one page. Looks nice and manageable.

> Third, where to send survey to / where to publish information about the 
> survey?

This question leads me to a question that could be put into the survey:

	Where have you read about this survey? (optional)
	[Free form]

> Fourth, how long should the survey last?  When sending announcement we 
> should say where notice about Git User's Survey 2008 should be taken 
> down.  Last year the survey was meant to take three weeks, but was up 
> longer.  I'm thinking about having it last a month, or a month and a
> half, starting from September 1.

And lasting until 2008-10-10?  No, I do not really care.


So, some comments on the questions now:

> About you
> 
>    xx. What country are you in?

"What country do you live in?" perhaps?

> Getting started with GIT
> 
>    xx. How did you hear about Git?

There is a typo on survs.com (hear_d_).
Should this by the way be multiple choice?
I have heard about Git several times before I tried it.



I will only quote from survs.com now:

> told by friend (word of mouth)
                 ^^^^^^^^^^^^^^^ ? :) I think this should be removed

> What other SCM did or do you use?
>[..]
>  custom ( ) ( ) ( )

custom?

> 20. Which porcelains / interfaces / implementations do you use?
>  [ ] core-git

Uh, this is ambiguous.  Is this our git or some script on top of git?
In both cases, this should be clarified.

> 22. Which git web interface do you use for your projects/have installed?
> (Web interfaces used by git hosting sites do not count[*])
[...]
> (*) Unless of cours you are hosting some git hosting site
             ^^^^^^^^                                      ^
	     typo, but I'd rather do s/of cours //   and s/$/./ :-)

> 26. How often do you use the following forms of git commands
> or extra git tools?
>
>		Never | Rare | Often
                                     | Not yet, but sounds cool   ;-)

No no :-)

But I wonder if we could split the "Never" case into several cases with
reasons like:
 - Do not know.
 - Not yet needed.
 - Other (did not understand; tried but did not work; ...)

But this will perhaps bloat the question even more, so we should keep
"Never", though I think the reasons could be interesting.
Could some "Comments" field for question 26 help?


Some other comment: I dislike that there is *one* "Reset" button for
such matrix questions. But I guess you cannot change that?

> 28. Which of the following features do or did you use?

I think many of the possible replies have been used in several other
questions before, e.g. in 
 - 21. (gitk, git gui), 
 - 24. (git bundle),
 - 26/27. (git gui, gitk, git stash)
 - ...

But this question still seems to makes sense for:
 [ ] eol conversion (crlf)
 [ ] gitattributes
 [ ] reflog (ref@{23})
 [ ] shallow clone
 [ ] detaching HEAD   <- I think several people could have used that without knowing
 [ ] commit templates
 [ ] integration with IDE/editor
 [ ] non-default hooks

And btw:
> [ ] working with dirty tree      <- Eh? Is this a feature?


Big thanks for your efforts,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
