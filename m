From: MNGoldenEagle <mngoldeneagle@gmail.com>
Subject: Re: Re: git clone doesn't work in symlink dir roots on Windows
Date: Sun, 8 Sep 2013 18:40:09 -0500
Message-ID: <CALEirj_GoMLuLDSyPgP0=JX9twm5+Q=QE5xiDxn5zNvXLCuNpg@mail.gmail.com>
References: <CABJxLaM9t1HeEVkAiXpOmaOH_V6681w9Q9ZQt37+MpmhX7yN2g@mail.gmail.com>
 <CABJxLaOaUYxyAsy5mpciiAObmoazFpwB0T4C20cu3eHuSpEpAg@mail.gmail.com>
 <20130810163459.GE25779@paksenarrion.iveqy.com> <1928115.O1fVFY9Fid@majorie>
 <CALEirj-7GKvU2y0_9A+447YA_18JLZROfvMtBiDX3k=3DATmZA@mail.gmail.com> <3d08cf46e3e08d948adeebacf491ef1b@wheelycreek.net>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=089e0160c89802917004e5e7cc0c
Cc: msysgit@googlegroups.com, Fredrik Gustafsson <iveqy@iveqy.com>, 
	Sedat Kapanoglu <sedat@eksiteknoloji.com>, git@vger.kernel.org
To: Michael <michael@frog.wheelycreek.net>
X-From: msysgit+bncBDHI5E5R2QPBB3UVWSIQKGQEBCAEWLA@googlegroups.com Mon Sep 09 01:40:31 2013
Return-path: <msysgit+bncBDHI5E5R2QPBB3UVWSIQKGQEBCAEWLA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qe0-f59.google.com ([209.85.128.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDHI5E5R2QPBB3UVWSIQKGQEBCAEWLA@googlegroups.com>)
	id 1VIoal-0008FX-Ll
	for gcvm-msysgit@m.gmane.org; Mon, 09 Sep 2013 01:40:31 +0200
Received: by mail-qe0-f59.google.com with SMTP id i11sf1309727qej.4
        for <gcvm-msysgit@m.gmane.org>; Sun, 08 Sep 2013 16:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=JJSg6KnWpIJ5Rktf0wSYAmnZK2Yulvnv7hntVGQ2XDY=;
        b=DaDtrN6FywlEHaVZvYrscCQ0Lp+0qyrBYzKfyGmwN3H9pYF/IK8XbBxHw18wl4X/Mq
         X78vjZjeKQFOW141Hb/8LN0YwliBuXT/0kd4MUCMt/XgUEgri0ndVsHXW8UmD7lvn8yf
         bVSSV8YKfnCQEEpAEv7BT51cEGbuRiw2OwAwlmCMjeaOXoKeZ33g6ne5cZlfaCViqIl9
         x8GVvmA1Q6W9XqRtBg1DtLBbXXE/c9jtw1rgUw+5Ix1yFBtMfSjV6XdYi01S+gaxGzSI
         kQ8i8NKktde7WYV0To7FLGfBtv3aUk6ey6Y4om/ItBBKzPZsoqh5h9dg+C3R8eIsmLEQ
         48VQ==
X-Received: by 10.50.80.78 with SMTP id p14mr253659igx.6.1378683630901;
        Sun, 08 Sep 2013 16:40:30 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.112.71 with SMTP id io7ls1507222igb.18.gmail; Sun, 08 Sep
 2013 16:40:30 -0700 (PDT)
X-Received: by 10.42.137.1 with SMTP id w1mr7488358ict.8.1378683630095;
        Sun, 08 Sep 2013 16:40:30 -0700 (PDT)
Received: from mail-ob0-x22e.google.com (mail-ob0-x22e.google.com [2607:f8b0:4003:c01::22e])
        by gmr-mx.google.com with ESMTPS id l7si964365igd.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 16:40:30 -0700 (PDT)
Received-SPF: pass (google.com: domain of mngoldeneagle@gmail.com designates 2607:f8b0:4003:c01::22e as permitted sender) client-ip=2607:f8b0:4003:c01::22e;
Received: by mail-ob0-f174.google.com with SMTP id wd6so5374412obb.33
        for <msysgit@googlegroups.com>; Sun, 08 Sep 2013 16:40:29 -0700 (PDT)
X-Received: by 10.182.48.194 with SMTP id o2mr9430185obn.90.1378683629767;
 Sun, 08 Sep 2013 16:40:29 -0700 (PDT)
Received: by 10.76.34.66 with HTTP; Sun, 8 Sep 2013 16:40:09 -0700 (PDT)
In-Reply-To: <3d08cf46e3e08d948adeebacf491ef1b@wheelycreek.net>
X-Original-Sender: mngoldeneagle@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of mngoldeneagle@gmail.com designates 2607:f8b0:4003:c01::22e
 as permitted sender) smtp.mail=mngoldeneagle@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234284>

