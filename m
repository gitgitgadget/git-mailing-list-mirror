From: =?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Highlevel (but simple to implement) commands provided
 by default for git
Date: Wed, 29 May 2013 15:05:52 -0300
Message-ID: <CAJri6_vdN6-z0xvS2PrrdcesStqRKt7ve4dp8S2np3v=_S_ifg@mail.gmail.com>
References: <f611150e-a12a-47f6-97f0-8aaff3045338@googlegroups.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=001a11c36924df693504dddf3d71
To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
X-From: git-users+bncBDUJVQ6N5UERBKEHTGGQKGQE5L5XULI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Wed May 29 20:06:35 2013
Return-path: <git-users+bncBDUJVQ6N5UERBKEHTGGQKGQE5L5XULI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-fa0-f61.google.com ([209.85.161.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBDUJVQ6N5UERBKEHTGGQKGQE5L5XULI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1Uhkle-0005CR-LU
	for gcggu-git-users@m.gmane.org; Wed, 29 May 2013 20:06:34 +0200
Received: by mail-fa0-f61.google.com with SMTP id w1sf1639766faw.6
        for <gcggu-git-users@m.gmane.org>; Wed, 29 May 2013 11:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:x-original-sender
         :x-original-authentication-results:reply-to:precedence:mailing-list
         :list-id:x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=SIdg9PLVBVv42rRkRlgXATnRuzdJwkf4OcEg6JVKfpE=;
        b=eWfcejojG4WO+YUs0iVuvhH0U1T1Zh+3K5zstvVxUHZ8lorIGJQ/BiIBkkSnkCzhnQ
         UefFuLhW3oDNu2F4QF5YHagLm44n77v1ivXC64JHYQHXbCUcudPfGc4c/nj7leUd2GML
         Xxcj0YTm2vjtcIJPeUhWTxsCWuO2g6fuw3/4khKxSsT61Cj5QzcRiYZZ90rXaM1QRhyg
         LB1lDDLNLJhGzSipPvMoKAtra7uWwgacimbghkQ6GtZZrjDUjRSYIGok2IAkHihExtG8
         O3hAqTNZ7pS+vMf/yc8jEsFHSbcRMfH0tjzxQec5VdA2CQF68L1zctAU8JfDuwmYSsq0
         v0BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-beenthere:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:x-original-sender
         :x-original-authentication-results:reply-to:precedence:mailing-list
         :list-id:x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=SIdg9PLVBVv42rRkRlgXATnRuzdJwkf4OcEg6JVKfpE=;
        b=biejzM6otHsqz7J09Aac/B4mS0BRbh/heXgrovGYbwgxMkrHxXs14vgSY/G0Ghvsvt
         DRExQZoafh/BX3unIGX7/sM647x9vCuTthi17dWJmTDkP/lpGmXlRiRzXryH7Jl/RO3R
         Ih5+61ulI/1er1/N7eCqxRnXFEcXFdPpdcXyG+2QJ1hpYq3dOixvTJ1twUeshpUAU+zr
         4KGEHvuJkAFTqIKpcZwfmNmsIllH3AYEKITqDLMd8GvnAB1EzpstlD8KRWRzmddKBtyp
         kWXIemzLNoJlGkZWU8iA213M4TrHn6vYGJvrMzd8uTcQpOdzh8Nyegd+IZNb+ST0m//Y
         ULYA==
X-Received: by 10.180.9.66 with SMTP id x2mr1655584wia.4.1369850794190;
        Wed, 29 May 2013 11:06:34 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.180.211.169 with SMTP id nd9ls1611337wic.1.canary; Wed, 29 May
 2013 11:06:32 -0700 (PDT)
X-Received: by 10.204.70.76 with SMTP id c12mr476679bkj.5.1369850792603;
        Wed, 29 May 2013 11:06:32 -0700 (PDT)
Received: from mail-lb0-f171.google.com (mail-lb0-f171.google.com [209.85.217.171])
        by gmr-mx.google.com with ESMTPS id cm16si3171778bkb.0.2013.05.29.11.06.32
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 May 2013 11:06:32 -0700 (PDT)
Received-SPF: pass (google.com: domain of brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.217.171 as permitted sender) client-ip=209.85.217.171;
Received: by mail-lb0-f171.google.com with SMTP id v20so9393399lbc.30
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Wed, 29 May 2013 11:06:32 -0700 (PDT)
X-Received: by 10.112.89.168 with SMTP id bp8mr2149418lbb.50.1369850792337;
 Wed, 29 May 2013 11:06:32 -0700 (PDT)
Received: by 10.114.39.104 with HTTP; Wed, 29 May 2013 11:05:52 -0700 (PDT)
In-Reply-To: <f611150e-a12a-47f6-97f0-8aaff3045338-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
X-Original-Sender: brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.217.171 as
 permitted sender) smtp.mail=brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;       dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact git-users+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <git-users.googlegroups.com>
X-Google-Group-Id: 934228491576
List-Post: <http://groups.google.com/group/git-users/post?hl=en-US>, <mailto:git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en-US>, <mailto:git-users+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/git-users?hl=en-US>
Sender: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/git-users/subscribe?hl=en-US>, <mailto:git-users+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/git-users/subscribe?hl=en-US>,
 <mailto:googlegroups-manage+934228491576+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225856>

--001a11c36924df693504dddf3d71
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2013 at 8:23 AM, Br=E1ulio Bhavamitra <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=
wrote:

> Hello all,
>
> One of the things I note about git is that is provides mostly low-level
> and strictly necessary commands.
> Many highlevel commands are then implemented as alias by users, after a
> deep search on the internet.
>
> Adding highlevel commands, even though it could be implemented by a simpl=
e
> alias, would put git in another level
> of user experience and create a new standard for newbie users.
> What git developers think about this?
>
> I have, as many other users, an enormous .gitconfig. I paste here some
> highlevel commands of it, according to my judgement.
> Mercurial provides many of these highlevel commands.
>
>   root =3D rev-parse --show-toplevel
>
>  upstream =3D !git for-each-ref --format=3D'%(upstream:short)' $(git symb=
olic-ref -q HEAD)
>  upstream-remote =3D !git upstream | sed -e 's/\\/.*$//g'
>
>  out =3D !git fetch `git upstream-remote` && git l `git upstream`..HEAD
>  in =3D pull --dry-run
>
>
>  unmerged =3D !git ls-files --unmerged | cut -f2 | uniq
>  untracked =3D ls-files --other --exclude-standard
>  staged =3D ls-files --staged
>  modified =3D ls-files --modified
>  deleted =3D ls-files --deleted
>
>
>   head =3D !git l -1
>   current =3D rev-parse --abbrev-ref HEAD
>
> Source:
> https://github.com/brauliobo/gitconfig/blob/master/configs/.gitconfig
>
> regards,
> br=E1ulio
>
> --
> You received this message because you are subscribed to the Google Groups
> "Git for human beings" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
> For more options, visit https://groups.google.com/groups/opt_out.
>
>
>

--=20
You received this message because you are subscribed to the Google Groups "=
Git for human beings" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.



--001a11c36924df693504dddf3d71
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br></div><div class=3D"gmail_extra"><br><br><div class=3D=
"gmail_quote">On Wed, May 29, 2013 at 8:23 AM, Br=E1ulio Bhavamitra <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">bra=
uliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hello all,<div><br></div><div>One of the thi=
ngs I note about git is that is provides mostly low-level and strictly nece=
ssary commands.</div>

<div>Many highlevel commands are then implemented as alias by users, after =
a deep search on the internet.</div><div><br></div><div>Adding highlevel co=
mmands, even though it could be implemented by a simple alias, would put gi=
t in another level</div>

<div>of user experience and create a new standard for newbie users.</div><d=
iv>What git developers think about this?</div><div><br></div><div>I have, a=
s many other users, an enormous .gitconfig. I paste here some highlevel com=
mands of it, according to my judgement.</div>

<div>Mercurial provides many of these highlevel commands.<br></div><div><br=
></div><div><span style=3D"color:rgb(51,51,51);font-family:Consolas,&#39;Li=
beration Mono&#39;,Courier,monospace;font-size:12px;line-height:18px;white-=
space:pre-wrap">=A0=A0</span><span style=3D"color:rgb(0,128,128);font-famil=
y:Consolas,&#39;Liberation Mono&#39;,Courier,monospace;font-size:12px;line-=
height:18px;white-space:pre-wrap">root</span><span style=3D"color:rgb(51,51=
,51);font-family:Consolas,&#39;Liberation Mono&#39;,Courier,monospace;font-=
size:12px;line-height:18px;white-space:pre-wrap"> </span><span style=3D"fon=
t-weight:bold;color:rgb(51,51,51);font-family:Consolas,&#39;Liberation Mono=
&#39;,Courier,monospace;font-size:12px;line-height:18px;white-space:pre-wra=
p">=3D</span><span style=3D"color:rgb(51,51,51);font-family:Consolas,&#39;L=
iberation Mono&#39;,Courier,monospace;font-size:12px;line-height:18px;white=
-space:pre-wrap"> </span><span style=3D"color:rgb(221,17,68);font-family:Co=
nsolas,&#39;Liberation Mono&#39;,Courier,monospace;font-size:12px;line-heig=
ht:18px;white-space:pre-wrap">rev-parse --show-toplevel</span><br>

</div><div><span style=3D"color:rgb(221,17,68);font-family:Consolas,&#39;Li=
beration Mono&#39;,Courier,monospace;font-size:12px;line-height:18px;white-=
space:pre-wrap"><pre style=3D"font-family:Consolas,&#39;Liberation Mono&#39=
;,Courier,monospace;color:rgb(51,51,51)">

<div style=3D"padding-left:10px">=A0<span style=3D"color:rgb(0,128,128)">up=
stream</span> <span style=3D"font-weight:bold">=3D</span> <span style=3D"co=
lor:rgb(221,17,68)">!git for-each-ref --format=3D&#39;%(upstream:short)&#39=
; $(git symbolic-ref -q HEAD)</span></div>

<div style=3D"padding-left:10px"><span style=3D"color:rgb(221,17,68)"> upst=
ream-remote =3D !git upstream | sed -e &#39;s/\\/.*$//g&#39;</span></div><d=
iv style=3D"padding-left:10px"><br></div><div style=3D"padding-left:10px">=
=A0<span style=3D"color:rgb(0,128,128)">out</span> <span style=3D"font-weig=
ht:bold">=3D</span> <span style=3D"color:rgb(221,17,68)">!git fetch `git up=
stream-remote` &amp;&amp; git l `git upstream`..HEAD</span></div>

<div style=3D"padding-left:10px"><span style=3D"color:rgb(221,17,68)"> in =
=3D pull --dry-run</span></div></pre></span></div><div><br></div><div><pre =
style=3D"font-size:12px;font-family:Consolas,&#39;Liberation Mono&#39;,Cour=
ier,monospace;color:rgb(51,51,51);line-height:18px">

<div style=3D"padding-left:10px">=A0<span style=3D"color:rgb(0,128,128)">un=
merged</span> <span style=3D"font-weight:bold">=3D</span> <span style=3D"co=
lor:rgb(221,17,68)">!git ls-files --unmerged | cut -f2 | uniq</span></div><=
div style=3D"padding-left:10px">

<span style=3D"color:rgb(221,17,68)"> untracked =3D ls-files --other --excl=
ude-standard</span></div><div style=3D"padding-left:10px"><span style=3D"co=
lor:rgb(221,17,68)"> staged =3D ls-files --staged</span></div><div style=3D=
"padding-left:10px">

<span style=3D"color:rgb(221,17,68)"> modified =3D ls-files --modified</spa=
n></div><div style=3D"padding-left:10px"><span style=3D"color:rgb(221,17,68=
)"> deleted =3D ls-files --deleted</span></div></pre></div><div><br></div><=
div><span style=3D"color:rgb(51,51,51);font-family:Consolas,&#39;Liberation=
 Mono&#39;,Courier,monospace;font-size:12px;line-height:18px;white-space:pr=
e-wrap">=A0=A0</span><span style=3D"color:rgb(0,128,128);font-family:Consol=
as,&#39;Liberation Mono&#39;,Courier,monospace;font-size:12px;line-height:1=
8px;white-space:pre-wrap">head</span><span style=3D"color:rgb(51,51,51);fon=
t-family:Consolas,&#39;Liberation Mono&#39;,Courier,monospace;font-size:12p=
x;line-height:18px;white-space:pre-wrap"> </span><span style=3D"font-weight=
:bold;color:rgb(51,51,51);font-family:Consolas,&#39;Liberation Mono&#39;,Co=
urier,monospace;font-size:12px;line-height:18px;white-space:pre-wrap">=3D</=
span><span style=3D"color:rgb(51,51,51);font-family:Consolas,&#39;Liberatio=
n Mono&#39;,Courier,monospace;font-size:12px;line-height:18px;white-space:p=
re-wrap"> </span><span style=3D"color:rgb(221,17,68);font-family:Consolas,&=
#39;Liberation Mono&#39;,Courier,monospace;font-size:12px;line-height:18px;=
white-space:pre-wrap">!git l -1</span><br>

</div><div><span style=3D"color:rgb(221,17,68);font-family:Consolas,&#39;Li=
beration Mono&#39;,Courier,monospace;font-size:12px;line-height:18px;white-=
space:pre-wrap"><span style=3D"color:rgb(51,51,51)"> =A0</span><span style=
=3D"color:rgb(0,128,128)">current</span><span style=3D"color:rgb(51,51,51)"=
> </span><span style=3D"font-weight:bold;color:rgb(51,51,51)">=3D</span><sp=
an style=3D"color:rgb(51,51,51)"> </span><span>rev-parse --abbrev-ref HEAD<=
/span><br>

</span></div><div><br></div><div>Source:=A0<a href=3D"https://github.com/br=
auliobo/gitconfig/blob/master/configs/.gitconfig" target=3D"_blank">https:/=
/github.com/brauliobo/gitconfig/blob/master/configs/.gitconfig</a></div><di=
v>

<br></div><div>regards,</div><div>br=E1ulio</div><span class=3D"HOEnZb"><fo=
nt color=3D"#888888">

<p></p>

-- <br>
You received this message because you are subscribed to the Google Groups &=
quot;Git for human beings&quot; group.<br>
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:git-users%2Bunsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" target=
=3D"_blank">git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br>
For more options, visit <a href=3D"https://groups.google.com/groups/opt_out=
" target=3D"_blank">https://groups.google.com/groups/opt_out</a>.<br>
=A0<br>
=A0<br>
</font></span></blockquote></div><br></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;Git for human beings&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org<br />
For more options, visit <a href=3D"https://groups.google.com/groups/opt_out=
">https://groups.google.com/groups/opt_out</a>.<br />
&nbsp;<br />
&nbsp;<br />

--001a11c36924df693504dddf3d71--
