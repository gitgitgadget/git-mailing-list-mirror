From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2008
Date: Thu, 24 Jul 2008 20:18:27 +0200
Message-ID: <200807242018.27663.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <48889591.9020208@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 20:19:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM5Pb-0001Dp-2W
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 20:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbYGXSSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 14:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbYGXSSd
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 14:18:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:5512 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbYGXSSc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 14:18:32 -0400
Received: by ug-out-1314.google.com with SMTP id h2so622719ugf.16
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 11:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=AFLg3JAmuo720shBbSqbPsqChjgBsNlt7pe14ndcOQk=;
        b=tO7uEn9WKHzmtuA/9VDBPq0vCRJdtVss+kJ81Hx2eFCoHStWIH7f8AGW2lngCYcLUg
         EsqvVmNpA0A2Y/CtyN9iA4AzD9Q7LhcgQzzCA2mWhrqMojWt11BWim1G7MEIna4FX0kh
         zEXAVaozbI98ehwzHta2iSIhg3ODKEsZhkfA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=f5znoW99m1V8ERrUd480Qucqy9NdWpKW5Oq1y4WRgT3f/e+1Q0du0jqFka115AM/Ua
         IVBq3alMBdzDfYfBTmW3nNn5v3yhMqeGUKYsmG7XRmXwPncGY9JxJBOpVW31A+O/mOTP
         xMyPGugx8Z9Bz58Yy8MpNBDR/IsesCoa1qn8A=
Received: by 10.67.115.16 with SMTP id s16mr1240747ugm.61.1216923510262;
        Thu, 24 Jul 2008 11:18:30 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.208.47])
        by mx.google.com with ESMTPS id r38sm4125076ugc.49.2008.07.24.11.18.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jul 2008 11:18:29 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48889591.9020208@freescale.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89930>

On Thu, 24 July 2008, Jon Loeliger wrote:
> Jakub Narebski wrote:
> >
> > About you
> > 
> >    01. What country are you in?
> >    02. What is your preferred non-programming language?
> >   (or) What is the language you want computer communicate with you?
> 
> How about:  What is your preferred natural language?

Perhaps it is a better formulation. I am not native English speaker.
(But so would be some people who would answer this survey).

The problem with this question is that people does not understand it,
and either do not answer or answer for example with computer language
(C, Perl, or something like that).  For 2007 survey, when the question
was formulated as "02. What is your preferred non-programming language?"
there were 37 invalid responses (computer language), and 4 "not 
understand" responses out of 662 people who answered this question.

On of the goals (besides curiosity about demographics) of this question
is to get to know if Git core should provide infrastructure for 
translating messages, in addition to what already exists for git-gui 
and gitk.  But as currently there are no other questions about l10n
and i18n perhaps it would be better to simply remove this question.

> >    03. How old are you (in years)?
> >        (free form, integer)
> >    04. Which programming languages you are proficient with?
> 
> Perhaps:
>     With which programming languages are you proficient?

Again: I am not native English speaker.

> > Getting started with GIT
> > 
> >    05. How did you hear about Git?
> >        (single choice?, in 2007 it was free-form)
> >      - Linux kernel news (LKML, LWN, KernelTrap, KernelTraffic,...),
> >        news site or magazine, blog entry, some project uses it,
> >        presentation or seminar (real life, not on-line),
> >        SCM research, IRC, mailing list, other Internet,
> >        other off-line, other(*) 
> >      + the problem is with having not very long list (not too many
> >        choices), but spanning all possibilities.
> 
> So go more general?  Don't specify actual news (web)sites.

I didn't mean here enumerating actual news (web)sites, but to provide 
examples.

> Don't forge that there is a whole raft of Ruby-n-rails folks who
> are embracing Git these days too.  They have their own whole 'nuther
> set of mailing lists, websites, (news) lists, etc.
>
> >      + is this question interesting/important to have in survey?
> 
> Look to the history to answer this question.  Did we really
> learn anything from the earlier surveys by this question?
> Maybe it would make more sense to get a feel for which general
> camp led them to Git?  That is, did they come from the Kernel
> side of the world, or Ruby-on-Rails, or self-exploration, etc.

That is what I think we want to find through this question.
Unfortunately I have found about Git by reading KernelTraffic
and later KernelTrap during the whole "BitKeeper fiasco"; I have
next to no idea about how other people have heard about Git.
Help!?

