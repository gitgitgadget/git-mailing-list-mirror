From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2008
Date: Wed, 23 Jul 2008 15:08:38 +0200
Message-ID: <200807231508.42334.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <alpine.DEB.1.00.0807231128090.2830@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 15:10:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLe66-0007yd-7C
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 15:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbYGWNIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 09:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbYGWNIj
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 09:08:39 -0400
Received: from ik-out-1112.google.com ([66.249.90.180]:36966 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbYGWNIi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 09:08:38 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1840190ika.5
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 06:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=DbagWh6uw2WevXHLn4jxGPLghjLaeg8Q6VDrhT0Itaw=;
        b=p1oAP6b8AVMv5CDL6VWPPOZK9xWIIlulwU+xr/3myNOqTDUHravvDykTru8/8Y/3Ds
         CBlXT3qptKNZR4KDQpz1G54C5D+wNE8+Fgx8WTVwBWzPnXT4quZRmzlGpuBdXU2sVLHk
         SOsMAJhZHIDskbCNcdD0qnBqc+XasRji+sPtY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=g9IYcfpUTQbR3XP2uu5d+i7nSHJoakm+lpUrtCszqt+hcEl29e5v72kaFJ1GwDaL8I
         RG9jMWYUDoXZfn6Q/La2cj2pkOuwcvlLRyMuEy/EUx4rM0pbITGbD4qeVjSVw7Ty+rUx
         dTqaKn575hyEpHefJexTPi3iyku+yI4had3fE=
Received: by 10.210.19.4 with SMTP id 4mr6003463ebs.58.1216818516544;
        Wed, 23 Jul 2008 06:08:36 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.213.1])
        by mx.google.com with ESMTPS id k7sm4768648nfh.17.2008.07.23.06.08.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 06:08:34 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.1.00.0807231128090.2830@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89645>

On Wed, 23 Jul 2008, Johannes Schindelin wrote:
> On Wed, 23 Jul 2008, Jakub Narebski wrote:
> 
> Some people prefer to stay anonymous, so I think email is out.
> 
> >    04. Which programming languages you are proficient with?
> >        (The choices include programming languages used by git)
> >        (zero or more: multiple choice)
> >      - C, shell, Perl, Python, Tcl/Tk
> >      + (should we include other languages, like C++, Java, PHP,
> >         Ruby,...?)
> 
> Yes, I think this should be a long list.

I'd rather not have a "laundry list" of languages.  I have put C++
because QGit uses it, Java because of egit/jgit, PHP for web
interfaces, Ruby because of GitHub and because of Ruby comminity
choosing Git.  I should perhaps add Emacs Lisp, HTML+CSS and
JavaScript here.  What other languages should be considered?
 
> >    07. What helped you most in learning to use it?
> >        (free form question)
> 
> Is it possible to have multiple choice, with "other" (free-form)?  Then 
> I'd suggest:
> 
> 	Colleague/Instructor, User Manual, Manpages, Tutorials, Tutorials 
> 	(elsewhere; not in git.git), Mailing list, IRC, Git Wiki, Other.

By "Tutorials (elsewhere; not in git.git)" you mean here many various
"git guide" pages, like "Git for Computer Scientists", "Git Magic",
etc.?

I'm not sure about having multiple choice vs. free-form question here.
Multiple choice is easier to analyze, especially if one would want
histogram of replies... but free form is more rich.  But perhaps
multiple choice with free-form "other" choice would be the best?

Besides proposed choices limit person filling the survey to single
understanding of "what helped you in learning to use Git", which
can be also understood as asking for list of features helping with
learning Git, not only list of documentation and such. 

> >    08. What did you find hardest in learning Git?
> >        What did you find harderst in using Git?
> 
> s/harderst/hardest.
> 
> >        (free form question)
> 
> Again, I'd suggest a multiple choice + Other:
> 
> 	The amount of commands, the amount of options, the index (AKA 
> 	staging), branching, user interface, bugs, Other.

Here it can be hard to come up with good list of choices.  For example
among responses in 2007 survey there were 'inconsistent commands',
'obtuse command messages', 'insufficient/hard to use documentation',
and many more.

I'm not sure if troubles with coming with extensive but not too large
list of options for this question is worth it; I think that we need
only list of responses, and not number of responses (perhaps mentioning
which one occur [much] more frequently).

