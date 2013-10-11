From: Stefan Zager <szager@google.com>
Subject: Re: Windows performance / threading file access
Date: Thu, 10 Oct 2013 22:28:10 -0700
Message-ID: <CAHOQ7J9S6hJd4HrJrkXDcvrKihtrWF5zLK6dyownXKVCo2TqdQ@mail.gmail.com>
References: <CAHOQ7J_ZZ=7j-5ULd7Tdvbiqg4inhwi+fue_w6WAtNRkvZSwsg@mail.gmail.com>
	<52570BC1.2040208@gmail.com>
	<52574B90.3070309@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=089e0122f65e514dd904e870627b
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org, 
	msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBDYNHXNRX4GBBGUE36JAKGQEUFTXMVY@googlegroups.com Fri Oct 11 11:17:16 2013
Return-path: <msysgit+bncBDYNHXNRX4GBBGUE36JAKGQEUFTXMVY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oa0-f63.google.com ([209.85.219.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDYNHXNRX4GBBGUE36JAKGQEUFTXMVY@googlegroups.com>)
	id 1VUYqR-0003Oa-NP
	for gcvm-msysgit@m.gmane.org; Fri, 11 Oct 2013 11:17:16 +0200
Received: by mail-oa0-f63.google.com with SMTP id g12sf580891oah.8
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Oct 2013 02:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=QgCnHvnviWcEsiB8N+OieBnb4Mjd+WsGpYYA8aHrTmk=;
        b=QPzvg4TP0dQy0mDctMxmQiR9TR+/FioJ6mCaWX1hLQqtotrQolfAiQnlwnDNPB0Gnl
         OnoNjmQhLKDy8x9COI2x4icLYnzWJmNsjmAJW6vDzfTmWQEzTQRQO0QBbA8OIxohkiPj
         94rtPz3IdaqQO3gpuQoBoLGqs/4S4r+Cm/670GqUkKPElJvc/VFbwD7RMgHIldcRILLV
         HiLnhp/3D/DYs6wqN5pCcNSrsDaQyW+I1xW7ZvTg/agyxgEdBAB8x2pgxFBFJAaldVT9
         xYVPnubJhuW+tecvR1ff67tgb15EI+4bgR4NY9AjD+RqzqaeP65NVd9ejmbBJzkrNcOP
         wasw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=QgCnHvnviWcEsiB8N+OieBnb4Mjd+WsGpYYA8aHrTmk=;
        b=VWeXA/Gf8L5FD6gKycvuwWbnVNgq0mDYMwJ2YHpMXvgRDkwOKJEofN7LbS/tG9x5ty
         f4q1by8K66nCunNpj2NFcJkItZ21rpOUpUNzbs3fMe2uoE85ND5WULqrjBboqdGWJYwy
         iH8/Bo8550i34NBZ/5WXyQYL+4E13LVqEe8CPMSVGW+IpUf31AAmcXXSdrjWXny+3I+J
         WmyJ/7l65Ku8fOzBm8pfBaMU2q786SdX0D95UFfRVw4UMe7WYR05Ee/uiaG++CQrmP4v
         o6GWWa508fS87nYv1xRvwVXhf5GGUzE79KR1KqmLWaffa01sCBFxnPMtJKaPK8qZNM2c
         4MCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=QgCnHvnviWcEsiB8N+OieBnb4Mjd+WsGpYYA8aHrTmk=;
        b=akDqL2+zxA9+vlw86hRRjjvSQCS1WyGJ8kdhnd8qWk6hlGYZMGgvLvzASbqsb8f6EQ
         qfX+pDBqzNa4kvELac916sg4reGWSHejrS5UXXhyJZXzCbL0UXYNbfSz28NdRgddjWQd
         ScEH6ywS0wworcNqOAyIbAfZeMsn4x0kZy7OaNvjK2f2mscV3DLGUGSTDq9rpEis8Qmk
         4gnujkulnFPMA+QX82ZfzUL9k7fqOIGLWXWaiDa+5gQqHoDIUs79QFsws5viw2pEATCa
         F7/0XrGGCiNzRMM2qP2wEO6HU9ybgSUhS2UQewII9K6Gbt3aBMMcUXIZ9x+8rQxNhpvX
         8zDg==
X-Received: by 10.49.94.41 with SMTP id cz9mr15012qeb.26.1381483034780;
        Fri, 11 Oct 2013 02:17:14 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.59.36 with SMTP id w4ls1270137qeq.67.gmail; Fri, 11 Oct
 2013 02:17:14 -0700 (PDT)
X-Received: by 10.236.18.196 with SMTP id l44mr16055062yhl.52.1381483034327;
        Fri, 11 Oct 2013 02:17:14 -0700 (PDT)
Received: by 10.50.73.1 with SMTP id h1msigv;
        Thu, 10 Oct 2013 22:28:10 -0700 (PDT)
X-Received: by 10.182.220.170 with SMTP id px10mr5591827obc.35.1381469290513;
        Thu, 10 Oct 2013 22:28:10 -0700 (PDT)
Received: from mail-vb0-x233.google.com (mail-vb0-x233.google.com [2607:f8b0:400c:c02::233])
        by gmr-mx.google.com with ESMTPS id ee5si3785147vdb.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Oct 2013 22:28:10 -0700 (PDT)
Received-SPF: pass (google.com: domain of szager@google.com designates 2607:f8b0:400c:c02::233 as permitted sender) client-ip=2607:f8b0:400c:c02::233;
Received: by mail-vb0-x233.google.com with SMTP id x16so2354852vbf.24
        for <msysgit@googlegroups.com>; Thu, 10 Oct 2013 22:28:10 -0700 (PDT)
X-Gm-Message-State: ALoCoQkFd12MjpK8mpTwksVRL4KVF67HX6DsUFZb573j4HG1XEFOQKqMPEF6g7suUCBjD3FQ3NFibsL2KzEb4F7kaadPYyCBGpp1lZi+0AVwCIFP/NAeEfgXEdosQ0pbZL516d1MtQm59mMh+eb8rTfrgugVjndz9NL1Q72Wqk77srxF69zlvaaVP3P7qF04qyozz/EJ2Wjt0/4gUFbjUtADqCuyCLKTSQ==
X-Received: by 10.52.52.137 with SMTP id t9mr16733785vdo.22.1381469290298;
 Thu, 10 Oct 2013 22:28:10 -0700 (PDT)
Received: by 10.52.115.165 with HTTP; Thu, 10 Oct 2013 22:28:10 -0700 (PDT)
In-Reply-To: <52574B90.3070309@gmail.com>
X-Original-Sender: szager@google.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of szager@google.com designates 2607:f8b0:400c:c02::233
 as permitted sender) smtp.mail=szager@google.com;       dkim=pass
 header.i=@google.com;       dmarc=pass (p=REJECT dis=NONE) header.from=google.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235895>

