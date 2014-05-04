From: "'502304919' via msysGit" <msysgit@googlegroups.com>
Subject: Re: [PATCH 10/12] MINGW: compat/poll/poll.c: undef NOGDI
Date: Sun, 4 May 2014 16:46:29 -0500
Message-ID: <1E023E9C-FDD6-47A5-9E7C-6D43F9167EEB@aol.com>
References: <20140504205552.GA15590@seldon>
Reply-To: 502304919 <boxerapp@aol.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="5366b535_327b23c6_7f3"
Cc: Erik Faye-Lund <kusmabite@gmail.com>, msysGit
 <msysgit@googlegroups.com>, Felipe Contreras
 <felipe.contreras@gmail.com>, GIT Mailing-list <git@vger.kernel.org>, 
 Stepan Kasal <kasal@ucw.cz>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBDHJTVHEWICRB6URUONQKGQE6BW36XQ@googlegroups.com Tue May 06 19:51:18 2014
Return-path: <msysgit+bncBDHJTVHEWICRB6URUONQKGQE6BW36XQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yh0-f64.google.com ([209.85.213.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDHJTVHEWICRB6URUONQKGQE6BW36XQ@googlegroups.com>)
	id 1WhjMi-0003E9-CE
	for gcvm-msysgit@m.gmane.org; Tue, 06 May 2014 19:41:16 +0200
Received: by mail-yh0-f64.google.com with SMTP id b6sf254826yha.19
        for <gcvm-msysgit@m.gmane.org>; Tue, 06 May 2014 10:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:reply-to:content-type;
        bh=xFCNMCm+NO4X7+3Lujz7ZXHv/ieDEjMqFHqAZWicnFc=;
        b=ZcKus4xSV2tOVlSrUQkSHBvNkTYIgj3caBmU8oIuBcQZv2jdizGHSwYsY+2ntf9b9V
         42tqElSbOk8eQta6AICpqC19XglJtpGwOrQ7g2BcoNJp99oIm/HbXLVKu017OquLsBmk
         MiagbCYkK4ZIWnrArLtBirxDDPB0TFDOdA42BFzJyLPClY9ErBEyaXDUvD/1GGS65Vje
         pWNHOyeL5rWWsA0YS35/0UJzy+lkw/HeKr5KzaHongTntmqN9YNFqOkGBwO+cCqGPPTx
         DIfo0NoX4iyutf3vymnLSzGdzK7mhStskkBvIhRxrXo09cAQakXqWfDA5zSBvY0wwT5J
         /v6A==
X-Received: by 10.182.111.170 with SMTP id ij10mr108284obb.18.1399376124831;
        Tue, 06 May 2014 04:35:24 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.236.102 with SMTP id ut6ls1592605obc.24.gmail; Tue, 06 May
 2014 04:35:22 -0700 (PDT)
X-Received: by 10.66.66.35 with SMTP id c3mr850169pat.7.1399376122847;
        Tue, 06 May 2014 04:35:22 -0700 (PDT)
Received: by 10.50.253.99 with SMTP id zz3msigc;
        Sun, 4 May 2014 14:46:30 -0700 (PDT)
X-Received: by 10.50.33.101 with SMTP id q5mr8590397igi.3.1399239990482;
        Sun, 04 May 2014 14:46:30 -0700 (PDT)
Received: from omr-d04.mx.aol.com (omr-d04.mx.aol.com. [205.188.109.201])
        by gmr-mx.google.com with ESMTPS id n7si624712qcz.2.2014.05.04.14.46.30
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 04 May 2014 14:46:30 -0700 (PDT)
Received-SPF: pass (google.com: domain of boxerapp@aol.com designates 205.188.109.201 as permitted sender) client-ip=205.188.109.201;
Received: from mtaout-aai02.mx.aol.com (mtaout-aai02.mx.aol.com [172.27.2.98])
	by omr-d04.mx.aol.com (Outbound Mail Relay) with ESMTP id 416AF7000008D;
	Sun,  4 May 2014 17:46:30 -0400 (EDT)
Received: from Kodiaks-iPhone (rrcs-67-78-97-126.sw.biz.rr.com [67.78.97.126])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mtaout-aai02.mx.aol.com (MUA/Third Party Client Interface) with ESMTPSA id E265738000095;
	Sun,  4 May 2014 17:46:28 -0400 (EDT)
In-Reply-To: <20140504205552.GA15590@seldon>
x-aol-global-disposition: G
x-aol-sid: 3039ac1b02625366b5342b55
X-AOL-IP: 67.78.97.126
X-Original-Sender: boxerapp@aol.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of boxerapp@aol.com designates 205.188.109.201 as
 permitted sender) smtp.mail=boxerapp@aol.com;       dkim=pass
 header.i=@mx.aol.com;       dmarc=pass (p=REJECT dis=NONE) header.from=aol.com
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
X-Original-From: 502304919 <boxerapp@aol.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248194>

