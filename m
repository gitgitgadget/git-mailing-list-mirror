From: Wataru Noguchi <wnoguchi.0727@gmail.com>
Subject: Re: Re: [PATCH] git-compat-util.h: reduce optimization
 level to 1 on MinGW env.
Date: Thu, 26 Sep 2013 08:42:29 +0900
Message-ID: <CAFRcQ0FohRz+eKsq=c8S2JGHb-_2sZaApNJwY6-ey2_jF3qmJg@mail.gmail.com>
References: <1380123941-25941-1-git-send-email-wnoguchi.0727@gmail.com>
	<20130925191527.GY9464@google.com>
	<alpine.DEB.1.00.1309252142220.1191@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=047d7b624d446f341404e73dce3e
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jonathan Nieder <jrnieder@gmail.com>
X-From: msysgit+bncBDD7TRGTWYIBBZPJRWJAKGQESMA6MNI@googlegroups.com Thu Sep 26 01:42:31 2013
Return-path: <msysgit+bncBDD7TRGTWYIBBZPJRWJAKGQESMA6MNI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-bk0-f56.google.com ([209.85.214.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDD7TRGTWYIBBZPJRWJAKGQESMA6MNI@googlegroups.com>)
	id 1VOyj0-00086a-DX
	for gcvm-msysgit@m.gmane.org; Thu, 26 Sep 2013 01:42:30 +0200
Received: by mail-bk0-f56.google.com with SMTP id d7sf38260bkh.11
        for <gcvm-msysgit@m.gmane.org>; Wed, 25 Sep 2013 16:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=D4CtqNwQKEn7dw6GrxqTWWIhYlQKWMGNIndfra7nmJc=;
        b=cPUGOSdGvQ0AVdlKyg//cd8uCOny5IRbR518Yqp2N0ABKyjcVTlVtibY6RMSHWUEsA
         SfjgzSQRiOPSBbMJ1fs5HpjIno/oF+a5ahmWHQjhpjt+Xi1UAUnEFrDPOolSlayT6w13
         4Ixif1mgEtr5iRtQCd86Ht+IEHanuirMRAruyttIaU+pnkoRXDr4KOv7Fbp+4mUa9v8i
         OaM8KXXxcxBJAvQv5a3ok2UCPhGKRcfsJKwiCskgJdQRnGIv0biHaTh6nd3k7YXxj5A7
         fh/zZuF8vxzAScdC1SUZ5KyBafc9N4nmS9SXH7kWB4GbmsQR3r57boKHm8txOk9fG4aN
         +YIg==
X-Received: by 10.180.187.7 with SMTP id fo7mr929780wic.0.1380152550097;
        Wed, 25 Sep 2013 16:42:30 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.75.176 with SMTP id d16ls482876wiw.17.gmail; Wed, 25 Sep
 2013 16:42:29 -0700 (PDT)
X-Received: by 10.180.11.5 with SMTP id m5mr10989406wib.2.1380152549372;
        Wed, 25 Sep 2013 16:42:29 -0700 (PDT)
Received: from mail-we0-x233.google.com (mail-we0-x233.google.com [2a00:1450:400c:c03::233])
        by gmr-mx.google.com with ESMTPS id nb7si462334wic.3.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 16:42:29 -0700 (PDT)
Received-SPF: pass (google.com: domain of wnoguchi.0727@gmail.com designates 2a00:1450:400c:c03::233 as permitted sender) client-ip=2a00:1450:400c:c03::233;
Received: by mail-we0-f179.google.com with SMTP id x55so370572wes.24
        for <msysgit@googlegroups.com>; Wed, 25 Sep 2013 16:42:29 -0700 (PDT)
X-Received: by 10.180.160.178 with SMTP id xl18mr25231462wib.61.1380152549256;
 Wed, 25 Sep 2013 16:42:29 -0700 (PDT)
Received: by 10.216.68.72 with HTTP; Wed, 25 Sep 2013 16:42:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1309252142220.1191@s15462909.onlinehome-server.info>
X-Original-Sender: wnoguchi.0727@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of wnoguchi.0727@gmail.com designates 2a00:1450:400c:c03::233
 as permitted sender) smtp.mail=wnoguchi.0727@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235382>

--047d7b624d446f341404e73dce3e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for your reply.

> If changing the optimization level turns out to be the right fix, I
> would prefer to see this change made in the Makefile instead of
> git-compat-util.h.