--089e0122f65e514dd904e870627b
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Oct 10, 2013 at 5:51 PM, Karsten Blees <karsten.blees@gmail.com>wrote:


> >> I've noticed that when working with a very large repository using msys
> >> git, the initial checkout of a cloned repository is excruciatingly
> >> slow (80%+ of total clone time).  The root cause, I think, is that git
> >> does all the file access serially, and that's really slow on Windows.
> >>
>
> What exactly do you mean by "excruciatingly slow"?
>
> I just ran a few tests with a big repo (WebKit, ~2GB, ~200k files). A full
> checkout with git 1.8.4 on my SSD took 52s on Linux and 81s on Windows.
> Xcopy /s took ~4 minutes (so xcopy is much slower than git). On a 'real' HD
> (WD Caviar Green) the Windows checkout took ~9 minutes.
>

I'm using blink for my test, which should be more or less indistinguishable
from WebKit.  I'm using a standard spinning disk, no SSD.  For my purposes,
I need to optimize this for "standard" hardware, not for best-in-class.

For my test, I first run 'git clone -n <repo>', and then measure the
running time of 'git checkout --force HEAD'.  On linux, the checkout
command runs in 0:12; on Windows, it's about 3:30.


> If your numbers are much slower, check for overeager virus scanners and
> probably the infamous "User Account Control" (On Vista/7 (8?), the
> luafv.sys driver slows down things on the system drive even with UAC turned
> off in control panel. The driver can be disabled with "sc config luafv
> start= disabled" + reboot. Reenable with "sc config luafv start= auto").
>

I confess that I am pretty ignorant about Windows, so I'll have to research
these.

>> Has anyone considered threading file access to speed this up?  In
> >> particular, I've got my eye on this loop in unpack-trees.c:
> >>
>
> Its probably worth a try, however, in my experience, doing disk IO in
> parallel tends to slow things down due to more disk seeks.


> I'd rather try to minimize seeks, ...
>

In my experience, modern disk controllers are very very good at this; it
rarely, if ever, makes sense to try and outsmart them.

But, from talking to Windows-savvy people, I believe the issue is not disk
seek time, but rather the fact that Windows doesn't cache file stat
information.  Instead, it goes all the way to the source of truth (i.e.,
the physical disk) every time it stats a file or directory.  That's what
causes the checkout to be so slow: all those file stats run serially.

Does that sound right?  I'm prepared to be wrong about this; but if no one
has tried it, then it's probably at least worth an experiment.

Thanks,

Stefan

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

--089e0122f65e514dd904e870627b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Thu, Oct 10, 2013 at 5:51 PM, Karsten Blees <span dir=
=3D"ltr">&lt;<a href=3D"mailto:karsten.blees@gmail.com" target=3D"_blank">k=
arsten.blees@gmail.com</a>&gt;</span> wrote:<br><div class=3D"gmail_extra">=
<div class=3D"gmail_quote">
<div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><div class=3D"im">&gt;&gt; I&#=
39;ve noticed that when working with a very large repository using msys<br>
&gt;&gt; git, the initial checkout of a cloned repository is excruciatingly=
<br>
&gt;&gt; slow (80%+ of total clone time). =A0The root cause, I think, is th=
at git<br>
&gt;&gt; does all the file access serially, and that&#39;s really slow on W=
indows.<br>
&gt;&gt;<br>
<br>
</div>What exactly do you mean by &quot;excruciatingly slow&quot;?<br>
<br>
I just ran a few tests with a big repo (WebKit, ~2GB, ~200k files). A full =
checkout with git 1.8.4 on my SSD took 52s on Linux and 81s on Windows. Xco=
py /s took ~4 minutes (so xcopy is much slower than git). On a &#39;real&#3=
9; HD (WD Caviar Green) the Windows checkout took ~9 minutes.<br>
</blockquote><div><br></div><div>I&#39;m using blink for my test, which sho=
uld be more or less indistinguishable from WebKit. =A0I&#39;m using a stand=
ard spinning disk, no SSD. =A0For my purposes, I need to optimize this for =
&quot;standard&quot; hardware, not for best-in-class.</div>
<div><br></div><div>For my test, I first run &#39;git clone -n &lt;repo&gt;=
&#39;, and then measure the running time of &#39;git checkout --force HEAD&=
#39;. =A0On linux, the checkout command runs in 0:12; on Windows, it&#39;s =
about 3:30.</div>
<div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
If your numbers are much slower, check for overeager virus scanners and pro=
bably the infamous &quot;User Account Control&quot; (On Vista/7 (8?), the l=
uafv.sys driver slows down things on the system drive even with UAC turned =
off in control panel. The driver can be disabled with &quot;sc config luafv=
 start=3D disabled&quot; + reboot. Reenable with &quot;sc config luafv star=
t=3D auto&quot;).<br>
</blockquote><div><br></div><div>I confess that I am pretty ignorant about =
Windows, so I&#39;ll have to research these.</div><div><br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<div class=3D"im">
&gt;&gt; Has anyone considered threading file access to speed this up? =A0I=
n<br>
&gt;&gt; particular, I&#39;ve got my eye on this loop in unpack-trees.c:<br=
>
&gt;&gt;<br>
<br>
</div>Its probably worth a try, however, in my experience, doing disk IO in=
 parallel tends to slow things down due to more disk seeks.=A0</blockquote>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">

<br>
I&#39;d rather try to minimize seeks, ...<br></blockquote><div><br></div><d=
iv>In my experience, modern disk controllers are very very good at this; it=
 rarely, if ever, makes sense to try and outsmart them.</div><div><br>
</div><div>But, from talking to Windows-savvy people, I believe the issue i=
s not disk seek time, but rather the fact that Windows doesn&#39;t cache fi=
le stat information. =A0Instead, it goes all the way to the source of truth=
 (i.e., the physical disk) every time it stats a file or directory. =A0That=
&#39;s what causes the checkout to be so slow: all those file stats run ser=
ially.</div>
<div><br></div><div>Does that sound right? =A0I&#39;m prepared to be wrong =
about this; but if no one has tried it, then it&#39;s probably at least wor=
th an experiment.</div><div><br></div><div>Thanks,</div><div><br></div><div=
>
Stefan</div></div></div></div>

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
&nbsp;<br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;msysGit&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.<br />
For more options, visit <a href=3D"https://groups.google.com/groups/opt_out=
">https://groups.google.com/groups/opt_out</a>.<br />

--089e0122f65e514dd904e870627b--
