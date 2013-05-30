From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t0008-ignores failure (was: Git for Windows 1.8.3)
Date: Thu, 30 May 2013 19:14:55 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1305301914290.650@s15462909.onlinehome-server.info>
References: <CABNJ2G+u96P+_=Q7it0KbK9E01qunz7XZ7e3zCZvaTaOUuTQqQ@mail.gmail.com> <51A6A7B7.4010802@gmail.com> <alpine.DEB.1.00.1305301713400.650@s15462909.onlinehome-server.info> <CABNJ2GKPvbYFgqGL-g3Pnp7OghpoSfeuPEF0vNHixhQFkY+Uow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>, 
    msysGit <msysgit@googlegroups.com>, 
    Sebastian Schuberth <sschuberth@gmail.com>, Git List <git@vger.kernel.org>, 
    Adam Spiers <git@adamspiers.org>
To: Pat Thoyts <patthoyts@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBEMST2GQKGQEZCK6FQY@googlegroups.com Thu May 30 19:15:01 2013
Return-path: <msysgit+bncBCZPH74Q5YNRBEMST2GQKGQEZCK6FQY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f187.google.com ([209.85.217.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBEMST2GQKGQEZCK6FQY@googlegroups.com>)
	id 1Ui6RG-0003uB-H1
	for gcvm-msysgit@m.gmane.org; Thu, 30 May 2013 19:14:58 +0200
Received: by mail-lb0-f187.google.com with SMTP id v10sf243824lbd.14
        for <gcvm-msysgit@m.gmane.org>; Thu, 30 May 2013 10:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :x-y-gmx-trusted:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=EIs7G9IvMO/OV0+fdJ/x5lgEKGivJE4dGmactzdO8SU=;
        b=NhIZVNg8ugYpPmfjNAFwh/h0PcEqoa/XdL2s50PYuB4inPNgRmSjYxb0VzuJtSl16J
         mGherfCEwdRCJu1uBTdCDPDPe9qT8drFjgXok9wBrhlnMbaVKmtUSY5RCvkJSdnTKpYq
         pgGS+i575XqjdjtDFzijFZv4L9v9oqdU1jPWtjO/rVDEksu0Dhf70U4hnyghCBnAgkIu
         7xpv59It+Y9rsON03Bcu3sqkQtLev3ZLbgp0ZX+GiNngioUAkiw7Y1czNMPshMMgi/nw
         bEK2HzOIK4PYhztfr3fSbJZ05lubhUs 
X-Received: by 10.180.189.6 with SMTP id ge6mr2198435wic.6.1369934098140;
        Thu, 30 May 2013 10:14:58 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.39.197 with SMTP id r5ls372576wik.5.gmail; Thu, 30 May
 2013 10:14:57 -0700 (PDT)
X-Received: by 10.14.214.67 with SMTP id b43mr10099480eep.0.1369934097031;
        Thu, 30 May 2013 10:14:57 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.22])
        by gmr-mx.google.com with ESMTP id o5si10148018eew.0.2013.05.30.10.14.56
        for <msysgit@googlegroups.com>;
        Thu, 30 May 2013 10:14:57 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.22 as permitted sender) client-ip=212.227.17.22;
Received: from mailout-de.gmx.net ([10.1.76.33]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MMIE7-1UnL6D2OJp-0080TM for
 <msysgit@googlegroups.com>; Thu, 30 May 2013 19:14:56 +0200
Received: (qmail invoked by alias); 30 May 2013 17:14:56 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp033) with SMTP; 30 May 2013 19:14:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/vm4gnL9DvV/aj9VCZ+y9un9o3+BXiCNB3cCkNBg
	FTJELnOY9rntls
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CABNJ2GKPvbYFgqGL-g3Pnp7OghpoSfeuPEF0vNHixhQFkY+Uow@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.22 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226027>

Hi Pat,

On Thu, 30 May 2013, Pat Thoyts wrote:

> On 30 May 2013 16:15, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > On Thu, 30 May 2013, Karsten Blees wrote:
> >
> >> Am 25.05.2013 21:16, schrieb Pat Thoyts:
> >> > On that note -- with this merge as it now stands I get the following
> >> > test failures:
> >> >
> >> > t0008-ignores.sh                     155, 158, 162, 164
> >>
> >> These tests fail because they use absolute paths, e.g.
> >> "C:/.../global-excludes", which is then translated to
> >> "C<NUL>/.../global-excludes". Can be fixed like so:
> >>
> >> --- 8< ---
> >> --- a/t/t0008-ignores.sh
> >> +++ b/t/t0008-ignores.sh
> >> @@ -5,7 +5,7 @@ test_description=check-ignore
> >>  . ./test-lib.sh
> >>
> >>  init_vars () {
> >> -       global_excludes="$(pwd)/global-excludes"
> >> +       global_excludes="global-excludes"
> >>  }
> >>
> >>  enable_global_excludes () {
> >> ---
> >
> > Since I do not have time for the lengthy, undirected discussion upstream
> > seems to want to start, let's make your change, but only conditional on
> > MINGW?
> 
> I was just testing this -- I've already wrapped the suggested fix
> within a "test_have_prereq MINGW" for our fork and committed it. This
> was  an issue partly because was alias pwd to "pwd -W" and so always
> get Windows paths. It means the test here doesn't check absolute paths
> but I think we can live with that. I tried using $(builtin pwd) to
> avoid the "-W" but it didn't help and I still got C: style paths.
> 
> I also grabbed Karsten's patch "dir.c: fix ignore processing within
> not-ignored directories" as this appears to deal with a .gitignore
> regression in 1.8.3. We can carry this until the next merge with
> upstream.

Thanks!
Dscho

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
