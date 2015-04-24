From: rupert thurner <rupert.thurner@gmail.com>
Subject: Re: [PATCH] compat/mingw: stubs for getpgid() and tcgetpgrp()
Date: Thu, 23 Apr 2015 20:03:26 -0700 (PDT)
Message-ID: <97173c38-4f76-49cd-8365-e97fde34ed35@googlegroups.com>
References: <20150413134850.GC23475@mewburn.net>
 <alpine.LFD.2.11.1504130954420.5619@knanqh.ubzr>
 <20150413144039.GD23475@mewburn.net>
 <alpine.LFD.2.11.1504131052090.5619@knanqh.ubzr>
 <20150414110312.GE23475@mewburn.net> <552EAE0A.3040208@kdbg.org>
 <CABPQNSZ-7FAgun8mxqXYWgy+Xc9xQMXKZonwujXb5WzLCKmNMw@mail.gmail.com>
 <fac9a525a2fb2b09d176243659cbf3a7@www.dscho.org>
 <cc79154d-4e18-41a4-938f-ca6e30b2e6d9@googlegroups.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_503_1927268680.1429844606472"
Cc: luke@mewburn.net, git-owner@vger.kernel.org, rupert.thurner@gmail.com, 
	nico@fluxnic.net, kusmabite@gmail.com, git@vger.kernel.org, 
	j6t@kdbg.org