> > Other SCMs (shortened compared with 2007 survey)
> > 
> >    10. What other SCM did or do you use?
> >        (zero or more: multiple choice)
> >      - CVS, Subversion, GNU Arch or arch clone (ArX, tla, ...),
> >        Bazaar-NG, Darcs, Mercurial, Monotone, SVK, AccuRev, Perforce,
> >        BitKeeper, ClearCase, MS Visual Source Safe, MS Visual Studio
> >        Team System, custom, other(*)
> 
> PVCS seems to be pretty popular, too.

O.K., I'll add it.  I think I'd better add RCS too.

> >    11. Why did you choose Git? (if you use Git)
> >        What do you like about using Git?
> >        (free form, not to be tabulated)
> 
> Again, to avoid hassles with free-form:
> 
> 	Mandatory: work, mandatory: open source project I am participating 
> 	in, speed, scalability, It's What Linus Uses, Other.

Free form has some hassles.  Because here histogram of responses might
be interesting, perhaps it would be good to use multiple choice here.

I would add "features" and/or "unique features" to the list, and also
perhaps "being popular/hype".

> >    12. Why did you choose other SCMs? (if you use other SCMs)
> >        What do you like about using other SCMs?
> >        Note: please write name of SCMs you are talking about.
> >        (free form, not to be tabulated).
> 
> Again:
> 
> 	ease-of use, simplicity, existing project uses it, I Do Not Like 
> 	Linus, Other

Again: free form has some hassles, but so does coming up with good
choice of fixed answers in multiple choice question.  I'll add
"ease to install on MS Windows" (or something like that) if we decide
to have this question multiple choice.

> >    15. What operating system do you use Git on?
> >        (one or more: multiple choice, as one can use more than one OS)
> >      - Linux, *BSD (FreeBSD, OpenBSD, etc.), MS Windows/Cygwin,
> >        MS Windows/msysGit, MacOS X, other UNIX, other
> 
> You should include "Dunno", which gets automatically mapped to "MS 
> Windows/msysGit" ;-)
> 
> >    19. How do you publish/propagate your changes?
> >        (zero or more: multiple choice)
> >      - push, pull request, format-patch + email, bundle, other
> 
> git svn
> 
> You might laugh, but it is a sad fact that some guy promotes "Using Git 
> with Google Code" by using git-svn to drive their crappy Subversion.

O.K.  I'll add "git-svn (or other to foreign SCM)".

> >    22. How does Git compare to other SCM tools you have used?
> >      - worse/equal (or comparable)/better
> >    23. What would you most like to see improved about Git?
> >        (features, bugs, plug-ins, documentation, ...)
> 
> Maybe here should be another question "What are the most useful features 
> of Git?" but maybe that is covered by earlier questions.

I think it is.  I'd rather try to reduce number of questions...

> >    24. If you want to see Git more widely used, what do you
> >        think we could do to make this happen?
> >      + Is this question necessary/useful?  Do we need wider adoption?
> 
> I agree with Junio: this is not so interesting for us; we are no company, 
> and we have no sales department who could wank of on these answers.

I'll remove it, then.

> >    27. Which of the following features do you use?
> >        (zero or more: multiple choice)
> >      - git-gui or other commit tool, gitk or other history viewer, patch
> >        management interface (e.g. StGIT), bundle, eol conversion,
> 
> For our Windows friends, we should add " (crlf)" to the last item.

Right.  Thanks.

> >    42. Do you find traffic levels on Git mailing list OK.
> >     -  yes/no? (optional)
> 
> /too low?  *ducksandrunsforcover*

???

> >    44. If yes, do you find IRC channel useful?
> >     -  yes/no (optional)
> 
> /somewhat.  Even if I would be the only one choosing that option.

I'm sorry about that: I have forgot that this and all similar questions
had triple choice: yes/no/somewhat in the final version of 2007 survey.
I'll correct it.

> >    45. Did you have problems getting GIT help on mailing list or
> >        on IRC channel? What were it? What could be improved?
> >        (free form)
> 
> Yeah, I know who will answer to that, and what... "yaddayadda very 
> unfriendly yaddayadda especially that Johannes guy yaddayadda" (you know 
> who you are)... *lol*

:-)

-- 
Jakub Narebski
Poland