There is other side to this question, _if_ we were some company, or/and 
_if_ we were concerned about making Git more popular, namely to 
identify the paces where "advertising" would make most impact.
 
> >    06. Did you find GIT easy to learn?
> >      - very easy/easy/reasonably/hard/very hard
> 
> But that has to be contrasted with their _current_ notion
> in order to know if they make progress or not.  If the
> difficulty persists, we're in trouble.  If it is just a
> steep learning curve, we might be able to address that.
>
> So maybe some variant questions like:
>     How do you find it now (after some use)?
>         same [very easy..very hard] scale
>     How long have you been using Git?

The question is here to either dispel the myth that Git is hard to 
learn, or find that we have steep learning curve and that we should 
perhaps do something about it.

>     Rate your own Git proficiency:
>         [noob, casual, I survive, everyday use,
>          I answer questions from others,
>          I use plumbing in scripts daily,
>          Power User, Godly, I am Junio]

Good idea about question about Git proficiency.

> >    07. What helped you most in learning to use it?
> >        (free form question)
> >    08. What did you find hardest in learning Git?
> >        What did you find harderst in using Git?
> >        (free form question)
> >    09. When did you start using git? From which version?
> >      - pre 1.0, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5
> 
> It's likely that most people don't know the specific answer
> to that question and will just guess, if anything.  It is
> also semi-subject to time-slide as old installs are made on
> different distributions [*cough*] Debian.  I think the question
> "How long have you been using Git?"  Might be more easily
> answered and show better data.  (Adoption curve.)

True.  I think "How long have you been using Git?" with log-like
multiple choice scale: few days/few weeks/month/few months/year/few 
years would be better idea.

On the other hand knowing which version someone started his/her
"Git adventure" would help to find probable causes where some of ideas 
about git were already corrected in later versions...

> >      + might be important when checking "what did you find
> >        hardest" etc. 
> >      + perhaps we should ask in addition to this question, or in
> >        place of this question (replacing it) what git version one
> >        uses; it should be multiple choice, and allow 'master',
> >        'next', 'pu', 'dirty (with own modifications)' versions
> >        in addition. 

It would be next (additional) question, probably multiple choice, and 
easy to check out with "git version" or "git --version" command. 
 
> > Other SCMs (shortened compared with 2007 survey)
> > 
> >    10. What other SCM did or do you use?
> >        (zero or more: multiple choice)
> >      - CVS, Subversion, GNU Arch or arch clone (ArX, tla, ...),
> >        Bazaar-NG, Darcs, Mercurial, Monotone, SVK, AccuRev,
> >        Perforce, BitKeeper, ClearCase, MS Visual Source Safe,
> >        MS Visual Studio Team System, custom, other(*)
> 
> What?  No SCCS?

Hmmm... SCCS got 18 out of 654 responses, only one less than SVK.
I'd add it to the list of choices for this question, then.

> >    10b.If you selected other above, what SCM it was?
> 
> s/it was/was it/
> 
> >        (free form)
> >    11. Why did you choose Git? (if you use Git)
> 
> That's a bit vague...  First, maybe they didn't choose Git.
> Maybe they are on a project where it was mandated.
> So, Why did they choose Git for _what_?
> 
> Are we trying to ask "Why did you decide to use Git?" ?

Yes, that was I wanted to ask. "Why do you use Git? (if you do use it)".

> >        What do you like about using Git?
> >        (free form, not to be tabulated)
> 
> Presuming they do... :-)  So, maybe add:
> 
>     I enjoy using Git:           [-5 .. 0 .. +5]
>     Git satisfies my use cases:  [-5 .. 0 .. +5]
>     I prefer Git over CVS/SVN:   [-5 .. 0 .. +5]
> 
> Or so...

I'm not sure if it wouldn't be more interesting to have free-form here.
I think we would get quite a number of unique and non-obvious answers.

Besides the above form depends on survey site to be able to create such 
matrix of responses...

> > How you use Git
> > 
> >    13. Do you use Git for work, unpaid projects, or both?
> >        (single choice)
> >      - work/unpaid projects/both
> 
> But there are other uses too.  I use it for personal crap
> like my Brewing Log.  Sure, it is an "unpaid project", but
> that's not very useful information.  Maybe it would make
> sense to expand this question into, say, 10 choices that
> we feel are likely uses cases and see what the actual
> demographics are.  That is, the two-part-with-waffle isn't
> that informative.
> 
> Maybe:
>      I use Git for: [check all that apply]
>          Work projects
>          Personal data
>          Unpaid Open Source Development
>          Sharing Data with my Niece
>          Maintaining my Website
>          Backending my Blog
> etc.