To: msysgit@googlegroups.com
X-From: msysgit+bncBCBO3N6S34BRB7XE42UQKGQE6Z43K3A@googlegroups.com Fri Apr 24 05:03:33 2015
Return-path: <msysgit+bncBCBO3N6S34BRB7XE42UQKGQE6Z43K3A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qg0-f63.google.com ([209.85.192.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCBO3N6S34BRB7XE42UQKGQE6Z43K3A@googlegroups.com>)
	id 1YlTtn-0003u3-T8
	for gcvm-msysgit@m.gmane.org; Fri, 24 Apr 2015 05:03:28 +0200
Received: by qgaj5 with SMTP id j5sf9337110qga.1
        for <gcvm-msysgit@m.gmane.org>; Thu, 23 Apr 2015 20:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=yxBWH0i/YvdCDUrG/TRD83r258qgbawZjuFEfEqsRg8=;
        b=uSO+gZDv9zHkbxgVkISAqNkkotmjyIu7Ic1VTgPOiFSwQhrY6HBJkbDWYCqiXA+olh
         PY3L6YCAh49hD2fZWMy/ii9OWYHh6o1iZAH4dVHWwRpmyTrxqd3jwsk+UkDkRsQk2vvl
         9VG2yOj1h6UbBPfP1hu4YsvHBvixlbtpZxXTamBnsHqujPC6CNUS7lAorIpVflB0EWH4
         X9xZeDW2cOLHhDwxseJGHLZjbjVuKF2w7okaclXbooEp3c9KTSdnO7Y4bi32qiuAqGYp
         9T6XgfQNw9yvNSMZ10sd29xSwoHYniN2bDOn1vLjqpQAO7D87DTiNyV5PHg0N8uWa0gr
         q4AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=yxBWH0i/YvdCDUrG/TRD83r258qgbawZjuFEfEqsRg8=;
        b=c0Y5E+XVZEJ7WOz2PI/vwi/rQv2DO5mkRF7jjrDlLgb5kMFWsIQTIqsMEvT8STTnMR
         c7s5N8ulEYIkP8MVC9CTrNWPN+nfO1USqHmTLVCzbp03+x3qB+7KhSwX28wORWNt1VUK
         errZGY1VNiyOZy2GIU2xgB7sBv5dA5jnFati9EctLomLET5rur5CrSpCtfMKJ6DhDlr0
         CEy950sCNW/7rqlfoMZ5ugqFr/ycaOmNBU548z6KvBrdxwQRs8sO6dvZsipN+OW0+C7t
         NMb1y1k9T0FGMTUrDerZANHkf8QNERYDK9sacIZaHA8x4TB8liNNcZBX9tRtFUKa2acp
         3w+A==
X-Received: by 10.140.94.170 with SMTP id g39mr91454qge.34.1429844607193;
        Thu, 23 Apr 2015 20:03:27 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.106.52 with SMTP id d49ls1396458qgf.32.gmail; Thu, 23 Apr
 2015 20:03:26 -0700 (PDT)
X-Received: by 10.140.106.181 with SMTP id e50mr93892qgf.29.1429844606770;
        Thu, 23 Apr 2015 20:03:26 -0700 (PDT)
In-Reply-To: <cc79154d-4e18-41a4-938f-ca6e30b2e6d9@googlegroups.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267721>

------=_Part_503_1927268680.1429844606472
Content-Type: multipart/alternative; 
	boundary="----=_Part_504_1108857059.1429844606472"

------=_Part_504_1108857059.1429844606472
Content-Type: text/plain; charset=UTF-8

On Thursday, April 23, 2015 at 9:25:49 PM UTC+2, rupert thurner wrote:
>
> On Thursday, April 16, 2015 at 2:45:11 PM UTC+2, Johannes Schindelin wrote:
>>
>> Hi kusma, 
>>
>> On 2015-04-15 21:43, Erik Faye-Lund wrote: 
>> > On Wed, Apr 15, 2015 at 8:29 PM, Johannes Sixt <j...@kdbg.org> wrote: 
>> >> Windows does not have process groups. It is, therefore, the simplest 
>> >> to pretend that each process is in its own process group. 
>> > 
>> > Windows does have some concept of process groups, but probably not 
>> > quite what you want: 
>> > 
>> > 
>> https://msdn.microsoft.com/en-us/library/windows/desktop/ms682083%28v=vs.85%29.aspx 
>>
>> Yes, and we actually need that in Git for Windows anyway because shooting 
>> down a process does not kill its child processes: 
>>
>>
>> https://github.com/git-for-windows/msys2-runtime/commit/15f209511985092588b171703e5046eba937b47b#diff-8753cda163376cee6c80aab11eb8701fR402 
>>
>> However, using this code for `getppid()` would be serious overkill (not 
>> to mention an unbearable performance hit because you have to enumerate 
>> *all* processes to get that information). 
>>
>>
> is the windows "JobObject" similar to processgroup? at least killing the 
> parent process in a jobobject will kill all childs as well:
>
> https://msdn.microsoft.com/en-us/library/windows/desktop/ms681949%28v=vs.85%29.aspx
>  
>

here some discussion of windows console process group, 
CREATE_NEW_PROCESS_GROUP, GenerateConsoleCtrlEvent, and job object from the 
last century:
https://www.microsoft.com/msj/0698/win320698.aspx

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

------=_Part_504_1108857059.1429844606472
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Thursday, April 23, 2015 at 9:25:49 PM UTC+2, rupert th=
urner wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-lef=
t: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;"><div dir=3D"ltr">O=
n Thursday, April 16, 2015 at 2:45:11 PM UTC+2, Johannes Schindelin wrote:<=
blockquote class=3D"gmail_quote" style=3D"margin:0;margin-left:0.8ex;border=
-left:1px #ccc solid;padding-left:1ex">Hi kusma,
<br>
<br>On 2015-04-15 21:43, Erik Faye-Lund wrote:
<br>&gt; On Wed, Apr 15, 2015 at 8:29 PM, Johannes Sixt &lt;<a rel=3D"nofol=
low">j...@kdbg.org</a>&gt; wrote:
<br>&gt;&gt; Windows does not have process groups. It is, therefore, the si=
mplest
<br>&gt;&gt; to pretend that each process is in its own process group.
<br>&gt;=20
<br>&gt; Windows does have some concept of process groups, but probably not
<br>&gt; quite what you want:
<br>&gt;=20
<br>&gt; <a href=3D"https://msdn.microsoft.com/en-us/library/windows/deskto=
p/ms682083%28v=3Dvs.85%29.aspx" rel=3D"nofollow" target=3D"_blank" onmoused=
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
402" rel=3D"nofollow" target=3D"_blank" onmousedown=3D"this.href=3D'https:/=
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
ill all childs as well:</div><div><a href=3D"https://msdn.microsoft.com/en-=
us/library/windows/desktop/ms681949%28v=3Dvs.85%29.aspx" target=3D"_blank" =
rel=3D"nofollow" onmousedown=3D"this.href=3D'https://www.google.com/url?q\7=
5https%3A%2F%2Fmsdn.microsoft.com%2Fen-us%2Flibrary%2Fwindows%2Fdesktop%2Fm=
s681949%2528v%3Dvs.85%2529.aspx\46sa\75D\46sntz\0751\46usg\75AFQjCNGQ5EJlJb=
LgEJox94sZMuRUHpZjGA';return true;" onclick=3D"this.href=3D'https://www.goo=
gle.com/url?q\75https%3A%2F%2Fmsdn.microsoft.com%2Fen-us%2Flibrary%2Fwindow=
s%2Fdesktop%2Fms681949%2528v%3Dvs.85%2529.aspx\46sa\75D\46sntz\0751\46usg\7=
5AFQjCNGQ5EJlJbLgEJox94sZMuRUHpZjGA';return true;">https://msdn.microsoft.c=
om/en-<wbr>us/library/windows/desktop/<wbr>ms681949%28v=3Dvs.85%29.aspx</a>=
&nbsp;</div></div></blockquote><div><br></div><div>here some discussion of =
windows console process group,&nbsp;<span style=3D"color: rgb(0, 0, 0); fon=
t-family: verdana, arial, helvetica; font-size: small;">CREATE_NEW_PROCESS_=
GROUP,&nbsp;</span><span style=3D"font-size: small; color: rgb(0, 0, 0); fo=
nt-family: verdana, arial, helvetica;">GenerateConsoleCtrlEvent,</span>&nbs=
p;and job object from the last century:</div><div>https://www.microsoft.com=
/msj/0698/win320698.aspx<br></div><div><br></div><div>rupert</div><div><br>=
</div></div>

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

------=_Part_504_1108857059.1429844606472--
------=_Part_503_1927268680.1429844606472--
