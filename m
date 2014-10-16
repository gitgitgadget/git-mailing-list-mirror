From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] core.filemode may need manual action
Date: Thu, 16 Oct 2014 21:47:16 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1410162146140.990@s15462909.onlinehome-server.info>
References: <54401CAD.4090606@web.de> <54401F38.7080101@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>, 
    git@vger.kernel.org, git-win-sdk@googlegroups.com, 
    msysGit <msysgit@googlegroups.com>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: msysgit+bncBCZPH74Q5YNRBSOBQCRAKGQEEB3VBGA@googlegroups.com Thu Oct 16 21:47:24 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBSOBQCRAKGQEEB3VBGA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f56.google.com ([74.125.83.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBSOBQCRAKGQEEB3VBGA@googlegroups.com>)
	id 1Xer19-0004ny-If
	for gcvm-msysgit@m.gmane.org; Thu, 16 Oct 2014 21:47:23 +0200
Received: by mail-ee0-f56.google.com with SMTP id e49sf420953eek.21
        for <gcvm-msysgit@m.gmane.org>; Thu, 16 Oct 2014 12:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=/Psj7xouQL9eHO7q0FNNweqq9QaxCwpr5UxVmW/7o2E=;
        b=YVPwNauOFYAFOwp+16wzC7cS+sqEOCuh/b8lO1+EWv6OyvKmBD4k9wwwS9g8SIVdhr
         QjNlapZZGTsW5ru/UloiS2vZn24r3gTyLpKP7RHvYGtsJ58o7KwXaqZ4hjZJXwEOTCqp
         A2Lt7mxx5k9sQ0mHmDUX4WXxlF/JGoT/bXqUACyQtpA2pfq9mgt5cZtxQgL6mMw7DOvl
         4w+Zbce1tS06EnfEX6fH7SS/dLCo5m/iFBNBcYLgoleqa+grbC++6TmXjPEU92YeJZKH
         ruAxWKR5ZH176wBNDfCCOm9UTKtHwK753nXWGy5ERyizNQMUM21nJ1uepbqKyVc/7my8
         bE3g==
X-Received: by 10.152.2.193 with SMTP id 1mr28868law.15.1413488843264;
        Thu, 16 Oct 2014 12:47:23 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.45.101 with SMTP id l5ls177221lam.103.gmail; Thu, 16 Oct
 2014 12:47:21 -0700 (PDT)
X-Received: by 10.152.29.134 with SMTP id k6mr5029lah.9.1413488841522;
        Thu, 16 Oct 2014 12:47:21 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.19])
        by gmr-mx.google.com with ESMTPS id rb5si2070057lbb.0.2014.10.16.12.47.21
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Oct 2014 12:47:21 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.19 as permitted sender) client-ip=212.227.15.19;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MILxX-1XizkY0htH-004Bs6;
 Thu, 16 Oct 2014 21:47:17 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <54401F38.7080101@virtuell-zuhause.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:GB1qMINl52LXs45u6zX9wObAshHHSfHLA64xJ5nPx0q7cYJSgPv
 zlSuzsJBPwfPlbAZAWzx6h9AZeNMVHUT1V7eE/Pa/mvkAxJhPq15x5nuOIAnqGIRVeqaPAT
 FeEobBogx2OjZSZHExo9lISr50IDEyQgK6NC8A499BnSjPUy5yYmELQMCCJOiYPa0uV5Zbz
 qL/CzJ4CklHv8S9f2mgMA==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.19 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>

Hi,

On Thu, 16 Oct 2014, Thomas Braun wrote:

> Am 16.10.2014 um 21:29 schrieb Torsten B=C3=B6gershausen:
> > core.filemode is set automatically when a repo is created.
> > But when a repo is exported via CIFS or cygwin is mixed with Git for Wi=
ndows
> > core.filemode may better be set manually to false.
> > Update and improve the documentation.
> >=20
> > Helped-by: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> > ---
> >=20
> > Does this reflect the discussion via email ?
> > Or is more tweaking needed ?
> >=20
> >=20
> >  Documentation/config.txt | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index 4333636..b4fea43 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -204,8 +204,23 @@ advice.*::
> >  --
> > =20
> >  core.fileMode::
> > -	If false, the executable bit differences between the index and
> > -	the working tree are ignored; useful on broken filesystems like FAT.
> > +	Tells Git if the executable bit of files in the working tree
> > +	is to be honored.
> > +
> > +	Some filesystems lose the executable bit when a file that is
> > +	marked as executable is checked out, or checks out an
> > +	non-executable file with executable bit on.  "git init" and
> > +	"git clone" probe the filesystem to see if it records
> > +	executable bit correctly when they create a new repository
> > +	and this variable is automatically set as necessary.
> > +
> > +	A repository, however, may be on a filesystem that records
> > +	the filemode correctly, and this variable is set to 'true'
> > +	when created, but later may be made accessible from another
> > +	environment that loses the filemode (e.g. exporting ext4 via
> > +	CIFS mount, visiting a Cygwin managed repository with
> > +	MsysGit).  In such a case, it may be necessary to set this
> > +	variable to 'false'.
> >  	See linkgit:git-update-index[1].
> >  +
> >  The default is true, except linkgit:git-clone[1] or linkgit:git-init[1=
]
> >=20
>=20
> [CC'ing msysgit aka git-for-windows/sdk for input]
>=20
> I'm not really happy with the term MsysGit here.
> Would it be too bold to say
> [... ] visiting a Cygwin managed repository with Git for Windows.
> ?

I agree that msysGit is the wrong term. Not only is it about to be
replaced by the Git for Windows SDK, it is *actively* wrong because
msysGit is just the *development environment* to build Git for Windows.
Most users do *not* need msysGit at all.

Ciao,
Dscho

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
Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
