From: Jerry Xinyu Zhao <xyzjerry-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: BUG: [Cosmetic] Commiting a gerrit ChangeId
 before the commit hook was installed
Date: Fri, 17 Jan 2014 15:24:21 -0800
Message-ID: <CAE3ttVgs=F2bWbx5qa=dp1kNzgc5djtB3r+2Qp6tvYv-iZKoCw@mail.gmail.com>
References: <CAC9meRKiR+60YaGiuCu4twEt6dyWksEjHSH8YPTEvmD=LoB=aw@mail.gmail.com>
 <20140117204132.GB18964@google.com>
 <CAC9meR+78_EvoqHNcuPyDKOZDjSsUngziGDa2aV1QDtOb8eOXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3032141583287442013=="
Cc: Jonathan Nieder <jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "openstack-infra-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org"
 <openstack-infra-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>, git <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Strainu <strainu10-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: openstack-infra-bounces+gcoi-openstack-infra=m.gmane.org-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org Sat Jan 18 00:25:39 2014
Return-path: <openstack-infra-bounces+gcoi-openstack-infra=m.gmane.org-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>
Envelope-to: gcoi-openstack-infra@m.gmane.org
Received: from lists.openstack.org ([50.56.173.222])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <openstack-infra-bounces+gcoi-openstack-infra=m.gmane.org-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>)
	id 1W4InA-0007ys-A4
	for gcoi-openstack-infra@m.gmane.org; Sat, 18 Jan 2014 00:25:36 +0100
Received: from localhost ([127.0.0.1] helo=lists.openstack.org)
	by lists.openstack.org with esmtp (Exim 4.76)
	(envelope-from <openstack-infra-bounces-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>)
	id 1W4Imy-0006AF-Iv; Fri, 17 Jan 2014 23:25:24 +0000
Received: from [2a00:1450:400c:c05::22b] (helo=mail-wi0-x22b.google.com)
 by lists.openstack.org with esmtp (Exim 4.76)
 (envelope-from <xyzjerry-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>) id 1W4Ily-0005uT-SC
 for openstack-infra-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org; Fri, 17 Jan 2014 23:24:23 +0000
Received: by mail-wi0-f171.google.com with SMTP id cc10so1372310wib.16
 for <openstack-infra-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>;
 Fri, 17 Jan 2014 15:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
 h=mime-version:in-reply-to:references:date:message-id:subject:from:to
 :cc:content-type;
 bh=HyOWK5Fvo8QSNwrj981XsFEUz3Hv+7Joe1wQBQsSpSw=;
 b=t+S0zros127DSP8RnmVaTKIdPl3KrWwyfJvpGW1FiYgO2bsYlaxPphGeNTCgh/Of8Q
 6tflUEzLGJ7TEeXykRU9pwbJJnGMDpoqqO9wHzfX8WDx4j3nN8BepJ+8xaSZAdTJhrVV
 kSfCpZn9ys858Jl/mMxl5fHyG+hXPU9NaOY1BzNEpE1fKuT7nQPSs25FzzweZlzj1+Gv
 gjPqMvTtVmGXvbzUG2idlJPB20QTOIb5uD/VOTNyUjnfX7MDJCii+bOvP7uDAMOUJvoJ
 GS6vsIW327jIHu2elS+XVpNcQ58qp6c2R3JyOV56sMnenH/UWmg5Q6o9uN93arEWrQt7
 TL9w==
X-Received: by 10.180.97.10 with SMTP id dw10mr566945wib.25.1390001061985;
 Fri, 17 Jan 2014 15:24:21 -0800 (PST)
Received: by 10.194.2.177 with HTTP; Fri, 17 Jan 2014 15:24:21 -0800 (PST)
In-Reply-To: <CAC9meR+78_EvoqHNcuPyDKOZDjSsUngziGDa2aV1QDtOb8eOXw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
X-BeenThere: openstack-infra-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Infrastructure support for the OpenStack project
 <openstack-infra.lists.openstack.org>
List-Unsubscribe: <http://lists.openstack.org/cgi-bin/mailman/options/openstack-infra>, 
 <mailto:openstack-infra-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.openstack.org/pipermail/openstack-infra>
List-Post: <mailto:openstack-infra-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:openstack-infra-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-infra>, 
 <mailto:openstack-infra-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject=subscribe>
Errors-To: openstack-infra-bounces+gcoi-openstack-infra=m.gmane.org-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240634>

--===============3032141583287442013==
Content-Type: multipart/alternative; boundary=f46d0443064e8984f404f032d735