Yes, I see.
I think so.
I shuld write optimization level change code to Makefile instead of
git-compat-util.h.


2013/9/26 Jonathan Nieder <jrnieder@gmail.com>

> (cc-ing the Git for Windows maintainers)
> Hi,
>
> Wataru Noguchi wrote:
>
> > Git for Windows crashes when clone Japanese multibyte repository.
> > - Japanese Base Encoding is Shift-JIS.
> > - It happens Japanese multibyte directory name and too-long directory
> path
> > - Linux(ex. Ubuntu 13.04 amd64) can clone normally.
> > - example repository is here:
> >
> > git clone https://github.com/wnoguchi/mingw-checkout-crash.git
> >
> > - The reproduce crash repository contains following file only.
> >   - following directory and file name is encoded for this commit log.
> >   - actually file name is decoded.]
> >
> %E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%=
E3%83%AA%201-long-long-long-dirname/%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3=
%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%202-long-long-long-dirname/%E6%9=
7%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%A=
A%203-long-long-long-dirname/%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%=
E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%204-long-long-long-dirname/%E6%97%A5%E6=
%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%205-l=
ong-long-long-dirname/%E3%81%AF%E3%81%98%E3%82%81%E3%81%AB%E3%81%8A%E8%AA%A=
D%E3%81%BF%E3%81%8F%E3%81%A0%E3%81%95%E3%81%84.txt
> > - only one commit.
> >
> > This commit reduce gcc optimization level from O2 to O1 when MinGW
> Windows environment.
> >
> > Signed-off-by: Wataru Noguchi <wnoguchi.0727@gmail.com>
>
> Thanks.
>
> > ---
> >  git-compat-util.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index a31127f..394c23b 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -90,6 +90,8 @@
> >  #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
> >  #include <winsock2.h>
> >  #include <windows.h>
> > +/* reduce gcc optimization level to 1 */
> > +#pragma GCC optimize ("O1")
> >  #define GIT_WINDOWS_NATIVE
> >  #endif
>
> Do you know why reducing the optimization level avoids a crash?
> Perhaps this is just masking the symptoms and the problem is still
> lurking.
>
> If changing the optimization level turns out to be the right fix, I
> would prefer to see this change made in the Makefile instead of
> git-compat-util.h.  That way, the user building can still easily
> override the optimization settings to -O0 if they want to during a
> debugging session.
>
> What do you think?
>
> Hope that helps,
> Jonathan
>

Hi,

Thanks for your advise.

> To find out what the real cause is, I suggest using a tool similar to
> valgrind. Valgrind does not run on Windows, but I DuckDuckWent e.g.
> http://code.google.com/p/drmemory/ as an alternative that could be tried
> to identify the problem.

I will try debugging by using any tools more real cause.
* Valgrind and drmemory, etc.

2013/9/26 Johannes Schindelin <Johannes.Schindelin@gmx.de>

> Hi,
>
> On Wed, 25 Sep 2013, Jonathan Nieder wrote:
>
> > Wataru Noguchi wrote:
> >
> > >   - actually file name is decoded.]
> > >
> %E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%=
E3%83%AA%201-long-long-long-dirname/%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3=
%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%202-long-long-long-dirname/%E6%9=
7%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%A=
A%203-long-long-long-dirname/%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%=
E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%204-long-long-long-dirname/%E6%97%A5%E6=
%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%205-l=
ong-long-long-dirname/%E3%81%AF%E3%81%98%E3%82%81%E3%81%AB%E3%81%8A%E8%AA%A=
D%E3%81%BF%E3%81%8F%E3%81%A0%E3%81%95%E3%81%84.txt
> > >
> > > This commit reduce gcc optimization level from O2 to O1 when MinGW
> > > Windows environment.
> >
> > Do you know why reducing the optimization level avoids a crash?
>
> I suspect that the optimization level causes smaller (or no) buffer bytes
> between data structures and the crash is the symptom of a buffer overflow=
.
> In that light, I think that reducing the optimization level is most likel=
y
> just working around this particular issue, and other scenarios might stil=
l
> crash until we fix the underlying bug.
>
> Most likely the problem is with our Windows-specific UTF-8 handling, I
> would not be surprised if it is my "favorite" bug: an off-by-one.
>
> To find out what the real cause is, I suggest using a tool similar to
> valgrind. Valgrind does not run on Windows, but I DuckDuckWent e.g.
> http://code.google.com/p/drmemory/ as an alternative that could be tried
> to identify the problem.
>
> Ciao,
> Johannes
>