--5366b535_327b23c6_7f3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I've added this to my to-do list. On May 4, 2014 at 3:55:52 PM CDT, Marat R=
adchenko <marat@slonopotamus.org> wrote:On Sun, May 04, 2014 at 08:52:44PM =
+0200, Stepan Kasal wrote:> Thank you very much for this analysis.> It enab=
les us to redirect you the third time: to report this as a> bug in MinGW-W6=
4 ! ;-)I'll report this to MinGW-W64 soon, though even if/when they fixthe =
issue on their side, I'd still like to have a workaround inGit to be able t=
o use older MinGW-W64 versions that didn'treceive a fix.> Seriously, it loo=
ks you found the best description of the problem,> and it would be nice if =
you could modify your patch so that it> is really a work around: it would b=
e in effect only for MinGW-W64,> and the comment would explain that this is=
 a hack to work around the> bug. Workarounds do not have to be ugly and ful=
l of #ifdef's.> If you manage to change the defs for poll.c without changin=
g its> content, no one could tell you to report to gnulib first.v1 does exa=
ctly this.> OTOH, if MsgWaitForMultipleObjects is present ustream (in gnuli=
b's> poll.c, sorry that I cannot check right now), it still might be> bette=
r to submit the work-around there first.Workaround is "just don't pass -DNO=
GDI on MinGW-W64 if you wantMsgWaitForMultipleObjects", there's nothing to =
send to gnulib.After all, was there a strong reason why Git started passing=
 it?What is there was no option to disable part of windows.h?--To unsubscri=
be from this list: send the line "unsubscribe git" inthe body of a message =
to majordomo@vger.kernel.orgMore majordomo info at http://vger.kernel.org/m=
ajordomo-info.html    =20

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
For more options, visit https://groups.google.com/d/optout.

--5366b535_327b23c6_7f3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><body><div>I've added this to my to-do list.</div><br/><br/><div><div=
 class=3D"quote">On May 4, 2014 at 3:55:52 PM CDT, Marat Radchenko &lt;mara=
t@slonopotamus.org&gt; wrote:<br/><blockquote type=3D"cite" style=3D"border=
-left-style:solid;border-width:1px;margin-left:0px;padding-left:10px;">On S=
un, May 04, 2014 at 08:52:44PM +0200, Stepan Kasal wrote:<br />> Thank you =
very much for this analysis.<br />> It enables us to redirect you the third=
 time: to report this as a<br />> bug in MinGW-W64 !  ;-)<br /><br />I'll r=
eport this to MinGW-W64 soon, though even if/when they fix<br />the issue o=
n their side, I'd still like to have a workaround in<br />Git to be able to=
 use older MinGW-W64 versions that didn't<br />receive a fix.<br /><br />> =
Seriously, it looks you found the best description of the problem,<br />> a=
nd it would be nice if you could modify your patch so that it<br />> is rea=
lly a work around: it would be in effect only for MinGW-W64,<br />> and the=
 comment would explain that this is a hack to work around the<br />> bug.  =
<br /><br />Workarounds do not have to be ugly and full of #ifdef's.<br /><=
br />> If you manage to change the defs for poll.c without changing its<br =
/>> content, no one could tell you to report to gnulib first.<br /><br />v1=
 does exactly this.<br /><br />> OTOH, if MsgWaitForMultipleObjects is pres=
ent ustream (in gnulib's<br />> poll.c, sorry that I cannot check right now=
), it still might be<br />> better to submit the work-around there first.<b=
r /><br />Workaround is "just don't pass -DNOGDI on MinGW-W64 if you want<b=
r />MsgWaitForMultipleObjects", there's nothing to send to gnulib.<br />Aft=
er all, was there a strong reason why Git started passing it?<br />What is =
there was no option to disable part of windows.h?<br />--<br />To unsubscri=
be from this list: send the line "unsubscribe git" in<br />the body of a me=
ssage to majordomo@vger.kernel.org<br />More majordomo info at  http://vger=
.kernel.org/majordomo-info.html<br /></blockquote></div></div></body></html=
>

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
quot;msysGit&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:msysgit+unsubscribe@googlegroups.com">msysgit+uns=
ubscribe@googlegroups.com</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

--5366b535_327b23c6_7f3--
