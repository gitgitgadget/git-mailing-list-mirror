From: rupert thurner <rupert.thurner@gmail.com>
Subject: Re: [PATCH] compat/mingw: stubs for getpgid() and tcgetpgrp()
Date: Thu, 23 Apr 2015 12:25:49 -0700 (PDT)
Message-ID: <cc79154d-4e18-41a4-938f-ca6e30b2e6d9@googlegroups.com>
References: <20150413134850.GC23475@mewburn.net>
 <alpine.LFD.2.11.1504130954420.5619@knanqh.ubzr>
 <20150413144039.GD23475@mewburn.net>
 <alpine.LFD.2.11.1504131052090.5619@knanqh.ubzr>
 <20150414110312.GE23475@mewburn.net> <552EAE0A.3040208@kdbg.org>
 <CABPQNSZ-7FAgun8mxqXYWgy+Xc9xQMXKZonwujXb5WzLCKmNMw@mail.gmail.com>
 <fac9a525a2fb2b09d176243659cbf3a7@www.dscho.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_240_610169509.1429817149053"
Cc: nico@fluxnic.net, git-owner@vger.kernel.org, rupert.thurner@gmail.com, 
	git@vger.kernel.org, j6t@kdbg.org, luke@mewburn.net, 
	kusmabite@gmail.com
