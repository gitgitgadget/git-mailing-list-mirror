From: mnaoumov@gmail.com
Subject: Re: pre-receive hook output invalid characters
Date: Wed, 31 Oct 2012 17:54:16 -0700 (PDT)
Message-ID: <b7f0b4cb-cf31-4abb-8682-5d43acaafbbf@googlegroups.com>
References: <1b3d3eb1-ed6c-4d03-8fdb-bf2ba2163647@googlegroups.com>
 <CABPQNSYj1-aaQieztkLxZjOhBQMqBJy+9POcmMcjGO4-a=EM9Q@mail.gmail.com> <CABPQNSZqNyKvFKoG6E0+JDaaNnUbWCaFH-WfKE1MicwDH-3TFA@mail.gmail.com>
 <CABPQNSb0pWAwwrZ5LvOY2agdEa+MXPMvg+kFa1vODhXf6efAZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1038_33188603.1351731256998"
Cc: GIT Mailing-list <git@vger.kernel.org>, Michael Naumov <mnaoumov@gmail.com>, 
	kusmabite@gmail.com
To: msysgit@googlegroups.com
X-From: msysgit+bncBCG5XCGK4MNBBIOBZCCAKGQEHU7LOZA@googlegroups.com Thu Nov 01 08:11:40 2012
Return-path: <msysgit+bncBCG5XCGK4MNBBIOBZCCAKGQEHU7LOZA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f186.google.com ([209.85.216.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG5XCGK4MNBBIOBZCCAKGQEHU7LOZA@googlegroups.com>)
	id 1TTowF-0007et-Fy
	for gcvm-msysgit@m.gmane.org; Thu, 01 Nov 2012 08:11:39 +0100
Received: by mail-qc0-f186.google.com with SMTP id y9sf1457077qcp.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 01 Nov 2012 00:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:date:from:to:cc:message-id:in-reply-to:references
         :subject:mime-version:x-original-sender:precedence:mailing-list
         :list-id:x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=KHVboham4re5LvWnwnRTLaFyOR2Y8xt0VX41tP/XyS0=;
        b=CiSOOc5BmQwxqx6TfFsSd8YqEHMcAnMpxv5xK+Qdjvl8N6s81WBgigImEhqhd7iMvF
         1SSwT+ZLXq8aIHN1xgyrkNCFby09otQ2tMecNhBYuWYs9hlkZVWHrN4Ln2l4hjpoS+Sv
         oHntlvLkTJpu68KL4kmzIHKrjyIXYDhiTiC+BeifNC9PXun/nAQKWRAFjVsr824A60Mm
         NZyq7L+5j3WKSNwiKiqtkrXe7wzZ7pxWRk5AYiOsA3YFZnlWE38ffmr3ekDNq+zU/EyC
         y1UkiOoPk2vQKCTn/ReFb+HdVMM6MpWWHooeRt7XSCcFg0Zs7isQXOIOgkdx+0pqkMBI
         VtOA==
Received: by 10.50.236.74 with SMTP id us10mr141023igc.3.1351753890318;
        Thu, 01 Nov 2012 00:11:30 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.140.37 with SMTP id rd5ls237770igb.2.gmail; Thu, 01 Nov
 2012 00:11:29 -0700 (PDT)
Received: by 10.42.172.68 with SMTP id m4mr23169969icz.1.1351753889793;
        Thu, 01 Nov 2012 00:11:29 -0700 (PDT)
Received: by 10.50.57.13 with SMTP id e13msigq;
        Wed, 31 Oct 2012 17:54:17 -0700 (PDT)
Received: by 10.68.232.167 with SMTP id tp7mr797331pbc.7.1351731257423;
        Wed, 31 Oct 2012 17:54:17 -0700 (PDT)
In-Reply-To: <CABPQNSb0pWAwwrZ5LvOY2agdEa+MXPMvg+kFa1vODhXf6efAZw@mail.gmail.com>
X-Original-Sender: mnaoumov@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208866>

------=_Part_1038_33188603.1351731256998
Content-Type: text/plain; charset=ISO-8859-1

Your suggestion seems to be logical for me :)