Very good idea.  This way we can share this question with question about 
kind of data one uses Git for.

By the way, perhaps we should split "Work projects" into "Work projects"
and "Work projects (private git)" to distinguish between cases where Git 
is used at work, and where you use Git privately (for example via 
git-svn, or git-p4) to interact with other SCM that is used at work.
 
> My point here is that we can learn what Git is being
> used for, and ....
> 
>     Although for some reason I can't yet, I would
>     really like to use Git for:
>         My Wordpress backend
>         Maintaining my {pr0n,mp3} Collection
>         Work projects
>         Sharing data with my boss
> etc.
> 
> That would give us a sense of direction possibly.
> It might provide a notion as to what people are wanting
> to do, but for some reason find it hard to pull off.
> That is, help us identify use-cases that are being limited
> but would otherwise be adoptive.

Hmmmm...

> >    18. Which (main) git web interface do you use for your projects?
> >        (zero or more: multiple choice)
> >      - gitweb, cgit, wit (Ruby), git-php, viewgit (PHP), other
> >      + should there be a question about web server (Apache,
> >        IIS, webrick, LigHTTPd, ...) used to host git web interface?
> 
> Probably not.  Most people might not even know.

I can agree with that.

On the other hand the purpose of this question was to get a list
of most popular servers to put example configuration for hosting git 
repositories via HTTP(S) protocol, and for setting up gitweb.

> > What you think of Git
> >
> >    24. If you want to see Git more widely used, what do you
> >        think we could do to make this happen?
> >      + Is this question necessary/useful?  Do we _need_
> >        wider adoption? 
> 
> Hmmm.  See some ramblings of mine above too... :-)

What ramblings were they?

> > 
> > Changes in Git (since year ago, or since you started using it)
> > 
> >    26. How do you compare current version with version from
> >        year ago? 
> >      - current version is: better/worse/no changes

The list of possible answers should (just in case, because you can 
simply not answer this question, although some would not know this)
also "I don't know, I didn't use Git for a year".

> More fine detail needed there?  To help identify what people
> think have improved and what has not yet improved?
> 
> Since you started using Git, rate how the following
> functional areas have/have-not improved:
>     The User Interface          [-5 .. 0 .. +5]
>     The command line interface  [-5 .. 0 .. +5]
>     The intuitive behavior      [-5 .. 0 .. +5]
>     The overall experience
>     The behavior of 'fetch'
>     The behavior of "git log'
>     The config file
> etc.

This of course depends on web survey site allowing such feature
in survey.

> A -5 means it still sucks or got worse, 0 is neutral
> or no opinion, and +5 means it rocks or got better.
> This would give us direct feedback indicating if we,
> as a whole, are headed in the right direction with our
> development efforts.  It will also directly tell us
> which features people find still suck.
> 
> We should attempt to get direct feedback on many Git features.

The trouble of course would be with coming up with the "laundry list" of 
features people did or can have a problem with.
 
> > Documentation
> > 
> >    31. Do you contribute to Git wiki?
> >     -  yes/no/only corrections or spam removal
> 
> If "no", why not?

Good idea.  

>   [Wikis suck, I don't know the answers, no time...]

[We have a wiki???] ;-)
 
> >    32. Do you find Git's on-line help (homepage, documentation)
> >        useful? 
> >     -  yes/no/somewhat
> 
> Confusing.

I think it would fall in "somewhat" category I think.

> > Getting help, staying in touch
> > 
> >    42. Do you find traffic levels on Git mailing list OK.
> >     -  yes/no? (optional)
> 
>     I find the mailing list traffic level to be:
>         [too low, OK, just right, tolerable, intolerable,
>         a bit high, absurdly high]

Good idea of expanding the list of answers, otherwise it is hard to 
answer this question.  Although perceived signal to noise ratio might 
be more important than bare traffic.
 
> > Open forum
> > 
> >    46. What other comments or suggestions do you have that are not
> >        covered by the questions above?
> >        (free form)
> > 
> 
> I've got to ... ramble on,

:-DDDDD

-- 
Jakub Narebski
Poland