--f46d0443064e8984f404f032d735
Content-Type: text/plain; charset=ISO-8859-1

I think if you hadn't installed the commit hook for generating change ID,
the commit indeed wouldn't have included a change ID, which is necessary
for referencing the change when you submit a patch over it. There is
nothing wrong with the message.  git review tool will install the hook and
add a change ID for you automatically(a new feature of recent git-review
release).



On Fri, Jan 17, 2014 at 1:10 PM, Strainu <strainu10-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> 2014/1/17 Jonathan Nieder <jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> > Hi,
> >
> > Strainu wrote:
> >
> >> strainu@emily:~/core> git review -f
> >> Creating a git remote called "gerrit" that maps to:
> >>         ssh://strainu-pdwPRaUiG6tP5deQkEKVHGD2FQJk+8+b@public.gmane.org:29418/pywikibot/core.git
> >> Your change was committed before the commit hook was installed.
> >> Amending the commit to add a gerrit change id.
> >>
> >> At this point I ended the transaction, as I was confused by the last
> >> message: I was afraid the ChangeId would have changed, causing the
> >> patch to be attached to another review.
> >>
> >> I think git should not show this message if the change description
> >> already has a change id
> >
> > This message doesn't come from git.  It comes from the git-review
> > tool (in git_review/cmd.py), so cc-ing the authors in case they
> > have thoughts on that.
>
> Thanks for clarifying that. I'll log a bug on launchpad then.
>
> Strainu
>
> _______________________________________________
> OpenStack-Infra mailing list
> OpenStack-Infra-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org
> http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-infra
>

--f46d0443064e8984f404f032d735
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I think if you hadn&#39;t installed the commit hook for ge=
nerating change ID, the commit indeed wouldn&#39;t have included a change I=
D, which is necessary for referencing the change when you submit a patch ov=
er it. There is nothing wrong with the message. =A0git review tool will ins=
tall the hook and add a change ID for you automatically(a new feature of re=
cent git-review release).=A0<div>
<br></div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quot=
e">On Fri, Jan 17, 2014 at 1:10 PM, Strainu <span dir=3D"ltr">&lt;<a href=
=3D"mailto:strainu10-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">strainu10-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&g=
t;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">2014/1/17 Jonathan Nieder &lt;<a href=3D"mai=
lto:jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;:<br>
<div class=3D"im">&gt; Hi,<br>
&gt;<br>
&gt; Strainu wrote:<br>
&gt;<br>
&gt;&gt; strainu@emily:~/core&gt; git review -f<br>
&gt;&gt; Creating a git remote called &quot;gerrit&quot; that maps to:<br>
&gt;&gt; =A0 =A0 =A0 =A0 ssh://<a href=3D"http://strainu-pdwPRaUiG6tP5deQkEKVHO46SIhDJjyZ@public.gmane.org=
rg:29418/pywikibot/core.git" target=3D"_blank">strainu-pdwPRaUiG6tP5deQkEKVHGD2FQJk+8+b@public.gmane.org=
:29418/pywikibot/core.git</a><br>
&gt;&gt; Your change was committed before the commit hook was installed.<br=
>
&gt;&gt; Amending the commit to add a gerrit change id.<br>
&gt;&gt;<br>
&gt;&gt; At this point I ended the transaction, as I was confused by the la=
st<br>
&gt;&gt; message: I was afraid the ChangeId would have changed, causing the=
<br>
&gt;&gt; patch to be attached to another review.<br>
&gt;&gt;<br>
&gt;&gt; I think git should not show this message if the change description=
<br>
&gt;&gt; already has a change id<br>
&gt;<br>
&gt; This message doesn&#39;t come from git. =A0It comes from the git-revie=
w<br>
&gt; tool (in git_review/cmd.py), so cc-ing the authors in case they<br>
&gt; have thoughts on that.<br>
<br>
</div>Thanks for clarifying that. I&#39;ll log a bug on launchpad then.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Strainu<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
_______________________________________________<br>
OpenStack-Infra mailing list<br>
<a href=3D"mailto:OpenStack-Infra-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org">OpenStack-Infra@list=
s.openstack.org</a><br>
<a href=3D"http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-in=
fra" target=3D"_blank">http://lists.openstack.org/cgi-bin/mailman/listinfo/=
openstack-infra</a><br>
</div></div></blockquote></div><br></div>

--f46d0443064e8984f404f032d735--


--===============3032141583287442013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
OpenStack-Infra mailing list
OpenStack-Infra-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org
http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-infra

--===============3032141583287442013==--