On Thursday, November 1, 2012 3:32:26 AM UTC+11, Erik Faye-Lund wrote:
>
> Sorry for resending, but the previous version got dropped from the 
> main git mailing list due to a HTML-subpart. Converted to plain-text. 
>
> On Wed, Oct 31, 2012 at 4:45 PM, Erik Faye-Lund <kusm...@gmail.com<javascript:>> 
> wrote: 
> > 
> > On Wed, Oct 31, 2012 at 4:24 PM, <mnao...@gmail.com <javascript:>> 
> wrote: 
> >> 
> >> If you add pre-receive hook in your git repository with the following 
> >> content 
> >> 
> >> #!/bin/sh 
> >> 
> >> echo Message 
> >> exit 1 
> >> 
> >> And then try to push you will get the following 
> >> 
> >> The bug is about these strange 3 last characters. 
> >> 
> >> Recently I raised a bug for GitExtensions but it seems to be msysgit 
> >> issue as I could reproduce it from PowerShell as well 
> >> 
> >> https://github.com/gitextensions/gitextensions/issues/1313 
>
>
>
> > 
> > What you're seeing is most likely a CR (a carriage return character). 
> > Windows has CRLF new-lines, and Unix uses only LF. 
> > 
> > My guess is that echo produces CRLF, and this gets carried through and 
> > incorrecly displayed. 
>
>
> OK, I can reproduce it in Git Bash now, and by doing "git push 2>&1 | od 
> -c" 
> I can see that I'm getting "Message\033[K\n". 
>
> This looks a little bit puzzling, but the sequence matches ANSI_SUFFIX in 
> sideband.c. So it seems this is intentional. This dates back to ebe8fa73. 
>
> I wonder, shouldn't we check isatty also before assuming ANSI-sequences? 
>
> ---8<--- 
> diff --git a/sideband.c b/sideband.c 
> index d5ffa1c..bd3e5a8 100644 
> --- a/sideband.c 
> +++ b/sideband.c 
> @@ -29,7 +29,7 @@ int recv_sideband(const char *me, int in_stream, int 
> out) 
>
>   memcpy(buf, PREFIX, pf); 
>   term = getenv("TERM"); 
> - if (term && strcmp(term, "dumb")) 
> + if (isatty(out) && term && strcmp(term, "dumb")) 
>   suffix = ANSI_SUFFIX; 
>   else 
>   suffix = DUMB_SUFFIX; 
> ---8<--- 
>
> Thoughts? 
>

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

------=_Part_1038_33188603.1351731256998
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Your suggestion seems to be logical for me :)<br><br>On Thursday, November =
1, 2012 3:32:26 AM UTC+11, Erik Faye-Lund wrote:<blockquote class=3D"gmail_=
quote" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;pa=
dding-left: 1ex;">Sorry for resending, but the previous version got dropped=
 from the
<br>main git mailing list due to a HTML-subpart. Converted to plain-text.
<br>
<br>On Wed, Oct 31, 2012 at 4:45 PM, Erik Faye-Lund &lt;<a href=3D"javascri=
pt:" target=3D"_blank" gdf-obfuscated-mailto=3D"BO3s6ww-pS0J">kusm...@gmail=
.com</a>&gt; wrote:
<br>&gt;
<br>&gt; On Wed, Oct 31, 2012 at 4:24 PM, &lt;<a href=3D"javascript:" targe=
t=3D"_blank" gdf-obfuscated-mailto=3D"BO3s6ww-pS0J">mnao...@gmail.com</a>&g=
t; wrote:
<br>&gt;&gt;
<br>&gt;&gt; If you add pre-receive hook in your git repository with the fo=
llowing
<br>&gt;&gt; content
<br>&gt;&gt;
<br>&gt;&gt; #!/bin/sh
<br>&gt;&gt;
<br>&gt;&gt; echo Message
<br>&gt;&gt; exit 1
<br>&gt;&gt;
<br>&gt;&gt; And then try to push you will get the following
<br>&gt;&gt;
<br>&gt;&gt; The bug is about these strange 3 last characters.
<br>&gt;&gt;
<br>&gt;&gt; Recently I raised a bug for GitExtensions but it seems to be m=
sysgit
<br>&gt;&gt; issue as I could reproduce it from PowerShell as well
<br>&gt;&gt;
<br>&gt;&gt; <a href=3D"https://github.com/gitextensions/gitextensions/issu=
es/1313" target=3D"_blank">https://github.com/<wbr>gitextensions/gitextensi=
ons/<wbr>issues/1313</a>
<br>
<br>
<br>
<br>&gt;
<br>&gt; What you're seeing is most likely a CR (a carriage return characte=
r).
<br>&gt; Windows has CRLF new-lines, and Unix uses only LF.
<br>&gt;
<br>&gt; My guess is that echo produces CRLF, and this gets carried through=
 and
<br>&gt; incorrecly displayed.
<br>
<br>
<br>OK, I can reproduce it in Git Bash now, and by doing "git push 2&gt;&am=
p;1 | od -c"
<br>I can see that I'm getting "Message\033[K\n".
<br>
<br>This looks a little bit puzzling, but the sequence matches ANSI_SUFFIX =
in
<br>sideband.c. So it seems this is intentional. This dates back to ebe8fa7=
3.
<br>
<br>I wonder, shouldn't we check isatty also before assuming ANSI-sequences=
?
<br>
<br>---8&lt;---
<br>diff --git a/sideband.c b/sideband.c
<br>index d5ffa1c..bd3e5a8 100644
<br>--- a/sideband.c
<br>+++ b/sideband.c
<br>@@ -29,7 +29,7 @@ int recv_sideband(const char *me, int in_stream, int =
out)
<br>
<br>&nbsp; memcpy(buf, PREFIX, pf);
<br>&nbsp; term =3D getenv("TERM");
<br>- if (term &amp;&amp; strcmp(term, "dumb"))
<br>+ if (isatty(out) &amp;&amp; term &amp;&amp; strcmp(term, "dumb"))
<br>&nbsp; suffix =3D ANSI_SUFFIX;
<br>&nbsp; else
<br>&nbsp; suffix =3D DUMB_SUFFIX;
<br>---8&lt;---
<br>
<br>Thoughts?
<br></blockquote>

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

------=_Part_1038_33188603.1351731256998--