--089e0160c89802917004e5e7cc0c
Content-Type: text/plain; charset=ISO-8859-1

Michael,

Well, I know that you need administrative permission to create symbolic
links on Windows (specified in the Local Security Policy under "Create
symbolic links"), so if you're not running as an administrator, that's
probably the issue.  The only way around it is to modify the security
policy or have Git request admin privileges if it needs to use symlinks.

Jesse


On Tue, Aug 27, 2013 at 7:54 PM, Michael <michael@frog.wheelycreek.net>wrote:

> **
>
> I really don't know Jesse,
>
> The permissions issue keeps coming up, but to me it seems a non-issue as
> there is a CLI command to issue the appropriate permissions to a user.  The
> directory link being separate is a painful but known issue, and my solution
> should work in most every-day ways, as long as the symlinks aren't dangling
> within the repository tree itself.
>
> We could possibly limit the types of NTFS symbolic links that would
> actually be embedded in a git database to relative links (or is that done
> already?).  I'm quite happy to have 'That type of NTFS symbolic link is not
> supported' as a valid solution to anything that is outside of simple
> symbolic links.
>
> Currently the biggest thing holding symlinks back from being complete is
> lack of support in MSYS itself - which might be solved by using MSYS2.   I
> have worked around this in the tests by overriding various commands with
> shell functions that implement operations on symlinks via cmd.exe.  The
> only current exception to this is tar, which I can't do much about.
>
> I've just rebased my symlink branch onto pt/tentative-1.8.4 and am chasing
> down test failures.
>
> The tests like to make the symlinks before creating directories, or to
> create dangling symlinks, which doesn't help my cause - but am working
> through it.
>
> //.
>
> On 23.08.2013 12:12, MNGoldenEagle wrote:
>
>  Aside from having to specify whether or not the symbolic link points to
> a file or directory, what are the limitations of symlinks?  I'm a bit
> curious, having used them myself but never encountering any significant
> issues with them.  I remember hearing at one point that Windows Vista could
> only create up to 31 links inside a directory, but I just checked on my
> Windows 7 machine and was able to generate over 600 links to a directory
> without a problem, so I'm guessing Windows 7 worked around this issue.
>
> Jesse
>
>
> On Tue, Aug 20, 2013 at 2:30 AM, Michael Geddes <
> michael@frog.wheelycreek.net> wrote:
>
>> This type of functionality is directly supported by the work I've already
>> done
>> on symlinks here:   https://github.com/frogonwheels/git
>> (branches mrg/symlink-v*  )
>>
>> Even if we agree that symlinks only work to a limited degree, or that
>> there
>> are definite limitations, and that the default should be that symlinks
>> NOT be
>> supported within repositories, I'm not sure why people are against
>> incorporating what I've already implemented.. ok well I guess I do - it's
>> about time.
>>
>> Firstly, at the least it means that symlinks like this example where they
>> are
>> outside the repository are supported.  Secondly it means that people who
>> are
>> prepared to accept the limitations will be able to use (or at least clone)
>> repositories containing symlinks.
>>
>> One of the big, painful limitations is that windoze symlinks need to be
>> marked
>> as directories at the time of creation.  The code I have implemented does
>> it's
>> level best to create the correct type of NTFS symlink based on repository
>> information and falling back on filesystem information.
>>
>> The argument about permissions is only partially valid, since that can be
>> granted as an individual permission to the user without permanent
>> administrator rights.
>>
>> //.ichael G.
>>
>> On Sat, 10 Aug 2013 06:34:59 PM Fredrik Gustafsson wrote:
>> > On Sat, Aug 10, 2013 at 07:22:03PM +0300, Sedat Kapanoglu wrote:
>> > > > git is a disk intense program, so this setup is not sane at all.
>> With
>> > > > that said I know that git on windows historically had problems with
>> > > > working on smb-mounted shares (sometimes you're forced to have
>> stupid
>> > > > setups). I doubt that git really is the right tool for your work,
>> since
>> > >
>> > > I reproduced the same problem in a regular symlink directory. Repro
>> steps:
>> > >
>> > > mkdir actualdir
>> > > mklink /d symdir actualdir
>> > > cd symdir
>> > > git init .
>> > >
>> > > fatal: Invalid symlink 'D:/gitto': Function not implemented
>> > >
>> > > Thanks,
>> > >
>> > > Sedat
>> >
>> > Good, then we can determinate that this is a symlink error, it seams
>> > that readlink() isn't implemented in the msysgit version of msysgit.
>> >
>> > However msysgit should have a implementation of readlink() according to:
>> > http://mingw.5.n7.nabble.com/Replacement-for-readlink-td30679.html
>> >
>> > I've CC:ed the msysgit-maillist so that they can decide if this is
>> > something they want to address in newer releases.
>> >
>> > (In the git source code the readlink call in this abspath.c)
>>
>> --
>>  --
>> *** Please reply-to-all at all times ***
>> *** (do not pretend to know who is subscribed and who is not) ***
>> *** Please avoid top-posting. ***
>> The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki -
>> Github accounts are free.
>>
>> You received this message because you are subscribed to the Google
>> Groups "msysGit" group.
>> To post to this group, send email to msysgit@googlegroups.com
>> To unsubscribe from this group, send email to
>> msysgit+unsubscribe@googlegroups.com
>> For more options, and view previous threads, visit this group at
>> http://groups.google.com/group/msysgit?hl=en_US?hl=en
>>
>> ---
>> You received this message because you are subscribed to the Google Groups
>> "msysGit" group.
>> To unsubscribe from this group and stop receiving emails from it, send an
>> email to msysgit+unsubscribe@googlegroups.com.
>> For more options, visit https://groups.google.com/groups/opt_out.
>>
>
>
>

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

--089e0160c89802917004e5e7cc0c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Michael,<br><br></div>Well, I know that you need=
 administrative permission to create symbolic links on Windows (specified i=
n the Local Security Policy under &quot;Create symbolic links&quot;), so if=
 you&#39;re not running as an administrator, that&#39;s probably the issue.=
=A0 The only way around it is to modify the security policy or have Git req=
uest admin privileges if it needs to use symlinks.<br>

<br></div>Jesse<br></div><div class=3D"gmail_extra"><br><br><div class=3D"g=
mail_quote">On Tue, Aug 27, 2013 at 7:54 PM, Michael <span dir=3D"ltr">&lt;=
<a href=3D"mailto:michael@frog.wheelycreek.net" target=3D"_blank">michael@f=
rog.wheelycreek.net</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><u></u>
<div>
<p>I really don&#39;t know Jesse,</p>
<p>The permissions issue keeps coming up, but to me it seems a non-issue as=
 there is a CLI command to issue the appropriate permissions to a user. =A0=
The directory link being separate is a painful but known issue, and my solu=
tion should work in most every-day ways, as long as the symlinks aren&#39;t=
 dangling within the repository tree itself.</p>


<p>We could possibly limit the types of NTFS symbolic links that would actu=
ally be embedded in a git database to relative links (or is that done alrea=
dy?). =A0I&#39;m quite happy to have &#39;That type of NTFS symbolic link i=
s not supported&#39; as a valid solution to anything that is outside of sim=
ple symbolic links.</p>


<p>Currently the biggest thing holding symlinks back from being complete is=
 lack of support in MSYS itself - which might be solved by using MSYS2. =A0=
 I have worked around this in the tests by overriding various commands with=
 shell functions that implement operations on symlinks via cmd.exe. =A0The =
only current exception to this is tar, which I can&#39;t do much about.</p>


<p>I&#39;ve just rebased my symlink branch onto pt/tentative-1.8.4 and am c=
hasing down test failures.</p>
<p>The tests like to make the symlinks before creating directories, or to c=
reate dangling symlinks, which doesn&#39;t help my cause - but am working t=
hrough it.</p>
<p>//.</p><div><div class=3D"h5">
<p>On 23.08.2013 12:12, MNGoldenEagle wrote:</p>
<blockquote type=3D"cite" style=3D"padding-left:5px;border-left:#1010ff 2px=
 solid;margin-left:5px;width:100%">
<div dir=3D"ltr">
<div>Aside from having to specify whether or not the symbolic link points t=
o a file or directory, what are the limitations of symlinks?=A0 I&#39;m a b=
it curious, having used them myself but never encountering any significant =
issues with them.=A0 I remember hearing at one point that Windows Vista cou=
ld only create up to 31 links inside a directory, but I just checked on my =
Windows 7 machine and was able to generate over 600 links to a directory wi=
thout a problem, so I&#39;m guessing Windows 7 worked around this issue.<br=
>

<br></div>
Jesse</div>
<div class=3D"gmail_extra"><br><br>
<div class=3D"gmail_quote">On Tue, Aug 20, 2013 at 2:30 AM, Michael Geddes =
<span>&lt;<a href=3D"mailto:michael@frog.wheelycreek.net" target=3D"_blank"=
>michael@frog.wheelycreek.net</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">This type of functionality is directly suppo=
rted by the work I&#39;ve already done<br> on symlinks here: =A0 <a href=3D=
"https://github.com/frogonwheels/git" target=3D"_blank">https://github.com/=
frogonwheels/git</a><br>

 (branches mrg/symlink-v* =A0)<br><br> Even if we agree that symlinks only =
work to a limited degree, or that there<br> are definite limitations, and t=
hat the default should be that symlinks NOT be<br> supported within reposit=
ories, I&#39;m not sure why people are against<br>

 incorporating what I&#39;ve already implemented.. ok well I guess I do - i=
t&#39;s<br> about time.<br><br> Firstly, at the least it means that symlink=
s like this example where they are<br> outside the repository are supported=
. =A0Secondly it means that people who are<br>

 prepared to accept the limitations will be able to use (or at least clone)=
<br> repositories containing symlinks.<br><br> One of the big, painful limi=
tations is that windoze symlinks need to be marked<br> as directories at th=
e time of creation. =A0The code I have implemented does it&#39;s<br>

 level best to create the correct type of NTFS symlink based on repository<=
br> information and falling back on filesystem information.<br><br> The arg=
ument about permissions is only partially valid, since that can be<br>
 granted as an individual permission to the user without permanent<br>
 administrator rights.<br><br> //.ichael G.<br>
<div><br> On Sat, 10 Aug 2013 06:34:59 PM Fredrik Gustafsson wrote:<br> &gt=
; On Sat, Aug 10, 2013 at 07:22:03PM +0300, Sedat Kapanoglu wrote:<br> &gt;=
 &gt; &gt; git is a disk intense program, so this setup is not sane at all.=
 With<br>

 &gt; &gt; &gt; that said I know that git on windows historically had probl=
ems with<br> &gt; &gt; &gt; working on smb-mounted shares (sometimes you&#3=
9;re forced to have stupid<br> &gt; &gt; &gt; setups). I doubt that git rea=
lly is the right tool for your work, since<br>

 &gt; &gt;<br> &gt; &gt; I reproduced the same problem in a regular symlink=
 directory. Repro steps:<br> &gt; &gt;<br> &gt; &gt; mkdir actualdir<br> &g=
t; &gt; mklink /d symdir actualdir<br> &gt; &gt; cd symdir<br> &gt; &gt; gi=
t init .<br>

 &gt; &gt;<br> &gt; &gt; fatal: Invalid symlink &#39;D:/gitto&#39;: Functio=
n not implemented<br> &gt; &gt;<br> &gt; &gt; Thanks,<br> &gt; &gt;<br> &gt=
; &gt; Sedat<br> &gt;<br> &gt; Good, then we can determinate that this is a=
 symlink error, it seams<br>

 &gt; that readlink() isn&#39;t implemented in the msysgit version of msysg=
it.<br> &gt;<br> &gt; However msysgit should have a implementation of readl=
ink() according to:<br> &gt; <a href=3D"http://mingw.5.n7.nabble.com/Replac=
ement-for-readlink-td30679.html" target=3D"_blank">http://mingw.5.n7.nabble=
.com/Replacement-for-readlink-td30679.html</a><br>

 &gt;<br> &gt; I&#39;ve CC:ed the msysgit-maillist so that they can decide =
if this is<br> &gt; something they want to address in newer releases.<br> &=
gt;<br> &gt; (In the git source code the readlink call in this abspath.c)<b=
r>

<br> --</div>
<div>
<div>--<br> *** Please reply-to-all at all times ***<br> *** (do not preten=
d to know who is subscribed and who is not) ***<br> *** Please avoid top-po=
sting. ***<br> The msysGit Wiki is here: <a href=3D"https://github.com/msys=
git/msysgit/wiki" target=3D"_blank">https://github.com/msysgit/msysgit/wiki=
</a> - Github accounts are free.<br>

<br> You received this message because you are subscribed to the Google<br>=
 Groups &quot;msysGit&quot; group.<br> To post to this group, send email to=
 <a href=3D"mailto:msysgit@googlegroups.com" target=3D"_blank">msysgit@goog=
legroups.com</a><br>

 To unsubscribe from this group, send email to<br><a href=3D"mailto:msysgit=
%2Bunsubscribe@googlegroups.com" target=3D"_blank">msysgit+unsubscribe@goog=
legroups.com</a><br> For more options, and view previous threads, visit thi=
s group at<br>

<a href=3D"http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den" targe=
t=3D"_blank">http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den</a><=
br><br> ---<br> You received this message because you are subscribed to the=
 Google Groups &quot;msysGit&quot; group.<br>

 To unsubscribe from this group and stop receiving emails from it, send an =
email to <a href=3D"mailto:msysgit%2Bunsubscribe@googlegroups.com" target=
=3D"_blank">msysgit+unsubscribe@googlegroups.com</a>.<br> For more options,=
 visit <a href=3D"https://groups.google.com/groups/opt_out" target=3D"_blan=
k">https://groups.google.com/groups/opt_out</a>.</div>


</div>
</blockquote>
</div>
</div>
</blockquote>
<p>=A0</p>
<div>=A0</div>
</div></div></div>
</blockquote></div><br></div>

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

--089e0160c89802917004e5e7cc0c--
