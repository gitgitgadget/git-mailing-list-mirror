From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Announce: Git for Windows 1.6.3
Date: Thu, 14 May 2009 21:02:40 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905142101450.27348@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0905071554070.16585@intel-tinevez-2-302> <alpine.DEB.2.00.0905141920140.10118@ds9.cixit.se>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Thu May 14 21:02:50 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f143.google.com ([209.85.221.143])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4gCf-0007pi-2F
	for gcvm-msysgit@m.gmane.org; Thu, 14 May 2009 21:02:49 +0200
Received: by qyk7 with SMTP id 7so2718167qyk.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 14 May 2009 12:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=4dP6sf3kVCOMdXHUUJT551mYNBbJrD+vuTHdjqXsaG4=;
        b=HuLmpGPgr/dTwLuR8YcYqe8lfOqwivza5s701kN8JR+Mg+4yz0AMxdvHU1MiPm9V41
         NJ7mp4zZTH8UUP3qatBKccPcbi6eN47qp+cbtS6o0TO/wiS68KbbcE+ydpcOcOge0zOX
         Kxndp/B2i5N9/FsEY2GO84cnFCDqF41Dktdyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=woG5E46Mkq4dBkWD8SfM2nQsnX3d1u+oZmJmxdo9GrmKeYsGNGaMH5E4meyqRpZ1L4
         ByDFltidWm84DYNDUHzag3otfKtv9V/F9NODLKgZwUQhHH3KUKMcprghwwZwtPdWXK+x
         ilytc84Q+buGymdztZuZEMeB7c2mWB8P1KmvA=
Received: by 10.224.37.11 with SMTP id v11mr472673qad.3.1242327754598;
        Thu, 14 May 2009 12:02:34 -0700 (PDT)
Received: by 10.230.2.2 with SMTP id 2gr5248vbh.0;
	Thu, 14 May 2009 12:02:34 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.223.103.83 with SMTP id j19mr34082fao.0.1242327753649; Thu, 14 May 2009 12:02:33 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 13si22838bwz.7.2009.05.14.12.02.33; Thu, 14 May 2009 12:02:33 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 14 May 2009 19:02:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38] by mail.gmx.net (mp011) with SMTP; 14 May 2009 21:02:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/eAydoR4feQyRi1sjMvxbFFZfjRLbGiXj21jYYTo vY19UCizYnBGEv
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.2.00.0905141920140.10118@ds9.cixit.se>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119213>


Hi,

On Thu, 14 May 2009, Peter Krefting wrote:

> Johannes Schindelin:
> 
> > Git Release Notes (Git-1.6.3-preview20090507)
> > Last update: 07 May 2009
> 
> I installed the -2 version, but I am having problems pushing:
> 
>  > git pull
>  git-upload-pack: error while loading shared libraries: libcurl.so.3: cannot
>  open shared object file: No such file or directory
>  fatal: The remote end hung up unexpectedly
> 
> I used the install that puts git in the PATH, and am running it from CMD in
> this case. Any ideas on what might be wrong?

First I scratched my head why Git for Windows would look for a .so instead 
of a .dll file.

But the puzzle is easy to solve: git-upload-pack is called on the remote 
side.  So it is not Git for Windows having this issue.

Ciao,
Dscho