Thanks!

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
  Wataru Noguchi
  wnoguchi.0727@gmail.com
  http://wnoguchi.github.io/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.

--047d7b624d446f341404e73dce3e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div>Thanks for your reply.<br><br=
>&gt; If changing the optimization level turns out to be the right fix, I<b=
r>&gt; would prefer to see this change made in the Makefile instead of<br>
&gt; git-compat-util.h.<br><br>Yes, I see.<div>I think so.</div><div>I shul=
d write optimization level change code to Makefile instead of git-compat-ut=
il.h.<div><br></div><div><br><div class=3D"gmail_quote">2013/9/26 Jonathan =
Nieder=A0<span dir=3D"ltr">&lt;<a href=3D"mailto:jrnieder@gmail.com" target=
=3D"_blank">jrnieder@gmail.com</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
(cc-ing the Git for Windows maintainers)<br>Hi,<br><div><br>Wataru Noguchi =
wrote:<br><br>&gt; Git for Windows crashes when clone Japanese multibyte re=
pository.<br>&gt; - Japanese Base Encoding is Shift-JIS.<br>
&gt; - It happens Japanese multibyte directory name and too-long directory =
path<br>&gt; - Linux(ex. Ubuntu 13.04 amd64) can clone normally.<br>&gt; - =
example repository is here:<br>&gt;<br>&gt; git clone=A0<a href=3D"https://=
github.com/wnoguchi/mingw-checkout-crash.git" target=3D"_blank">https://git=
hub.com/wnoguchi/mingw-checkout-crash.git</a><br>

&gt;<br>&gt; - The reproduce crash repository contains following file only.=
<br>&gt; =A0 - following directory and file name is encoded for this commit=
 log.<br>&gt; =A0 - actually file name is decoded.]<br>&gt; =A0 %E6%97%A5%E=
6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%201-=
long-long-long-dirname/%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%=
AC%E3%82%AF%E3%83%88%E3%83%AA%202-long-long-long-dirname/%E6%97%A5%E6%9C%AC=
%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%203-long-lo=
ng-long-dirname/%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%8=
2%AF%E3%83%88%E3%83%AA%204-long-long-long-dirname/%E6%97%A5%E6%9C%AC%E8%AA%=
9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%205-long-long-long=
-dirname/%E3%81%AF%E3%81%98%E3%82%81%E3%81%AB%E3%81%8A%E8%AA%AD%E3%81%BF%E3=
%81%8F%E3%81%A0%E3%81%95%E3%81%84.txt<br>

&gt; - only one commit.<br>&gt;<br>&gt; This commit reduce gcc optimization=
 level from O2 to O1 when MinGW Windows environment.<br>&gt;<br>&gt; Signed=
-off-by: Wataru Noguchi &lt;<a href=3D"mailto:wnoguchi.0727@gmail.com" targ=
et=3D"_blank">wnoguchi.0727@gmail.com</a>&gt;<br>

<br></div>Thanks.<br><div><br>&gt; ---<br>&gt; =A0git-compat-util.h | 2 ++<=
br>&gt; =A01 file changed, 2 insertions(+)<br>&gt;<br>&gt; diff --git a/git=
-compat-util.h b/git-compat-util.h<br>&gt; index a31127f..394c23b 100644<br=
>

&gt; --- a/git-compat-util.h<br>&gt; +++ b/git-compat-util.h<br>&gt; @@ -90=
,6 +90,8 @@<br>&gt; =A0#define WIN32_LEAN_AND_MEAN =A0/* stops windows.h in=
cluding winsock.h */<br>&gt; =A0#include &lt;winsock2.h&gt;<br>&gt; =A0#inc=
lude &lt;windows.h&gt;<br>

&gt; +/* reduce gcc optimization level to 1 */<br>&gt; +#pragma GCC optimiz=
e (&quot;O1&quot;)<br>&gt; =A0#define GIT_WINDOWS_NATIVE<br>&gt; =A0#endif<=
br><br></div>Do you know why reducing the optimization level avoids a crash=
?<br>

Perhaps this is just masking the symptoms and the problem is still<br>lurki=
ng.<br><br>If changing the optimization level turns out to be the right fix=
, I<br>would prefer to see this change made in the Makefile instead of<br>

