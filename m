From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: GIT vs Other: Need argument
Date: Thu, 19 Apr 2007 13:57:47 +0100
Message-ID: <200704191357.48816.andyparkins@gmail.com>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> <200704172239.20124.andyparkins@gmail.com> <1176983993.30690.13.camel@cauchy.softax.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Marcin Kasperski <Marcin.Kasperski@softax.pl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 19 14:58:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeWDO-00020o-CH
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 14:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S637755AbXDSM6Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 08:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S637759AbXDSM6Q
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 08:58:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:36772 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S637755AbXDSM6O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 08:58:14 -0400
Received: by ug-out-1314.google.com with SMTP id 44so667352uga
        for <git@vger.kernel.org>; Thu, 19 Apr 2007 05:58:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HVKtdiQEHa4RULHhGW7DTVkj2RlmghsT8iFAI5pl3WXbwy8D3nZFzmww3xl+vfLOyCLE3C41kHNn/XuM6ocl0IuH7XdfCXz4wBM7vn/B60jJLazafSJyRf9kJn68qdXaqMA9wVBChIfsvBeEuUlykyMpYiRJFrVDPa7S54ue7hs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Y66uixIP8o9fppoWFx9FDzkouFVBbn7EskEqa60qkRvypJa4hVyP5IXfC46ptxctcakyPEN4Cf7bIOfZTXvg3Ee3UXYeHaFijJyjvLOtNP7b26SmKbS94dxPUuAZF+kGEqRlgy/YnWYR1qL7ePaN25QfJu5iVbwDRiTws1yrFnc=
Received: by 10.82.189.5 with SMTP id m5mr2802503buf.1176987493329;
        Thu, 19 Apr 2007 05:58:13 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b33sm3697ika.2007.04.19.05.58.00;
        Thu, 19 Apr 2007 05:58:09 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <1176983993.30690.13.camel@cauchy.softax.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45017>

On Thursday 2007 April 19 12:59, Marcin Kasperski wrote:
> > but git is definitely no harder to learn
> > than anything else.  I browsed through the mecurial tutorial
> > yesterday - and as well as being significantly less powerful than git,
> > it's no easier.
>
> Mercurial is easier to learn, because it has better docs and slightly
> simpler command line (all those -a, -p, ... options which one always
> forgets to add). I tried it.
> In fact, I did the experiment about month ago. I wanted to give a try
> to distributed vc tool. I started from GIT, played a bit with it, and
> abandoned it because a) I did not know whether I am expected to use git,
> or cg, b) While reading docs many times I had the feeling that something
> strange and unclear is going behind the hood.

In terms of normal operation, there aren't many switches one actually needs to 
remember.  The only one I can think of is "-a" for commit - however, that's 
just to make it work like mercurial - a seasoned git user won't use many 
switches.  My daily grind consists of

 git add file.c
 git commit
 git add file.c
 git commit
 git add -i
 git commit

(Interactive mode for git-add is a joy to use - I don't know if Mercurial has 
anything similar).

Now, to your point.  I think you're right.  What I said was that git actually 
is easier; however if you looked at some of the documentation you would 
incorrectly assume that that was not the case.

> > (I can't believe this one - if you want to branch a mercurial repository
> > you have to have another complete checkout.  Erm... the checkout takes
> > up more space than the repository - why do I need another copy? Anyway,
> > git is no harder than Mercurial here)
>
> AFAIK you are wrong, they are able to link some files while cloning, so

Can't be.  I'm talking about the working directory not the repository - if the 
files are linked back to the originals, then it's not a separately editable 
set of files is it?

> you loose space only if you switch machine or filesystem. Also, recent
> mercurial has initial within-repo branches support. But I am not really
> the best person to conduct git-vs-hg discussion.

I'm glad that Mercurial is getting in-repo branches, they're great.  I really 
wouldn't want to live without them now I have them.

> > "(Note for Windows users: Mercurial is missing a merge program" - that
> > Windows support isn't looking quite so hot now.
>
> Mercurial on windows works well with kdiff3 or tortoisemerge, you must
> only install one of them.

Aren't they manual merge tools?  I think "merge" is for merging automatically, 
and moaning about conflicts if they turn up - /then/ you go to tortoisemerge.

> As I said, I am not conducting hg-vs-git discussion. I just happened
> to introduce and manage VC system in corporate environment, so I am able
> to point that this is important feature.

I appreciate that - I don't want to start a fight.  My point should probably 
have been more directly focussed on git (which was what I wanted to do) - 
it's my opinion that git is in fact easier than Mercurial; however, it's 
public face is not letting people see that.

> > As for permissions, well Shawn has often spoken of his hook scripts that
> > implement very strong permissions (and he has done so again in this
> > thread).
>
> I am not quite sure how can you forbid johny to see the code
> in ./secret, while johny must checkout whole repo...

Me either - the only permissions that could have been relevant are those 
needed to push to the central repository.  As I said, git can cope there 
without trouble.

> Permissions are not only about writing.

That one is true - perhaps one day git will get partial clone support to match 
it's shallow clones - then it would be possible to put permissions on the 
read of a central repository.  Can Mercurial do that?

> > Depends what you want - I installed cygwin
>
> This is really not an option for typical windows user. Believe me.
> Maybe it could be, if cygwin managed to create normal setup program
> one day...

I'm not an expert in Windows by any means - all I did was run setup.exe and 
picked git and ssh from the list.  It doesn't get much easier.

> Let me retype it: I am not complaining. GIT developers are not forced to
> think about win users, or about corporate needs. But if they are, it is
> reasonable to know the problems.

Absolutely - I certainly haven't taken anything you've written as a complaint.  
If anything I find it interesting because I think it confirms what I 
thought - git is not short on features or usability, it's just got a PR 
problem.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
