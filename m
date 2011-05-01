From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Strange cherry-picking issue with 1.7.5.msysgit.1.1.g05d0e
Date: Sun, 1 May 2011 11:45:01 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1105011138020.13761@bonsai2>
References: <ipj5k5$j04$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: msysgit+bncCLLz_5DuGxCh1_TtBBoEWYQWeQ@googlegroups.com Sun May 01 11:45:33 2011
Return-path: <msysgit+bncCLLz_5DuGxCh1_TtBBoEWYQWeQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wy0-f186.google.com ([74.125.82.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCLLz_5DuGxCh1_TtBBoEWYQWeQ@googlegroups.com>)
	id 1QGTDZ-0000ci-8y
	for gcvm-msysgit@m.gmane.org; Sun, 01 May 2011 11:45:33 +0200
Received: by wyf28 with SMTP id 28sf7834858wyf.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 01 May 2011 02:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:x-beenthere:received-spf:x-authenticated
         :x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:x-y-gmx-trusted
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=b9DzblHSSyFR8Xg980gfLetDRVVoKGTJfpJiqj/8/ss=;
        b=6Ep/zI6JA712/PUpptUEIu2VypqSqVmjd2IH2yYuoxfCtVwOiZ7tf8QWujALEJsg42
         q7vLBHH2Qy3eklQZ3ZmubQ4bT6F2bIIVj5M6TBTfRE6Ock+9xe1Z9RIiKud473bNBYw4
         S0PWFhD/gZm9r0IKGgFYDKk5nd85x9fam2uvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:x-authenticated:x-provags-id:date:from
         :x-x-sender:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-y-gmx-trusted:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        b=I9Z/br+ToALo+xNA8CCscCn01yfXjnM4lLbBjXNLNRfeig9Yo7Vi+lDDtE3oxb6Vvj
         F9KRnb87Ect+4RIM2I+xU3wdmcTL7uh01348pOiAMd82aJWUvbVABudhe90XmC8cF+tq
         09rOQ/75OBEnPNQizkyy+GLMdgMvHP00qougc=
Received: by 10.216.80.133 with SMTP id k5mr2116035wee.23.1304243105644;
        Sun, 01 May 2011 02:45:05 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.227.139.31 with SMTP id c31ls1536084wbu.0.gmail; Sun, 01 May
 2011 02:45:04 -0700 (PDT)
Received: by 10.227.54.6 with SMTP id o6mr81027wbg.9.1304243104628;
        Sun, 01 May 2011 02:45:04 -0700 (PDT)
Received: by 10.227.54.6 with SMTP id o6mr81026wbg.9.1304243104604;
        Sun, 01 May 2011 02:45:04 -0700 (PDT)
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
        by gmr-mx.google.com with SMTP id m32si1375489wbm.0.2011.05.01.02.45.04;
        Sun, 01 May 2011 02:45:04 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.22 as permitted sender) client-ip=213.165.64.22;
Received: (qmail invoked by alias); 01 May 2011 09:45:03 -0000
Received: from pD9EB2517.dip0.t-ipconnect.de (EHLO noname) [217.235.37.23]
  by mail.gmx.net (mp056) with SMTP; 01 May 2011 11:45:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19vOg0NSsNvVved/gfZaAQQI8GGnwOsXg9TvKGBOV
	6AlA86IlApaMte
X-X-Sender: gene099@bonsai2
In-Reply-To: <ipj5k5$j04$1@dough.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of Johannes.Schindelin@gmx.de designates 213.165.64.22 as permitted
 sender) smtp.mail=Johannes.Schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172536>

Hi,

On Sun, 1 May 2011, Sebastian Schuberth wrote:

> while preparing for the msysGit 1.7.5 release, I came across a strange 
> issue with cherry-picking when using my own local build of 
> 1.7.5.msysgit.1.1.g05d0e (built from the msysgit.git / 4msysgit.git 
> devel branches; note that 4msysgit.git's devel is based on git.git's aka 
> Junio's next).
> 
> To test the recent "BindImage" additions to the Windows installer, I 
> did:
> 
> # Create a topic branch based on msysgit.git devel:
> sebastian@PASSAU / (devel)
> $ git checkout -b ss/bindimage
> M       git
> Switched to a new branch 'ss/bindimage'
> 
> # Cherry-pick the "BindImage" commit from msysgit.git's mob:
> sebastian@PASSAU / (ss/bindimage)
> $ git cherry-pick 59467863efd336ba3a443a88ce140ab1e59a29f0
> error: could not apply 5946786... Call BindImage on installer for all the exe and dll files
> hint: after resolving the conflicts, mark the corrected paths
> hint: with 'git add <paths>' or 'git rm <paths>'
> hint: and commit the result with 'git commit'
> 
> # Inspect the working tree:
> sebastian@PASSAU / (ss/bindimage|CHERRY-PICKING)
> $ git status
> # On branch ss/bindimage
> # Changes to be committed:
> #
> #       modified:   share/WinGit/copy-files.sh
> #       modified:   share/WinGit/install.iss
> #
> # Changes not staged for commit:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #
> #       modified:   git (new commits)
> #
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #       share/InnoSetup/ISCmplr.dll~5946786... Call BindImage on installer for all the exe and dll files

This looks like some problem trying to check out that file from another 
branch. Since you say that this problem does not occur when starting from 
the 1.7.4 tag, and you updated ISCmplr.dll 6 days after that, I could 
imagine that something locks the .dll. After all, the current 'mob' is 
still based off of 1.7.4 not off of the current 'devel'.

There should not have been a problem, though, as the .dll has not changed 
between the merge base and 5946786...

FWIW on Linux, the same cherry-pick works just fine.

Ciao,
Dscho
