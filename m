From: Pat Thoyts <patthoyts@gmail.com>
Subject: Re: [PATCH] gitk: fix the display of files when filtered by path
Date: Thu, 15 Dec 2011 21:18:19 +0000
Message-ID: <CABNJ2GJaCW5QtLWB+SJosGyFF3MBVvG4B_u+z0V0Ug2723S_kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=bcaec50162d50c967404b4280614
Cc: msysGit <msysgit@googlegroups.com>, Pat Thoyts <patthoyts@users.sourceforge.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Git <git@vger.kernel.org>, 
	David Aguilar <davvid@gmail.com>, Junio C Hamano <gitster@pobox.com>, Paul Mackerras <paulus@samba.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: msysgit+bncCOL1rfnnEBCdyKn3BBoEoFpJMw@googlegroups.com Thu Dec 15 22:18:56 2011
Return-path: <msysgit+bncCOL1rfnnEBCdyKn3BBoEoFpJMw@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vx0-f186.google.com ([209.85.220.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOL1rfnnEBCdyKn3BBoEoFpJMw@googlegroups.com>)
	id 1RbIhX-0002BH-QU
	for gcvm-msysgit@m.gmane.org; Thu, 15 Dec 2011 22:18:51 +0100
Received: by mail-vx0-f186.google.com with SMTP id gb30sf968194vcb.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 15 Dec 2011 13:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:date:message-id:subject:from
         :to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=W2uApndx3JAd0likRcoFnZYRRNlvkDXEEh7GiMKyDJY=;
        b=KCoQGPtMffpV0Toj0bKDAnePpqOaUlbAEuobouQVEPbezh20Tm5rFB51NSJAP7E2MH
         a59VJEZUIJlh4yXdBGKWvU5Bv47SSuxJntlzlTuFlAJDrgO81OHIN5o7hurEtNrARtZt
         qgVKPFLt36EbLcSbtONzAUpxxo17hvTNjteRI=
Received: by 10.52.76.169 with SMTP id l9mr774065vdw.17.1323983901233;
        Thu, 15 Dec 2011 13:18:21 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.52.178.105 with SMTP id cx9ls1677744vdc.0.gmail; Thu, 15 Dec
 2011 13:18:20 -0800 (PST)
Received: by 10.52.24.134 with SMTP id u6mr3662855vdf.8.1323983900202;
        Thu, 15 Dec 2011 13:18:20 -0800 (PST)
Received: by 10.52.24.134 with SMTP id u6mr3662853vdf.8.1323983900182;
        Thu, 15 Dec 2011 13:18:20 -0800 (PST)
Received: from mail-vw0-f41.google.com (mail-vw0-f41.google.com [209.85.212.41])
        by gmr-mx.google.com with ESMTPS id ij1si2181001vdb.3.2011.12.15.13.18.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Dec 2011 13:18:20 -0800 (PST)
Received-SPF: pass (google.com: domain of patthoyts@gmail.com designates 209.85.212.41 as permitted sender) client-ip=209.85.212.41;
Received: by vbbfn1 with SMTP id fn1so2025643vbb.28
        for <msysgit@googlegroups.com>; Thu, 15 Dec 2011 13:18:20 -0800 (PST)
Received: by 10.52.93.146 with SMTP id cu18mr4574774vdb.56.1323983900022; Thu,
 15 Dec 2011 13:18:20 -0800 (PST)
Received: by 10.52.181.200 with HTTP; Thu, 15 Dec 2011 13:18:19 -0800 (PST)
Received: by 10.52.181.200 with HTTP; Thu, 15 Dec 2011 13:18:19 -0800 (PST)
X-Original-Sender: patthoyts@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of patthoyts@gmail.com designates 209.85.212.41 as permitted sender)
 smtp.mail=patthoyts@gmail.com; dkim=pass (test mode) header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187235>

--bcaec50162d50c967404b4280614
Content-Type: text/plain; charset=UTF-8

On Dec 15, 2011 8:01 PM, "Martin von Zweigbergk" <
martin.von.zweigbergk@gmail.com> wrote:
>
> Hi,
>
> On Thu, Dec 15, 2011 at 1:24 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Wed, 14 Dec 2011, David Aguilar wrote:
> >
> >> On Tue, Dec 13, 2011 at 8:50 AM, Pat Thoyts
> >> <patthoyts@users.sourceforge.net> wrote:
> >> > Launching 'gitk -- .' or 'gitk -- ..\t' restricts the display to
files
> >> > under the given directory but the file list is left empty. This is
because
> >> > the path_filter function fails to match the filenames which are
relative
> >> > to the working tree to the filter which is filessytem relative.
> >> > This solves the problem by making both names fully qualified
filesystem
> >> > paths before performing the comparison.
>
> How is this related to my patches from April? See
> http://thread.gmane.org/gmane.comp.version-control.git/170853. It's
> clearly not the same problem, but will the patches conflict? Will some
> of mine be unnecessary?
>
> > Thanks for reminding me that I did not yet apply and push. Did so now.
>
> What do you mean by this? Push to where?
> git://git.kernel.org/pub/scm/gitk/gitk.git is still down.

