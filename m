From: "Vasyl'" <vvavrychuk@gmail.com>
Subject: Re: [PATCH] Trim ending whitespaces in exclude file if needed.
Date: Sun, 17 Oct 2010 12:29:06 +0300
Message-ID: <AANLkTimrgGYXDtN_ukWuCpjGTibrMNLQvfpq8fe=VxS_@mail.gmail.com>
References: <AANLkTinUHQzuLJhZnVMKngEO75W=+5sES0WZFAFw5bDw@mail.gmail.com>
	<20101017024133.GF26656@burratino>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=001636c5b3f5f8c9ba0492ccb0d2
Cc: git@vger.kernel.org, msysgit@googlegroups.com, 
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: msysgit+bncCMyR8JCOHBCRiuvlBBoEZ-_YHw@googlegroups.com Sun Oct 17 11:43:07 2010
Return-path: <msysgit+bncCMyR8JCOHBCRiuvlBBoEZ-_YHw@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ww0-f58.google.com ([74.125.82.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCMyR8JCOHBCRiuvlBBoEZ-_YHw@googlegroups.com>)
	id 1P7Pli-0006db-Jv
	for gcvm-msysgit@m.gmane.org; Sun, 17 Oct 2010 11:43:06 +0200
Received: by wwi17 with SMTP id 17sf1394061wwi.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 17 Oct 2010 02:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received:received-spf:received:mime-version:received
         :received:in-reply-to:references:date:message-id:subject:from:to:cc
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=68T6MPGbWcQEjvLbDCFOtBBWEnybsL6DJwjsr5erza8=;
        b=MYzUToJ9EwVa0vBfBsJFfRA91dL99ZtrtoneJrdM1lcncb3AYUXjxxEuvi7sPdV0LZ
         mZOVqqZKVpZwLitlTouyyi2B3Yc4QYeQ7uo9dpB3gVHmdSmaOZ5DhZ99nI6qc3WrWLJ9
         +CaUdBQu/5VSaftRdISzrEVMUW8QYeXhHgeL0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        b=0gxse2EjHnJDEbA/7L4nqDEVQ3kVDQf9lV90GYC7lETqKfvcgwv5UnKOl2JJoW46ev
         Qd2szx+4RjjCANc/H6SRpfs3UvVf4MHU88P+/hHY4CwJ5/lNiqaCTf4nsDAtcp0SQ+K6
         lJ99Q+r26CwUJfraODV1Nz2Tt/QEdeK1XCtTo=
Received: by 10.216.236.90 with SMTP id v68mr246748weq.7.1287308561974;
        Sun, 17 Oct 2010 02:42:41 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.216.208.4 with SMTP id p4ls470018weo.2.p; Sun, 17 Oct 2010
 02:42:40 -0700 (PDT)
Received: by 10.216.140.23 with SMTP id d23mr199814wej.1.1287308560796;
        Sun, 17 Oct 2010 02:42:40 -0700 (PDT)
Received: by 10.204.160.75 with SMTP id m11mr222661bkx.22.1287307748128;
        Sun, 17 Oct 2010 02:29:08 -0700 (PDT)
Received: by 10.204.160.75 with SMTP id m11mr222660bkx.22.1287307748104;
        Sun, 17 Oct 2010 02:29:08 -0700 (PDT)
Received: from mail-bw0-f43.google.com (mail-bw0-f43.google.com [209.85.214.43])
        by gmr-mx.google.com with ESMTP id w9si3751133bkz.4.2010.10.17.02.29.07;
        Sun, 17 Oct 2010 02:29:07 -0700 (PDT)
Received-SPF: pass (google.com: domain of vvavrychuk@gmail.com designates 209.85.214.43 as permitted sender) client-ip=209.85.214.43;
Received: by bwz20 with SMTP id 20so2780848bwz.30
        for <msysgit@googlegroups.com>; Sun, 17 Oct 2010 02:29:07 -0700 (PDT)
Received: by 10.204.59.207 with SMTP id m15mr431383bkh.8.1287307746920; Sun,
 17 Oct 2010 02:29:06 -0700 (PDT)
Received: by 10.204.69.212 with HTTP; Sun, 17 Oct 2010 02:29:06 -0700 (PDT)
In-Reply-To: <20101017024133.GF26656@burratino>
X-Original-Sender: vvavrychuk@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of vvavrychuk@gmail.com designates 209.85.214.43 as permitted sender)
 smtp.mail=vvavrychuk@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159199>

--001636c5b3f5f8c9ba0492ccb0d2
Content-Type: text/plain; charset=ISO-8859-1

Jonathan Nieder <jrnieder@gmail.com> wrote:

> (+cc: msysgit)
>
> Vasyl' wrote:
>
> > Hope this can save someone's time debugging git.
>
> It sounds like there's a story behind this one.  Could you tell it?
> That would help future readers of this code to easily determine
> why they shouldn't break it.
>
I modify either .git/info/exclude or .gitignore by copy-pasting `git
status`. But unfortunetly this adds spacing to ends of lines and ignoring
does not work...

>
> > --- a/dir.c
> > +++ b/dir.c
> > @@ -171,7 +171,15 @@ void add_exclude(const char *string, const char
> *base,
> >               to_exclude = 0;
> >               string++;
> >       }
> > +
>
> Why?
>
> >       len = strlen(string);
> > +     if (len && isspace((unsigned char)string[len - 1])) {
>
> This cast is not needed (see git-compat-util.h).
>
> > +             struct strbuf trim_buf = STRBUF_INIT;
> > +             strbuf_add(&trim_buf, string, len);
> > +             strbuf_rtrim(&trim_buf);
>
> Missing free(string)?
>
I have misunderstood in the first iteration memory managment in the
add_exclude's function code
 struct exclude *x;
char *s;
x = xmalloc(sizeof(*x) + len);
s = (char *)(x+1);
memcpy(s, string, len - 1);
s[len - 1] = '\0';
string = s;
And fix of my patch needs more change and testing. I will do this later.

>
> > +             string = strbuf_detach(&trim_buf, &len);
> > +     }
> > +
> >       if (len && string[len - 1] == '/') {
>
> Thanks for a clear and pleasant read.
>
Thanks for review.

> Jonathan
>

--001636c5b3f5f8c9ba0492ccb0d2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jonathan Nieder <span dir=3D"ltr">&lt;<a href=3D"mailto:jrnieder@gmail.com"=
>jrnieder@gmail.com</a>&gt;</span> wrote:<br><div class=3D"gmail_quote"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex;">
(+cc: msysgit)<br>
<div class=3D"im"><br>
Vasyl&#39; wrote:<br>
<br>
&gt; Hope this can save someone&#39;s time debugging git.<br>
<br>
</div>It sounds like there&#39;s a story behind this one. =A0Could you tell=
 it?<br>
That would help future readers of this code to easily determine<br>
why they shouldn&#39;t break it.<br></blockquote><div>I modify either .git/=
info/exclude or .gitignore by copy-pasting `git status`. But unfortunetly t=
his adds spacing to ends of lines and ignoring does not work...</div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex;">

<div class=3D"im"><br>
&gt; --- a/dir.c<br>
&gt; +++ b/dir.c<br>
&gt; @@ -171,7 +171,15 @@ void add_exclude(const char *string, const char *=
base,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 to_exclude =3D 0;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 string++;<br>
&gt; =A0 =A0 =A0 }<br>
&gt; +<br>
<br>
</div>Why?<br>
<div class=3D"im"><br>
&gt; =A0 =A0 =A0 len =3D strlen(string);<br>
&gt; + =A0 =A0 if (len &amp;&amp; isspace((unsigned char)string[len - 1])) =
{<br>
<br>
</div>This cast is not needed (see git-compat-util.h).<br>
<div class=3D"im"><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 struct strbuf trim_buf =3D STRBUF_INIT;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 strbuf_add(&amp;trim_buf, string, len);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 strbuf_rtrim(&amp;trim_buf);<br>
<br>
</div>Missing free(string)?<br></blockquote><div>I have misunderstood in th=
e first iteration memory managment in the add_exclude&#39;s function code</=
div>=A0<span class=3D"Apple-style-span" style=3D"white-space: pre;">struct =
exclude *x;</span>=A0<div>
<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>char *s;<=
/div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span=
>x =3D xmalloc(sizeof(*x) + len);</div><div><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>s =3D (char *)(x+1);</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>memc=
py(s, string, len - 1);</div><div><span class=3D"Apple-tab-span" style=3D"w=
hite-space:pre">		</span>s[len - 1] =3D &#39;\0&#39;;</div><div><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">		</span>string =3D s;</div>
<div>And fix of my patch needs more change and testing. I will do this late=
r.</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im"><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 string =3D strbuf_detach(&amp;trim_buf, &amp=
;len);<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; =A0 =A0 =A0 if (len &amp;&amp; string[len - 1] =3D=3D &#39;/&#39;) {<b=
r>
<br>
</div>Thanks for a clear and pleasant read.<br></blockquote><div>Thanks for=
 review.=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex;">
<font color=3D"#888888">Jonathan<br>
</font></blockquote></div><br>

--001636c5b3f5f8c9ba0492ccb0d2--
