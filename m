From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: Re: [PATCHv2] Compile fix for MSVC
Date: Wed, 2 Nov 2011 00:33:07 +0100
Message-ID: <CAAH6HY81WNWu2Dj7RA+Rwm8avNzC7TyS0rMJwZECNZuuSO-WVQ@mail.gmail.com>
References: <1320088364-25916-1-git-send-email-vfr@lyx.org>
	<7vd3dcq4s5.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.1110311908240.1930@bonsai2>
	<CABPQNSaCRRRpEQPG1Mb4DovkMdQSBhHTm-i7y5M4iT+ndHX4XA@mail.gmail.com>
	<alpine.DEB.1.00.1111011332400.32316@s15462909.onlinehome-server.info>
	<CAAH6HY8WfOQQ4g54y7mriq6BKoJCWYsVPrQUTMndqpKdniLAtw@mail.gmail.com>
	<alpine.DEB.1.00.1111011738550.32316@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=20cf30780e5c105c1f04b0b4c7f2
Cc: ramsay@ramsay1.demon.co.uk, msysgit@googlegroups.com, 
	Karsten Blees <blees@dcon.de>, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Erik Faye-Lund <kusmabite@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncCKSyzO6oChChosL1BBoE8XOnxQ@googlegroups.com Wed Nov 02 01:39:28 2011
Return-path: <msysgit+bncCKSyzO6oChChosL1BBoE8XOnxQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qw0-f58.google.com ([209.85.216.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCKSyzO6oChChosL1BBoE8XOnxQ@googlegroups.com>)
	id 1RLOrY-0000fr-0Y
	for gcvm-msysgit@m.gmane.org; Wed, 02 Nov 2011 01:39:28 +0100
Received: by qabg27 with SMTP id g27sf839438qab.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 Nov 2011 17:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=w0dMnkSD2bSm1/KuqoK+4KIsvNv8cKtfGHK1jQYm+x8=;
        b=XP7kAxpgTQut1YYeL2A6o9kc/MBCsxs4OCB08A2oKovsW8piZBYlS18NO41iAjFawh
         qySR8m0QU6+Dzy8PySKUva4sW7JPMGRJVIvjNswI4/GtgJ8HTTpyONRMxnXBi6n5mv9E
         3Hkn08qdO8rkWbVnc+1ghyqwr2cS2b3iv6N+g=
Received: by 10.224.191.1 with SMTP id dk1mr583674qab.9.1320194337935;
        Tue, 01 Nov 2011 17:38:57 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.224.209.134 with SMTP id gg6ls445936qab.2.gmail; Tue, 01 Nov
 2011 17:38:57 -0700 (PDT)
Received: by 10.224.187.197 with SMTP id cx5mr603723qab.1.1320194337298;
        Tue, 01 Nov 2011 17:38:57 -0700 (PDT)
Received: by 10.224.137.13 with SMTP id u13msqat;
        Tue, 1 Nov 2011 16:33:08 -0700 (PDT)
Received: by 10.52.30.195 with SMTP id u3mr2295210vdh.3.1320190387844;
        Tue, 01 Nov 2011 16:33:07 -0700 (PDT)
Received: by 10.52.30.195 with SMTP id u3mr2295209vdh.3.1320190387834;
        Tue, 01 Nov 2011 16:33:07 -0700 (PDT)
Received: from mail-vw0-f48.google.com (mail-vw0-f48.google.com [209.85.212.48])
        by gmr-mx.google.com with ESMTPS id bu17si278932vdc.0.2011.11.01.16.33.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Nov 2011 16:33:07 -0700 (PDT)
Received-SPF: neutral (google.com: 209.85.212.48 is neither permitted nor denied by best guess record for domain of vfr@lyx.org) client-ip=209.85.212.48;
Received: by mail-vw0-f48.google.com with SMTP id 7so1962126vws.7
        for <msysgit@googlegroups.com>; Tue, 01 Nov 2011 16:33:07 -0700 (PDT)
Received: by 10.52.30.69 with SMTP id q5mr1740470vdh.110.1320190387182; Tue,
 01 Nov 2011 16:33:07 -0700 (PDT)
Received: by 10.220.189.68 with HTTP; Tue, 1 Nov 2011 16:33:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1111011738550.32316@s15462909.onlinehome-server.info>
X-Original-Sender: vfr@lyx.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com:
 209.85.212.48 is neither permitted nor denied by best guess record for domain
 of vfr@lyx.org) smtp.mail=vfr@lyx.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184608>

