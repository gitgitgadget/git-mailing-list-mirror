From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: pre-receive hook output invalid characters
Date: Wed, 31 Oct 2012 17:27:18 +0100
Message-ID: <CABPQNSZqNyKvFKoG6E0+JDaaNnUbWCaFH-WfKE1MicwDH-3TFA@mail.gmail.com>
References: <1b3d3eb1-ed6c-4d03-8fdb-bf2ba2163647@googlegroups.com> <CABPQNSYj1-aaQieztkLxZjOhBQMqBJy+9POcmMcjGO4-a=EM9Q@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=20cf3071cf1ebf763604cd5d62c2
Cc: msysgit@googlegroups.com, GIT Mailing-list <git@vger.kernel.org>
To: mnaoumov@gmail.com
X-From: msysgit+bncBDR53PPJ7YHRBD5DYWCAKGQEL4E5GZA@googlegroups.com Wed Oct 31 17:28:12 2012
Return-path: <msysgit+bncBDR53PPJ7YHRBD5DYWCAKGQEL4E5GZA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f186.google.com ([209.85.214.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBD5DYWCAKGQEL4E5GZA@googlegroups.com>)
	id 1TTb9F-0001zB-En
	for gcvm-msysgit@m.gmane.org; Wed, 31 Oct 2012 17:28:09 +0100
Received: by mail-ob0-f186.google.com with SMTP id eq6sf1040654obc.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 31 Oct 2012 09:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=+Q1la0rPTr2d5RaxYvuappGUsl825n+tasoz1GlWoDk=;
        b=GoCwYp8icb0jW36eDqxqLXuUbXm3y3gSCsJ2w5bqZDa9VIYnsN0aL+PtXzJaXwtG+g
         nVLz4vUIAS8Vtl+k9+eJAyGXiuw4a2n5Q58vg28NTRLzXaGPgepFhDic0h5Vc4MUDRze
         9t0mJ3z4v1xYZvuLqeWx8yCW5z/G5tLYDB089cXF5ySa0RHdgl0HmQ/wzrvBSoCeTNVT
         A4MjK6HwogKWjP/KpTJ1LF6OunSoCQUGvi2QD9US2jj1mUb8kr9bna7enjuBoItzZTqP
         qz8vcCxxhAZ9J+l/HQ9pRWtXs2cthEQEKnNy6gNT7sTRMdx58AlBen++ZPbQIVwz+QOm
         VKeQ==
Received: by 10.52.71.82 with SMTP id s18mr6915248vdu.9.1351700880101;
        Wed, 31 Oct 2012 09:28:00 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.220.219.69 with SMTP id ht5ls1220301vcb.7.gmail; Wed, 31 Oct
 2012 09:27:59 -0700 (PDT)
Received: by 10.58.216.100 with SMTP id op4mr13670559vec.25.1351700879421;
        Wed, 31 Oct 2012 09:27:59 -0700 (PDT)
Received: by 10.58.216.100 with SMTP id op4mr13670558vec.25.1351700879403;
        Wed, 31 Oct 2012 09:27:59 -0700 (PDT)
Received: from mail-vb0-f53.google.com (mail-vb0-f53.google.com [209.85.212.53])
        by gmr-mx.google.com with ESMTPS id q19si554686vds.3.2012.10.31.09.27.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 31 Oct 2012 09:27:59 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.212.53 as permitted sender) client-ip=209.85.212.53;
Received: by mail-vb0-f53.google.com with SMTP id fc21so1739273vbb.40
        for <msysgit@googlegroups.com>; Wed, 31 Oct 2012 09:27:59 -0700 (PDT)
Received: by 10.52.66.10 with SMTP id b10mr47473872vdt.71.1351700879209; Wed,
 31 Oct 2012 09:27:59 -0700 (PDT)
Received: by 10.58.169.106 with HTTP; Wed, 31 Oct 2012 09:27:18 -0700 (PDT)
In-Reply-To: <CABPQNSYj1-aaQieztkLxZjOhBQMqBJy+9POcmMcjGO4-a=EM9Q@mail.gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.212.53 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208838>

--20cf3071cf1ebf763604cd5d62c2
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Oct 31, 2012 at 4:45 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:

> On Wed, Oct 31, 2012 at 4:24 PM, <mnaoumov@gmail.com> wrote:
>
>> If you add *pre-receive* hook in your git repository with the following
>> content
>>
>> #!/bin/sh
>>
>> echo Message
>> exit 1
>>
>> And then try to push you will get the following
>>
>> [image: Git Extensions push]<https://a248.e.akamai.net/camo.github.com/04b160d6fd381c09c7b0a9f30400e981a086fd46/687474703a2f2f692e696d6775722e636f6d2f4431714b722e706e67>
>>
>> The bug is about these strange 3 last characters.
>>
>> Recently I raised a bug for GitExtensions but it seems to be msysgit
>> issue as I could reproduce it from PowerShell as well
>>
>> https://github.com/gitextensions/gitextensions/issues/1313
>>
>>


> What you're seeing is most likely a CR (a carriage return character).
> Windows has CRLF new-lines, and Unix uses only LF.
>
> My guess is that echo produces CRLF, and this gets carried through and
> incorrecly displayed.
>

OK, I can reproduce it in Git Bash now, and by doing "git push 2>&1 | od
-c" I can see that I'm getting "Message\033[K\n".

This looks a little bit puzzling, but the sequence matches ANSI_SUFFIX in
sideband.c. So it seems this is intentional. This dates back to ebe8fa73.

I wonder, shouldn't we check isatty also before assuming ANSI-sequences?

---8<---
diff --git a/sideband.c b/sideband.c
index d5ffa1c..bd3e5a8 100644
--- a/sideband.c
+++ b/sideband.c
@@ -29,7 +29,7 @@ int recv_sideband(const char *me, int in_stream, int out)

  memcpy(buf, PREFIX, pf);
  term = getenv("TERM");
- if (term && strcmp(term, "dumb"))
+ if (isatty(out) && term && strcmp(term, "dumb"))
  suffix = ANSI_SUFFIX;
  else
  suffix = DUMB_SUFFIX;
---8<---

Thoughts?

Unfortunately, I cannot reproduce it; all my attempts on using a local
> pre-receive hook seems to cause the following error:
>
> "error: cannot spawn hooks/pre-receive: No such file or directory"
>
> I have no clue why.
>

OK, that just me being stupid.

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

--20cf3071cf1ebf763604cd5d62c2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 31, 2012 at 4:45 PM, Erik Faye-Lund <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:kusmabite@gmail.com" target=3D"_blank">kusmabite@gmail.com</a>=
&gt;</span> wrote:<br><div class=3D"gmail_quote"><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">

<div class=3D"im">On Wed, Oct 31, 2012 at 4:24 PM,  <span dir=3D"ltr">&lt;<=
a href=3D"mailto:mnaoumov@gmail.com" target=3D"_blank">mnaoumov@gmail.com</=
a>&gt;</span> wrote:<br></div><div class=3D"gmail_quote"><div class=3D"im">=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">


<div><p style=3D"margin-bottom:15px;color:rgb(51,51,51);font-family:Helveti=
ca,arial,freesans,clean,sans-serif;line-height:20px;background-color:rgb(25=
1,251,251)">If you add=A0<strong>pre-receive</strong>=A0hook in your git re=
pository with the following content</p>


<pre style=3D"margin-top:15px;margin-bottom:15px;padding:6px 10px;border:1p=
x solid rgb(204,204,204);font-family:Consolas,&#39;Liberation Mono&#39;,Cou=
rier,monospace;background-color:rgb(248,248,248);line-height:19px;overflow:=
auto;border-top-left-radius:3px;border-top-right-radius:3px;border-bottom-r=
ight-radius:3px;border-bottom-left-radius:3px;color:rgb(51,51,51)">

<code style=3D"border-style:none;font-size:12px;font-family:Consolas,&#39;L=
iberation Mono&#39;,Courier,monospace;background-color:transparent;border-t=
op-left-radius:3px;border-top-right-radius:3px;border-bottom-right-radius:3=
px;border-bottom-left-radius:3px">#!/bin/sh

echo Message
exit 1
</code></pre><p style=3D"margin-top:15px;margin-bottom:15px;color:rgb(51,51=
,51);font-family:Helvetica,arial,freesans,clean,sans-serif;line-height:20px=
;background-color:rgb(251,251,251)">And then try to push you will get the f=
ollowing</p>


