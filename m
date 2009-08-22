From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [PATCH 03/14] Define SNPRINTF_SIZE_CORR=1 for Microsoft
 Visual  C++
Date: Sat, 22 Aug 2009 13:25:22 +0200
Message-ID: <18cd41840908220425n7a4abebfk555a2cb6421c48aa@mail.gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com> <c899c41fdccfdc94ae294f1a50895ba0290a1ec3.1250860247.git.mstormo@gmail.com> <7vr5v4dgz0.fsf@alter.siamese.dyndns.org> <200908212341.37531.j6t@kdbg.org> <7vfxbkbyvw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=0016e6d644ef8d5cd60471b93d5b
Cc: Johannes Sixt <j6t@kdbg.org>, Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,  git@vger.kernel.org, lznuaa@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Aug 22 13:29:58 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f137.google.com ([209.85.211.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeonG-0005s8-3V
	for gcvm-msysgit@m.gmane.org; Sat, 22 Aug 2009 13:29:58 +0200
Received: by ywh1 with SMTP id 1so3721129ywh.21
        for <gcvm-msysgit@m.gmane.org>; Sat, 22 Aug 2009 04:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=QRNSbp4cyM+MdSwOa8J2fxvlJP5Ppxn51EA52cTVmKM=;
        b=7D42LrYCgZyV4irJJZwg+5U8V/cOELiuk2BgZP33FlLPqHl84Nuu74w1NbgolL1gSg
         acmXh4376d4BosSmJgg+uebbyr8rxPSlGLB1LjdWZ3g1h7SAEYaIo9EHuvegz/uKT44w
         tSG3lmNwDZW27dro4LQgDsw5jzt5/uRM24yW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=SHIJSHdJ4gA4Q1vzHmWpb3TOe+w/bmZc13+HWsYxA+cyjTsbNz3jtc1jNdpwBFSiiT
         oTC9Plr6h7cxT5r2bQts4LeEao91zHAmA3S6LhUPtn2qclLpA6SD4ujiG5+KCbHB6a67
         R9rAW6hJNqXKxGVtrzOjS/daLx6x1vlNCELJI=
Received: by 10.229.56.13 with SMTP id w13mr141092qcg.10.1250940591586;
        Sat, 22 Aug 2009 04:29:51 -0700 (PDT)
Received: by 10.176.54.11 with SMTP id c11gr6695yqa.0;
	Sat, 22 Aug 2009 04:25:24 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.88.17 with SMTP id l17mr501174ebb.13.1250940323715; Sat, 22 Aug 2009 04:25:23 -0700 (PDT)
Received: by 10.210.88.17 with SMTP id l17mr501173ebb.13.1250940323686; Sat, 22 Aug 2009 04:25:23 -0700 (PDT)
Received: from mail-ew0-f215.google.com (mail-ew0-f215.google.com [209.85.219.215]) by gmr-mx.google.com with ESMTP id 13si742436ewy.2.2009.08.22.04.25.22; Sat, 22 Aug 2009 04:25:22 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.215 as permitted sender) client-ip=209.85.219.215;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.215 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-ew0-f215.google.com with SMTP id 11so1205604ewy.35 for <msysgit@googlegroups.com>; Sat, 22 Aug 2009 04:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type; bh=DTI6RRaSNccOFtRYuHQifW6PSDl+W5oZ9PsMgI8M4tE=; b=XbwM8PUYPqrOddq19FJArajBJE1Q5N/9jfsYG4gOlGwbBQjxjkxm5RQYZhGzQEfQ0o IpPPdygQOcYKGDNMZ6DSa9HBJhqcleOI/oVRjFQaRaM49jGWChBE9dUkJ5pDt1CBhgbz 4QwWBGH+xCqMWEfyBforFXgBPqQDa7Coo0z6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type; b=UgrnVvtsp6JHFIfXZ17N//yj/q9kUIVJZE0608KkZWIV02/g0HxWn/Hp5vq/tySx1s J9na5CwTfbBN0p6HgUJdB/yBiS7Q/yt8IMKJWZXa2nRF3aU2YAhPxQ1wdPbQy5lXJ99j yD0IOxKFLR7xJvmqlqfz+Ejx9qAnVVlCCvE7c=
Received: by 10.216.93.13 with SMTP id k13mr437412wef.75.1250940322405; Sat,  22 Aug 2009 04:25:22 -0700 (PDT)
In-Reply-To: <7vfxbkbyvw.fsf@alter.siamese.dyndns.org>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126806>


--0016e6d644ef8d5cd60471b93d5b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Sat, Aug 22, 2009 at 12:11 AM, Junio C Hamano <gitster@pobox.com> wrote:

> Johannes Sixt <j6t@kdbg.org> writes:
>
> > Not quite. The parameter *is* the size of the buffer and vsnprintf does
> not
> > write beyond the buffer. However, it has the awkward behavior that if the
> > buffer is too short by exactly one byte...
>
> Thanks; I was fooled by the leading comment.  How about ...
>
>  compat/snprintf.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/compat/snprintf.c b/compat/snprintf.c
> index 6c0fb05..4d07087 100644
> --- a/compat/snprintf.c
> +++ b/compat/snprintf.c
> @@ -3,7 +3,8 @@
>  /*
>  * The size parameter specifies the available space, i.e. includes
>  * the trailing NUL byte; but Windows's vsnprintf expects the
> - * number of characters to write without the trailing NUL.
> + * number of characters to write, and does not necessarily write the
> + * trailing NUL.
>  */
>  #ifndef SNPRINTF_SIZE_CORR
>  #if defined(__MINGW32__) && defined(__GNUC__) && __GNUC__ < 4
>

Agreed. If you'd like, I'll squash that into the change, and make the commit
msg more clear.

--
.marius

--0016e6d644ef8d5cd60471b93d5b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Sat, Aug 22, 2009 at 12:11 AM, Junio C Hamano=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:gitster@pobox.com">gitster@pobox.c=
om</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"bord=
er-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-l=
eft: 1ex;">
<div class=3D"im">Johannes Sixt &lt;<a href=3D"mailto:j6t@kdbg.org">j6t@kdb=
g.org</a>&gt; writes:<br>
<br>
&gt; Not quite. The parameter *is* the size of the buffer and vsnprintf doe=
s not<br>
&gt; write beyond the buffer. However, it has the awkward behavior that if =
the<br>
</div>&gt; buffer is too short by exactly one byte...<br>
<br>
Thanks; I was fooled by the leading comment. =A0How about ...<br>
<br>
=A0compat/snprintf.c | =A0 =A03 ++-<br>
<div class=3D"im">=A01 files changed, 2 insertions(+), 1 deletions(-)<br>
<br>
diff --git a/compat/snprintf.c b/compat/snprintf.c<br>
</div>index 6c0fb05..4d07087 100644<br>
<div class=3D"im">--- a/compat/snprintf.c<br>
+++ b/compat/snprintf.c<br>
</div>@@ -3,7 +3,8 @@<br>
=A0/*<br>
 =A0* The size parameter specifies the available space, i.e. includes<br>
 =A0* the trailing NUL byte; but Windows&#39;s vsnprintf expects the<br>
- * number of characters to write without the trailing NUL.<br>
+ * number of characters to write, and does not necessarily write the<br>
<div><div></div><div class=3D"h5">+ * trailing NUL.<br>
 =A0*/<br>
=A0#ifndef SNPRINTF_SIZE_CORR<br>
=A0#if defined(__MINGW32__) &amp;&amp; defined(__GNUC__) &amp;&amp; __GNUC_=
_ &lt; 4<br>
</div></div></blockquote></div><br>Agreed. If you&#39;d like, I&#39;ll squa=
sh that into the change, and make the commit msg more clear.<br clear=3D"al=
l"><br>--<br>.marius<br>

--0016e6d644ef8d5cd60471b93d5b--
