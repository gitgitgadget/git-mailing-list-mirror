From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] mingw: enable NO_PYTHON
Date: Thu, 7 Jan 2010 23:00:20 +0100
Message-ID: <40aa078e1001071400j21900ed1n415394491d469b8c@mail.gmail.com>
References: <1262901159-1436-1-git-send-email-kusmabite@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: 3d1lGSwkOB2IKUSMABITEGOOGLEMAIL.COMMSYSGITGOOGLEGROUPS.COM@listserv.bounces.google.com Thu Jan 07 23:00:43 2010
Return-path: <3d1lGSwkOB2IKUSMABITEGOOGLEMAIL.COMMSYSGITGOOGLEGROUPS.COM@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f190.google.com ([209.85.217.190])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT0PK-0003hb-DG
	for gcvm-msysgit@m.gmane.org; Thu, 07 Jan 2010 23:00:42 +0100
Received: by gxk6 with SMTP id 6sf48059364gxk.13
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Jan 2010 14:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:mime-version:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe:content-type
         :content-transfer-encoding;
        bh=3ZCAplgLnMWEE1FbPBxGwHejgM+F0WPLzLKowbScnaY=;
        b=4W2mXEm+ilJm85jCxZFwrv/7lxYVZe+XU6k3CrmSc6ZhYZnWeKJDR4CSp2GVI/f8EU
         tL8oOq6QoNbELQpyK9FvMlMzvlc2h/r9UOAyELgWxmCPK3WWxpMh3PuCYW4DbWY7NdfC
         5LgRaJLVpwnIgnKMIgdwP4fdYYebFzt4bgupw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe:content-type
         :content-transfer-encoding;
        b=iyeeoUIkmPHTJs1oft6umTh6YaHgx2SkcPmSdlM7aT//ByCEEtlhcgMbrf+/tjXvXl
         dWdZ3PyuT9Se+Q2+uJ+LhTM0Vz6IgfOdOFi91g8sjfBL3zS6d/idRjZfudfr1b48GFWu
         BOVxmr7TFV0vJeUblT9FLNDdp8jHCz5GICPJY=
Received: by 10.101.119.18 with SMTP id w18mr1603885anm.1.1262901624692;
        Thu, 07 Jan 2010 14:00:24 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.213.57.18 with SMTP id a18ls435894ebh.3.p; Thu, 07 Jan 2010 
	14:00:22 -0800 (PST)
Received: by 10.213.75.202 with SMTP id z10mr3856163ebj.7.1262901622412;
        Thu, 07 Jan 2010 14:00:22 -0800 (PST)
Received: by 10.213.75.202 with SMTP id z10mr3856162ebj.7.1262901622390;
        Thu, 07 Jan 2010 14:00:22 -0800 (PST)
Received: from mail-ew0-f215.google.com (mail-ew0-f215.google.com [209.85.219.215])
        by gmr-mx.google.com with ESMTP id 18si2934820ewy.4.2010.01.07.14.00.21;
        Thu, 07 Jan 2010 14:00:21 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.215 as permitted sender) client-ip=209.85.219.215;
Received: by ewy7 with SMTP id 7so3191587ewy.30
        for <msysgit@googlegroups.com>; Thu, 07 Jan 2010 14:00:21 -0800 (PST)
Received: by 10.216.89.139 with SMTP id c11mr2182070wef.198.1262901620967; 
	Thu, 07 Jan 2010 14:00:20 -0800 (PST)
In-Reply-To: <1262901159-1436-1-git-send-email-kusmabite@gmail.com>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of kusmabite@googlemail.com designates 209.85.219.215 as permitted 
	sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) 
	header.i=@googlemail.com
X-Original-Sender: kusmabite@googlemail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/c47e2d2a7bf1b2d5
X-Message-Url: http://groups.google.com/group/msysgit/msg/6bd03679077abf49
Sender: msysgit@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136395>

Uhm, I just realized that I sent out a patch that wasn't clean against
Junio's master after all. I'll send out a fixed one ASAP.

Sorry about the noise.

On Thu, Jan 7, 2010 at 10:52 PM, Erik Faye-Lund
<kusmabite@googlemail.com> wrote:
> Python is not commonly installed on Windows machines, so
> we should disable it there by default.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>
> This patch is against Junio's current master, and enables
> msysgit to compile upstream git again after Sverre's addition
> of the python remote-helpers (2fe40b6).
>
> =A0Makefile | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 1c7668a..a2780a2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1028,6 +1028,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
> =A0 =A0 =A0 =A0BLK_SHA1 =3D YesPlease
> =A0 =A0 =A0 =A0NO_INET_PTON =3D YesPlease
> =A0 =A0 =A0 =A0NO_INET_NTOP =3D YesPlease
> + =A0 =A0 =A0 NO_PYTHON =3D YesPlease
> =A0 =A0 =A0 =A0COMPAT_CFLAGS +=3D -D__USE_MINGW_ACCESS -DNOGDI -Icompat -=
Icompat/fnmatch
> =A0 =A0 =A0 =A0COMPAT_CFLAGS +=3D -DSTRIP_EXTENSION=3D\".exe\"
> =A0 =A0 =A0 =A0COMPAT_OBJS +=3D compat/mingw.o compat/fnmatch/fnmatch.o c=
ompat/winansi.o
> --
> 1.6.6.95.g82b1b.dirty
>
>



--=20
Erik "kusma" Faye-Lund