</div><div><p style=3D"margin-top:15px;margin-bottom:15px;color:rgb(51,51,5=
1);font-family:Helvetica,arial,freesans,clean,sans-serif;line-height:20px;b=
ackground-color:rgb(251,251,251)"><a href=3D"https://a248.e.akamai.net/camo=
.github.com/04b160d6fd381c09c7b0a9f30400e981a086fd46/687474703a2f2f692e696d=
6775722e636f6d2f4431714b722e706e67" style=3D"color:rgb(65,131,196)" target=
=3D"_blank"><img alt=3D"Git Extensions push" style=3D"max-width:100%"></a><=
/p>


<p style=3D"margin-top:15px;margin-bottom:15px;color:rgb(51,51,51);font-fam=
ily:Helvetica,arial,freesans,clean,sans-serif;line-height:20px;background-c=
olor:rgb(251,251,251)">The bug is about these strange 3 last characters.</p=
>


<p style=3D"margin-top:15px;margin-bottom:0px!important;color:rgb(51,51,51)=
;font-family:Helvetica,arial,freesans,clean,sans-serif;line-height:20px;bac=
kground-color:rgb(251,251,251)">Recently I raised a bug for GitExtensions b=
ut it seems to be msysgit issue as I could reproduce it from PowerShell as =
well</p>


<p style=3D"margin-top:15px;margin-bottom:0px!important;color:rgb(51,51,51)=
;font-family:Helvetica,arial,freesans,clean,sans-serif;line-height:20px;bac=
kground-color:rgb(251,251,251)"><a href=3D"https://github.com/gitextensions=
/gitextensions/issues/1313" target=3D"_blank">https://github.com/gitextensi=
ons/gitextensions/issues/1313</a><br>


</p></div>

<p></p>

</blockquote></div><div></div></div></blockquote><div><br></div><div>=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><div class=3D"gmail_quote"><div>What you&=
#39;re seeing is most likely a CR (a=A0carriage=A0return character). Window=
s has CRLF new-lines, and Unix uses only LF.</div>

<div><br></div><div>My guess is that echo produces CRLF, and this gets carr=
ied through and incorrecly displayed.</div>
<div></div></div></blockquote><div>=A0</div><div>OK, I can reproduce it in =
Git Bash now, and by doing &quot;git push 2&gt;&amp;1 | od -c&quot; I can s=
ee that I&#39;m getting=A0&quot;Message\033[K\n&quot;.</div><div><br></div>

<div>This looks a little bit puzzling, but the sequence matches=A0ANSI_SUFF=
IX in sideband.c. So it seems this is intentional. This dates back to=A0ebe=
8fa73.</div><div><br></div><div>I wonder, shouldn&#39;t we check isatty als=
o before assuming ANSI-sequences?</div>

<div><br></div><div>---8&lt;---</div><div><div>diff --git a/sideband.c b/si=
deband.c</div><div>index d5ffa1c..bd3e5a8 100644</div><div>--- a/sideband.c=
</div><div>+++ b/sideband.c</div><div>@@ -29,7 +29,7 @@ int recv_sideband(c=
onst char *me, int in_stream, int out)</div>

<div>=A0</div><div>=A0<span class=3D"Apple-tab-span" style=3D"white-space:p=
re">	</span>memcpy(buf, PREFIX, pf);</div><div>=A0<span class=3D"Apple-tab-=
span" style=3D"white-space:pre">	</span>term =3D getenv(&quot;TERM&quot;);<=
/div><div>-<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span=
>if (term &amp;&amp; strcmp(term, &quot;dumb&quot;))</div>

<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if (=
isatty(out) &amp;&amp; term &amp;&amp; strcmp(term, &quot;dumb&quot;))</div=
><div>=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>=
suffix =3D ANSI_SUFFIX;</div>

<div>=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>el=
se</div><div>=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>suffix =3D DUMB_SUFFIX;</div></div><div>---8&lt;---</div><div><br></=
div><div>
Thoughts?=A0</div>
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"gmail_quote"><d=
iv></div><div>Unfortunately, I cannot reproduce it; all my attempts on usin=
g a local pre-receive hook seems to cause the following error:</div>

<div><br></div><div>&quot;error: cannot spawn hooks/pre-receive: No such fi=
le or directory&quot;</div>
<div><br></div><div>I have no clue why.</div></div></blockquote><div>=A0</d=
iv></div>OK, that just me being stupid.

<p></p>

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

--20cf3071cf1ebf763604cd5d62c2--