To: msysgit@googlegroups.com
X-From: msysgit+bncBCBO3N6S34BRBPMO4WUQKGQEH2AQV3I@googlegroups.com Thu Apr 23 21:25:51 2015
Return-path: <msysgit+bncBCBO3N6S34BRBPMO4WUQKGQEH2AQV3I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yh0-f62.google.com ([209.85.213.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCBO3N6S34BRBPMO4WUQKGQEH2AQV3I@googlegroups.com>)
	id 1YlMkw-0004Np-Nr
	for gcvm-msysgit@m.gmane.org; Thu, 23 Apr 2015 21:25:50 +0200
Received: by yhzz6 with SMTP id z6sf7096063yhz.0
        for <gcvm-msysgit@m.gmane.org>; Thu, 23 Apr 2015 12:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=CD09MvNie7AJqLxS4l5fL6g5vTRoUVxbz24aktlc1V0=;
        b=OfpoYfn3XUODm8emxCcImb8ZNVybhIUlCeiZE5RQiVhStHNstMXBls4Icz2YMCOwVB
         FWQm8Fqeqy3rbyvFngMFEL6PsiLASi7gl+PbC5B71UXtIdlQA96pXkhWqmS0sI7UYLTJ
         x7TNBO8OZ97nE1VdH/Oes9n6niDYCqAzs5RpLj5eA29fe8AFwoU9kqTDX92BwmIwk+WP
         KWYUa/X3bLcWyaPIyLP9J3Ej0Uy5DLSkIT6y73QPbTjiZHfGao39YpXozDKOaBM34a1v
         f+j0iFpDnKXA+j+xegcfzeW36BCyyW6aS8DnE2bCSmDv1YasSDg1SUW+wqvDAsZpm/92
         xC7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=CD09MvNie7AJqLxS4l5fL6g5vTRoUVxbz24aktlc1V0=;
        b=nU4+QgLTnl1lsfreHGniDhS0FqbvoH+q+OIwM82aGBOoAn74uwtCH8sc7sRbd1l+ZO
         +mKULjkvCj6nbfaIAxlnEUamczJoM4PVhmSHhbRn33AoZlH0glwJ0Ci+K24Xe5ERoRA9
         dMC/rL/9klOJ+d8rs0Oze9zvTYXmF0LHMuG/wWMgwNh7Jz8nxGvJVNdtSfxssRRsEpZO
         Wis0+cqF9rJQQnyXtmfhawkqN3SsuCJRb9cYOzw1Vrbzh9jxpYvYuL7VIXsyVNZ2jVFH
         dKHv+Rgc0qrXosRRlqleOnl47kAucAUu308VHti3aW1zusX7uWy2f/GdGYdQ7hBK3CLc
         PLGA==
X-Received: by 10.140.98.116 with SMTP id n107mr71565qge.11.1429817149965;
        Thu, 23 Apr 2015 12:25:49 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.41.83 with SMTP id y77ls1328867qgy.88.gmail; Thu, 23 Apr
 2015 12:25:49 -0700 (PDT)
X-Received: by 10.140.41.164 with SMTP id z33mr77858qgz.21.1429817149498;
        Thu, 23 Apr 2015 12:25:49 -0700 (PDT)
In-Reply-To: <fac9a525a2fb2b09d176243659cbf3a7@www.dscho.org>
X-Original-Sender: rupert.thurner@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267702>

------=_Part_240_610169509.1429817149053
Content-Type: multipart/alternative; 
	boundary="----=_Part_241_884523338.1429817149053"

------=_Part_241_884523338.1429817149053
Content-Type: text/plain; charset=UTF-8

On Thursday, April 16, 2015 at 2:45:11 PM UTC+2, Johannes Schindelin wrote:
>
> Hi kusma, 
>
> On 2015-04-15 21:43, Erik Faye-Lund wrote: 
> > On Wed, Apr 15, 2015 at 8:29 PM, Johannes Sixt <j...@kdbg.org 
> <javascript:>> wrote: 
> >> Windows does not have process groups. It is, therefore, the simplest 
> >> to pretend that each process is in its own process group. 
> > 
> > Windows does have some concept of process groups, but probably not 
> > quite what you want: 
> > 
> > 
> https://msdn.microsoft.com/en-us/library/windows/desktop/ms682083%28v=vs.85%29.aspx 
>
> Yes, and we actually need that in Git for Windows anyway because shooting 
> down a process does not kill its child processes: 
>
>
> https://github.com/git-for-windows/msys2-runtime/commit/15f209511985092588b171703e5046eba937b47b#diff-8753cda163376cee6c80aab11eb8701fR402 
>
> However, using this code for `getppid()` would be serious overkill (not to 
> mention an unbearable performance hit because you have to enumerate *all* 
> processes to get that information). 
>
>
is the windows "JobObject" similar to processgroup? at least killing the 
parent process in a jobobject will kill all childs as well:
https://msdn.microsoft.com/en-us/library/windows/desktop/ms681949%28v=vs.85%29.aspx 

best,
rupert
 

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

------=_Part_241_884523338.1429817149053
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Thursday, April 16, 2015 at 2:45:11 PM UTC+2, Johannes =
Schindelin wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0;margi=
n-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">Hi kusma,
<br>
<br>On 2015-04-15 21:43, Erik Faye-Lund wrote:
<br>&gt; On Wed, Apr 15, 2015 at 8:29 PM, Johannes Sixt &lt;<a href=3D"java=
script:" target=3D"_blank" gdf-obfuscated-mailto=3D"8AoMxPPqC7sJ" rel=3D"no=
follow" onmousedown=3D"this.href=3D'javascript:';return true;" onclick=3D"t=
his.href=3D'javascript:';return true;">j...@kdbg.org</a>&gt; wrote:
<br>&gt;&gt; Windows does not have process groups. It is, therefore, the si=
mplest
<br>&gt;&gt; to pretend that each process is in its own process group.
<br>&gt;=20
<br>&gt; Windows does have some concept of process groups, but probably not
<br>&gt; quite what you want:
<br>&gt;=20
<br>&gt; <a href=3D"https://msdn.microsoft.com/en-us/library/windows/deskto=
p/ms682083%28v=3Dvs.85%29.aspx" target=3D"_blank" rel=3D"nofollow" onmoused=
own=3D"this.href=3D'https://www.google.com/url?q\75https%3A%2F%2Fmsdn.micro=
soft.com%2Fen-us%2Flibrary%2Fwindows%2Fdesktop%2Fms682083%2528v%3Dvs.85%252=
9.aspx\46sa\75D\46sntz\0751\46usg\75AFQjCNGEPk0vMRMUxQyGr9KCQrfPhQcBAA';ret=
urn true;" onclick=3D"this.href=3D'https://www.google.com/url?q\75https%3A%=
2F%2Fmsdn.microsoft.com%2Fen-us%2Flibrary%2Fwindows%2Fdesktop%2Fms682083%25=
28v%3Dvs.85%2529.aspx\46sa\75D\46sntz\0751\46usg\75AFQjCNGEPk0vMRMUxQyGr9KC=
QrfPhQcBAA';return true;">https://msdn.microsoft.com/en-<wbr>us/library/win=
dows/desktop/<wbr>ms682083%28v=3Dvs.85%29.aspx</a>
<br>
<br>Yes, and we actually need that in Git for Windows anyway because shooti=
ng down a process does not kill its child processes:
<br>
<br><a href=3D"https://github.com/git-for-windows/msys2-runtime/commit/15f2=
09511985092588b171703e5046eba937b47b#diff-8753cda163376cee6c80aab11eb8701fR=
402" target=3D"_blank" rel=3D"nofollow" onmousedown=3D"this.href=3D'https:/=
/www.google.com/url?q\75https%3A%2F%2Fgithub.com%2Fgit-for-windows%2Fmsys2-=
runtime%2Fcommit%2F15f209511985092588b171703e5046eba937b47b%23diff-8753cda1=
63376cee6c80aab11eb8701fR402\46sa\75D\46sntz\0751\46usg\75AFQjCNFLJ21sKQUCU=
zGh0M1gFTOnVAmt9g';return true;" onclick=3D"this.href=3D'https://www.google=
.com/url?q\75https%3A%2F%2Fgithub.com%2Fgit-for-windows%2Fmsys2-runtime%2Fc=
ommit%2F15f209511985092588b171703e5046eba937b47b%23diff-8753cda163376cee6c8=
0aab11eb8701fR402\46sa\75D\46sntz\0751\46usg\75AFQjCNFLJ21sKQUCUzGh0M1gFTOn=
VAmt9g';return true;">https://github.com/git-for-<wbr>windows/msys2-runtime=
/commit/<wbr>15f209511985092588b171703e5046<wbr>eba937b47b#diff-<wbr>8753cd=
a163376cee6c80aab11eb870<wbr>1fR402</a>
<br>
<br>However, using this code for `getppid()` would be serious overkill (not=
 to mention an unbearable performance hit because you have to enumerate *al=
l* processes to get that information).
<br><br></blockquote><div><br></div><div>is the windows "JobObject" similar=
 to processgroup? at least killing the parent process in a jobobject will k=
ill all childs as well:</div><div>https://msdn.microsoft.com/en-us/library/=
windows/desktop/ms681949%28v=3Dvs.85%29.aspx&nbsp;</div><div><br></div><div=
>best,</div><div>rupert</div><div>&nbsp;</div></div>

<p></p>

-- <br />
-- <br />
*** Please reply-to-all at all times ***<br />
*** (do not pretend to know who is subscribed and who is not) ***<br />
*** Please avoid top-posting. ***<br />
The msysGit Wiki is here: <a href=3D"https://github.com/msysgit/msysgit/wik=
i">https://github.com/msysgit/msysgit/wiki</a> - Github accounts are free.<=
br />
&nbsp;<br />
You received this message because you are subscribed to the Google<br />
Groups &quot;msysGit&quot; group.<br />
To post to this group, send email to msysgit@googlegroups.com<br />
To unsubscribe from this group, send email to<br />
msysgit+unsubscribe@googlegroups.com<br />
For more options, and view previous threads, visit this group at<br />
<a href=3D"http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den">http:=
//groups.google.com/group/msysgit?hl=3Den_US?hl=3Den</a><br />
<br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;Git for Windows&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:msysgit+unsubscribe@googlegroups.com">msysgit+uns=
ubscribe@googlegroups.com</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

------=_Part_241_884523338.1429817149053--
------=_Part_240_610169509.1429817149053--