This is about msysgit as I also posted this there.

> Paul and Junio, the patches I sent in April are still not in git.git,
> are they? Can we use another repo until the kernel.org one is up? More
> than eight months to get a patch (or eight) merged is way too long,
> IMO.
>
> Martin

I'm not sure how this might relate to your patches. I've got a version
merged on top of the last version of the gitk report that I have which
includes those and it seems fine. As stated I did this work against
git-core as the gitk repository continues to be unavailable. However as I
have a pretty current snapshot  I have pushed this to github to provide
some visibility of things I know are not present within git-core. See
http://github.com/patthoyts/gitk.git
On Dec 15, 2011 8:01 PM, "Martin von Zweigbergk" <
martin.von.zweigbergk@gmail.com> wrote:

--bcaec50162d50c967404b4280614
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p><br>
On Dec 15, 2011 8:01 PM, &quot;Martin von Zweigbergk&quot; &lt;<a href=3D"m=
ailto:martin.von.zweigbergk@gmail.com">martin.von.zweigbergk@gmail.com</a>&=
gt; wrote:<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; On Thu, Dec 15, 2011 at 1:24 AM, Johannes Schindelin<br>
&gt; &lt;<a href=3D"mailto:Johannes.Schindelin@gmx.de">Johannes.Schindelin@=
gmx.de</a>&gt; wrote:<br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; On Wed, 14 Dec 2011, David Aguilar wrote:<br>
&gt; &gt;<br>
&gt; &gt;&gt; On Tue, Dec 13, 2011 at 8:50 AM, Pat Thoyts<br>
&gt; &gt;&gt; &lt;<a href=3D"mailto:patthoyts@users.sourceforge.net">pattho=
yts@users.sourceforge.net</a>&gt; wrote:<br>
&gt; &gt;&gt; &gt; Launching &#39;gitk -- .&#39; or &#39;gitk -- ..\t&#39; =
restricts the display to files<br>
&gt; &gt;&gt; &gt; under the given directory but the file list is left empt=
y. This is because<br>
&gt; &gt;&gt; &gt; the path_filter function fails to match the filenames wh=
ich are relative<br>
&gt; &gt;&gt; &gt; to the working tree to the filter which is filessytem re=
lative.<br>
&gt; &gt;&gt; &gt; This solves the problem by making both names fully quali=
fied filesystem<br>
&gt; &gt;&gt; &gt; paths before performing the comparison.<br>
&gt;<br>
&gt; How is this related to my patches from April? See<br>
&gt; <a href=3D"http://thread.gmane.org/gmane.comp.version-control.git/1708=
53">http://thread.gmane.org/gmane.comp.version-control.git/170853</a>. It&#=
39;s<br>
&gt; clearly not the same problem, but will the patches conflict? Will some=
<br>
&gt; of mine be unnecessary?<br>
&gt;<br>
&gt; &gt; Thanks for reminding me that I did not yet apply and push. Did so=
 now.<br>
&gt;<br>
&gt; What do you mean by this? Push to where?<br>
&gt; git://<a href=3D"http://git.kernel.org/pub/scm/gitk/gitk.git">git.kern=
el.org/pub/scm/gitk/gitk.git</a> is still down.</p>
<p>This is about msysgit as I also posted this there.</p>
<p>&gt; Paul and Junio, the patches I sent in April are still not in git.gi=
t,<br>
&gt; are they? Can we use another repo until the <a href=3D"http://kernel.o=
rg">kernel.org</a> one is up? More<br>
&gt; than eight months to get a patch (or eight) merged is way too long,<br=
>
&gt; IMO.<br>
&gt;<br>
&gt; Martin</p>
<p>I&#39;m not sure how this might relate to your patches. I&#39;ve got a v=
ersion merged on top of the last version of the gitk report that I have whi=
ch includes those and it seems fine. As stated I did this work against git-=
core as the gitk repository continues to be unavailable. However as I have =
a pretty current snapshot=C2=A0 I have pushed this to github to provide som=
e visibility of things I know are not present within git-core. See <a href=
=3D"http://github.com/patthoyts/gitk.git">http://github.com/patthoyts/gitk.=
git</a> </p>

<div class=3D"gmail_quote">On Dec 15, 2011 8:01 PM, &quot;Martin von Zweigb=
ergk&quot; &lt;<a href=3D"mailto:martin.von.zweigbergk@gmail.com">martin.vo=
n.zweigbergk@gmail.com</a>&gt; wrote:<br type=3D"attribution"></div>

--bcaec50162d50c967404b4280614--
