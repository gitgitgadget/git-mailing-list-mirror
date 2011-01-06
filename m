From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2] alias: use run_command api to execute aliases
Date: Thu, 6 Jan 2011 21:14:07 +0100
Message-ID: <AANLkTi=aPjtfFVKX6XqHyZYVaT07ExnWVF140JJ==U+m@mail.gmail.com>
References: <1294343649-6272-1-git-send-email-kusmabite@gmail.com>
	<20110106200518.GA14945@burratino>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=20cf30433eb0de512d0499332421
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: msysgit+bncCOPdven-DxCRxZjpBBoEhr6k7g@googlegroups.com Thu Jan 06 21:14:36 2011
Return-path: <msysgit+bncCOPdven-DxCRxZjpBBoEhr6k7g@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fx0-f58.google.com ([209.85.161.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCRxZjpBBoEhr6k7g@googlegroups.com>)
	id 1PawEF-0003Lj-1O
	for gcvm-msysgit@m.gmane.org; Thu, 06 Jan 2011 21:14:35 +0100
Received: by fxm13 with SMTP id 13sf6164005fxm.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 06 Jan 2011 12:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:mime-version:received:received
         :received:reply-to:in-reply-to:references:date:message-id:subject
         :from:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=bGckgIP0yY6Ta6joY7laIcpnpGqNgCBfnucS3SlIvkc=;
        b=QqvQldGHxhEQ/lnuWAuaUW6TAB8nI4prlFlmmjHCSOnEZzY+jSRfIYpRJtKch8oDhu
         peC6ANfWriXXEIB7VkuP7F5NDbwpSnLk3NoZeSxfc6F+0DPbR1cdOIIa3xDftvDVs6qn
         Dp2HrS80/G6bsHj6N8afZiSuQajhRDPZVD2m8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        b=ARKavUCzRAck84ZiyhpzzCOABC3ARm6mUou0BHLUH8zVvlwrdvxJQAGweYddlDKTkx
         hrnPB8RyILmVPc0bHx6NfYA8Dnsx9Ss7BFYtHD7mEJtdUAe3i8CiUbUXFUYB0pjA9FXB
         nkL7lg8px9tumAH2LKCvTCA0EeRsOtirbs+E0=
Received: by 10.223.83.195 with SMTP id g3mr1689238fal.5.1294344849849;
        Thu, 06 Jan 2011 12:14:09 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.223.1.9 with SMTP id 9ls919014fad.0.p; Thu, 06 Jan 2011
 12:14:08 -0800 (PST)
Received: by 10.223.87.67 with SMTP id v3mr1567989fal.23.1294344848932;
        Thu, 06 Jan 2011 12:14:08 -0800 (PST)
Received: by 10.223.87.67 with SMTP id v3mr1567988fal.23.1294344848895;
        Thu, 06 Jan 2011 12:14:08 -0800 (PST)
Received: from mail-fx0-f54.google.com (mail-fx0-f54.google.com [209.85.161.54])
        by gmr-mx.google.com with ESMTP id 6si2097156fay.10.2011.01.06.12.14.07;
        Thu, 06 Jan 2011 12:14:07 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.161.54 as permitted sender) client-ip=209.85.161.54;
Received: by mail-fx0-f54.google.com with SMTP id 16so16428259fxm.41
        for <msysgit@googlegroups.com>; Thu, 06 Jan 2011 12:14:07 -0800 (PST)
Received: by 10.223.86.193 with SMTP id t1mr601020fal.147.1294344847773; Thu,
 06 Jan 2011 12:14:07 -0800 (PST)
Received: by 10.223.79.3 with HTTP; Thu, 6 Jan 2011 12:14:07 -0800 (PST)
Received: by 10.223.79.3 with HTTP; Thu, 6 Jan 2011 12:14:07 -0800 (PST)
In-Reply-To: <20110106200518.GA14945@burratino>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.161.54 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164665>

--20cf30433eb0de512d0499332421
Content-Type: text/plain; charset=ISO-8859-1

On Jan 6, 2011 9:05 PM, "Jonathan Nieder" <jrnieder@gmail.com> wrote:
>
> Erik Faye-Lund wrote:
>
> > --- a/git.c
> > +++ b/git.c
> > @@ -177,22 +177,22 @@ static int handle_alias(int *argcp, const char
***argv)
> [...]
> > +                     alias_argv = xmalloc(sizeof(char *) * argc + 1);
>
> Missed a spot?  (missing parens)
>

Blergh... I guess that teaches me a lesson about sending out patches in a
hurry. New version a bit later, then ;)

> Thanks for this.  It also should provide a minor speedup in the case
> of commands with no shell metacharacters.

Nice. Not intentional, but hey :)

--20cf30433eb0de512d0499332421
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>On Jan 6, 2011 9:05 PM, &quot;Jonathan Nieder&quot; &lt;<a href=3D"mailt=
o:jrnieder@gmail.com">jrnieder@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Erik Faye-Lund wrote:<br>
&gt;<br>
&gt; &gt; --- a/git.c<br>
&gt; &gt; +++ b/git.c<br>
&gt; &gt; @@ -177,22 +177,22 @@ static int handle_alias(int *argcp, const c=
har ***argv)<br>
&gt; [...]<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 alias_argv =3D xmalloc(=
sizeof(char *) * argc + 1);<br>
&gt;<br>
&gt; Missed a spot? =A0(missing parens)<br>
&gt;</p>
<p>Blergh... I guess that teaches me a lesson about sending out patches in =
a hurry. New version a bit later, then ;)</p>
<p>&gt; Thanks for this. =A0It also should provide a minor speedup in the c=
ase<br>
&gt; of commands with no shell metacharacters.</p>
<p>Nice. Not intentional, but hey :)</p>

--20cf30433eb0de512d0499332421--
