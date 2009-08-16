From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Using VC build git (new patch)
Date: Sun, 16 Aug 2009 10:38:17 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908161018370.8306@pacific.mpi-cbg.de>
References: <1976ea660908150921n516178dbs2ce024ed729e2e02@mail.gmail.com>  <alpine.DEB.1.00.0908151851280.8306@pacific.mpi-cbg.de>  <alpine.DEB.1.00.0908151908300.8306@pacific.mpi-cbg.de> <1976ea660908152107s8b8f3e5l3c2f043fb3e4d62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1362442541-1250411897=:8306"
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Frank Li <lznuaa@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sun Aug 16 10:38:16 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f162.google.com ([209.85.210.162])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McbFU-0001Me-Th
	for gcvm-msysgit@m.gmane.org; Sun, 16 Aug 2009 10:37:57 +0200
Received: by yxe34 with SMTP id 34so3372472yxe.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 16 Aug 2009 01:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:received:x-authenticated:x-provags-id:date:from:x-x-sender
         :to:cc:subject:in-reply-to:message-id:references:user-agent
         :mime-version:content-type:x-y-gmx-trusted:x-fuhafi:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=GixhQOsw0bcyPaCWUUTqL6hRCyFr29eWtex+qWYXOko=;
        b=69reL8SEQZX/oOZKGybx4IN7QW0Lgub4iFI3k0N4lOx2Tcxe8/GEXn7Mdn17nxUZl/
         rD52OkPLMT7Vrg3XgHTUrXkoQjpYdUGpeDU5igPw9aGmuN5ccMdGYSbtm27rN9MyK0XB
         l77Jn0Sfn9mAVOz+Ri710UX/cZc8/WvstOB7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=D/rHHaZEtU3sLLFj00BQzXG32sMBmyd/zMjK1T19/n0mG30CPJ8POmww4kJhW7GC/j
         LH6E/bbU+VxTICvKE7OHRDQ5+maer6SMPiuszGC5eXn0hc0xWcmq+wVXm+3Ovr+P344n
         U03ojYOpV9v5GGE0zy5Q1KKgJXOO3+hKdchpo=
Received: by 10.150.143.19 with SMTP id q19mr839400ybd.2.1250411865659;
        Sun, 16 Aug 2009 01:37:45 -0700 (PDT)
Received: by 10.177.154.18 with SMTP id g18gr6320yqo.0;
	Sun, 16 Aug 2009 01:37:33 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.103.64.37 with SMTP id r37mr118619muk.13.1250411852095; Sun, 16 Aug 2009 01:37:32 -0700 (PDT)
Received: by 10.103.64.37 with SMTP id r37mr118618muk.13.1250411852071; Sun, 16 Aug 2009 01:37:32 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 16si450172bwz.4.2009.08.16.01.37.31; Sun, 16 Aug 2009 01:37:32 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 16 Aug 2009 08:37:31 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38] by mail.gmx.net (mp006) with SMTP; 16 Aug 2009 10:37:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Ex+ZO5rmE4+NM/3H2G1reWSN+c3/aGwPjfDczP9 3HkF7piCxaYUIL
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1976ea660908152107s8b8f3e5l3c2f043fb3e4d62@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126052>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1362442541-1250411897=:8306
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

[please quote only those parts that you actually reply to.]

On Sun, 16 Aug 2009, Frank Li wrote:

> 2009/8/16 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>
> >        - the addition of O_BINARY in the file modes
>
> Yes, default is text mode if no O_BINARY, _read _write will do union 
> code and cr\cf convert.

As Git _never_ wants to open files in text mode, this is a change that can 
come _separately_ from your VC patches.  It could even be considered a bug 
fix (MinGW's current GCC implies O_BINARY, but previous ones may not, and 
it is wrong of us to rely on this magic).

> >        - disabling link() (why?)
>
> VC report stack error. I also don't know why. I have not deep debug this 
> problem.

You should.  What with Visual Studio's superior debugging capabilities, it 
should not be a problem.  Right?

> >        - double-#define'ing stat (which puzzles me greatly)
>
> old define is
>           #define stat    stati64
>           #define stati64 msys_stati64.

Not exactly.

	#define stat _stati64
	[...]
	#define _stati64(x,y) mingw_lstat(x,y)

And even VC should handle that just fine.

> stat is used for both struct and function name.
> In C code:
>       struct stat a;
> stat -> stati64 -> msys_stati64,  so compiler report struct
> msys_stati64 have not defined.

It is a real pity that you did not inline your patch, and that I could not 
quote it as a consequence, because now we could discuss code properly:

The original code was done on purpose as it is, to use the _stati64 struct 
(which allows long pointers, as Microsoft decided off_t was not good 
enough to represent 64 bit offsets).  I could imagine that your patch 
breaks that for Visual C++.

> >        - adding _huge_ .vcproj files (can they not be smaller?)
>
> It is created by VS2008.  I think it is difficult to make smaller.

Is there not some magic to make a compact export version?

But maybe it is not that bad?  I have 72 (out of 1730) files in my 
repository that are larger, gitk being the king.

FWIW I would have loved it if _you_ defended the size of the file, instead 
of having to do it myself.

> > Further, I would like to suggest adding a header file compat/msvc.h 
> > which contains all the #undef's and #define's necessary only for 
> > Visual C++, and which can be #include'd from git-compat-util.h, to 
> > better separate your work from the other platforms (who do not want 
> > those changes).  That should avoid those unwanted changes to mingw.c 
> > and mingw.h.  You just have to make sure that msvc.h is #include'd 
> > before mingw.h.
> 
> VC build will reuse msysgit work.

That is no question.  We made it easy for you.

> I will reduce change to mingw.c and mingw.h
> But there are some problem at mingw.c and mingw.h
> 
> 1. stat defination.  Because both struct and function use the same name stat.

That needs to be resolved somehow, and you would get _much_ more help if 
you had split your patch series properly and this was _one_ patch.

> 2. open need binary mode.

As I said, this can be a separate change.  In my original reply I 
_implied_ that it is okay, and in this reply I elaborated on that (namely 
that it might be considered a bug fix).

> 3. mingw.c use C99 style to break build at VC.

The same applies here as to O_BINARY.

> 4. mingw.c use special DIR structure, So I need add open_dir in mingw.c.

No, you do not need to add that to mingw.c.  MinGW does not need it.  So 
it has no place in mingw.c.

> If I don't change mingw.c, I need copy it to new file totally.

NOOOO!!!

You #include it after making sure that you have #undef'ed and #define'd 
whatever needs to, and in a separate file -- which is only referenced in 
the .vcproj -- you can implement whatever Visual C++ misses.

> > With these comments, I look forward to your next iteration.
> >
> > Ciao,
> > Dscho

Please, please, PLEASE, do not quote things that you are not addressing.  
And please, please, PLEASE adher to Documentation/SubmittingPatches.

Actually, the only thing SubmittingPatches does is spell out how to make 
things easier for reviewers, should you not know how to do so.

Remember: the more time it takes me to cull the quoted parts of your mail, 
the more time it takes me to have a look at your patches, the more time it 
takes me to refer to your patch and make suggestions, the more am I 
inclined to spend my time elsewhere, doing something that is much more 
enjoyable.

Ciao,
Dscho

--8323328-1362442541-1250411897=:8306--