--20cf30780e5c105c1f04b0b4c7f2
Content-Type: text/plain; charset=ISO-8859-1

>
>
> > > Maybe if someone donates Jenkins resources, we could make an automatic
> > > branch in the future that has git.sln in it (similar to the 'html'
> > > branch in git.git).
> >
> > As long as this means to just run a not so complicated perl script, this
> > Could even be done in a commit hook.
>
> I actually was thinking about something automatic which does not require
> any of the busy msysGit developers to do something manual every once in a
> while.


I thought that a commit hook, was something automatic (iff the busy
developers
do commit something once in a while). I guess I can even set this up very
easily
(given push rights, otherwise it will involve manual labor again).



> > Just another question. How does the (msys)git community feel about
> > adding CMake support ? I can probably do that quite easily.
>
> There was somebody who strongly favored CMake over any other solution but
> was not willing to maintain it in the long run (also, I have to admit that
> I have had quite a few problems with CMake, but maybe I am just pampered
> by projects that Just Compile...)
>

The current way of generating a MSVC project is rather outdated, so the
worst
thing that can happen is that you have a different build system which is not
maintained. At least the CMake people will continue to improve on their
side.

Vincent

--20cf30780e5c105c1f04b0b4c7f2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote style=3D"margin: 0px 0px 0px 0.8ex; =
padding-left: 1ex; border-left-color: rgb(204, 204, 204); border-left-width=
: 1px; border-left-style: solid;" class=3D"gmail_quote"><div class=3D"im"><=
br>
&gt; &gt; Maybe if someone donates Jenkins resources, we could make an auto=
matic<br>
&gt; &gt; branch in the future that has git.sln in it (similar to the &#39;=
html&#39;<br>
&gt; &gt; branch in git.git).<br>
&gt;<br>
&gt; As long as this means to just run a not so complicated perl script, th=
is<br>
&gt; Could even be done in a commit hook.<br>
<br>
</div>I actually was thinking about something automatic which does not requ=
ire<br>
any of the busy msysGit developers to do something manual every once in a<b=
r>
while.</blockquote><div>=A0</div><div>I thought that a commit hook, was som=
ething automatic (iff the busy developers</div><div>do commit something onc=
e in a while). I guess I can even set this up very easily</div><div>(given=
=A0push rights, otherwise it will involve manual labor again).</div>
<div>=A0</div><div>=A0</div><blockquote style=3D"margin: 0px 0px 0px 0.8ex;=
 padding-left: 1ex; border-left-color: rgb(204, 204, 204); border-left-widt=
h: 1px; border-left-style: solid;" class=3D"gmail_quote"><div class=3D"im">
&gt; Just another question. How does the (msys)git community feel about<br>
&gt; adding CMake support ? I can probably do that quite easily.<br>
<br>
</div>There was somebody who strongly favored CMake over any other solution=
 but<br>
was not willing to maintain it in the long run (also, I have to admit that<=
br>
I have had quite a few problems with CMake, but maybe I am just pampered<br=
>
by projects that Just Compile...)<br></blockquote><div>=A0</div><div>The cu=
rrent way of generating a MSVC project is rather outdated, so the worst </d=
iv><div>thing that can happen is that you have a different build system whi=
ch is not</div>
<div>maintained.=A0At least the CMake people will continue to improve on th=
eir side.</div><div>=A0</div><div>Vincent</div></div>

--20cf30780e5c105c1f04b0b4c7f2--