git-compat-util.h. =A0That way, the user building can still easily<br>overr=
ide the optimization settings to -O0 if they want to during a<br>debugging =
session.<br><br>What do you think?<br><br>Hope that helps,<br>Jonathan<br>

</blockquote></div><div><br></div><div>Hi,</div><div><br></div>Thanks for y=
our advise.</div><div><div class=3D"gmail_extra"><br></div><div class=3D"gm=
ail_extra">&gt; To find out what the real cause is, I suggest using a tool =
similar to<br>
&gt; valgrind. Valgrind does not run on Windows, but I DuckDuckWent e.g.<br=
>&gt;=A0<a href=3D"http://code.google.com/p/drmemory/" target=3D"_blank">ht=
tp://code.google.com/p/drmemory/</a>=A0as an alternative that could be trie=
d<br>
&gt; to identify the problem.<br><br>I will try debugging by using any tool=
s more real cause.</div><div class=3D"gmail_extra">* Valgrind and drmemory,=
 etc.<br><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">20=
13/9/26 Johannes Schindelin <span dir=3D"ltr">&lt;<a href=3D"mailto:Johanne=
s.Schindelin@gmx.de" target=3D"_blank">Johannes.Schindelin@gmx.de</a>&gt;</=
span><br>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">Hi,<br>
<br>
On Wed, 25 Sep 2013, Jonathan Nieder wrote:<br>
<div><br>
&gt; Wataru Noguchi wrote:<br>
&gt;<br>
&gt; &gt; =A0 - actually file name is decoded.]<br>
&gt; &gt; =A0 %E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%=
AF%E3%83%88%E3%83%AA%201-long-long-long-dirname/%E6%97%A5%E6%9C%AC%E8%AA%9E=
%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%202-long-long-long-d=
irname/%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%8=
3%88%E3%83%AA%203-long-long-long-dirname/%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%=
87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%204-long-long-long-dirname/=
%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3=
%83%AA%205-long-long-long-dirname/%E3%81%AF%E3%81%98%E3%82%81%E3%81%AB%E3%8=
1%8A%E8%AA%AD%E3%81%BF%E3%81%8F%E3%81%A0%E3%81%95%E3%81%84.txt<br>


&gt; &gt;<br>
</div><div>&gt; &gt; This commit reduce gcc optimization level from O2 to O=
1 when MinGW<br>
&gt; &gt; Windows environment.<br>
&gt;<br>
</div><div>&gt; Do you know why reducing the optimization level avoids a cr=
ash?<br>
<br>
</div>I suspect that the optimization level causes smaller (or no) buffer b=
ytes<br>
between data structures and the crash is the symptom of a buffer overflow.<=
br>
In that light, I think that reducing the optimization level is most likely<=
br>
just working around this particular issue, and other scenarios might still<=
br>
crash until we fix the underlying bug.<br>
<br>
Most likely the problem is with our Windows-specific UTF-8 handling, I<br>
would not be surprised if it is my &quot;favorite&quot; bug: an off-by-one.=
<br>
<br>
To find out what the real cause is, I suggest using a tool similar to<br>
valgrind. Valgrind does not run on Windows, but I DuckDuckWent e.g.<br>
<a href=3D"http://code.google.com/p/drmemory/" target=3D"_blank">http://cod=
e.google.com/p/drmemory/</a> as an alternative that could be tried<br>
to identify the problem.<br>
<br>
Ciao,<br>
Johannes<br>
</blockquote></div><br><br>Thanks!<br clear=3D"all"><div><br></div>-- <br><=
div dir=3D"ltr"><div><div style=3D"font-family:arial,sans-serif;font-size:1=
4px"><div style=3D"font-family:arial;font-size:small">=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>
<div style=3D"font-family:arial;font-size:small">=A0 Wataru Noguchi</div><d=
iv style=3D"font-family:arial;font-size:small">=A0=A0<a href=3D"mailto:wnog=
uchi.0727@gmail.com" target=3D"_blank">wnoguchi.0727@gmail.com</a><br></div=
><div style=3D"font-family:arial;font-size:small">
=A0 <a href=3D"http://wnoguchi.github.io/">http://wnoguchi.github.io/</a></=
div><div style=3D"font-family:arial;font-size:small">=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br></div><div>=
<br></div></div></div></div>
</div></div></div></div>

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

--047d7b624d446f341404e73dce3e--
