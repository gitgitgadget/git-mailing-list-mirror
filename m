From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Fix checkout of large files to network shares 
	under Windows XP
Date: Fri, 30 Apr 2010 11:08:55 +0200
Message-ID: <j2tbdca99241004300208qf03f0a5u9e497119e3d42924@mail.gmail.com>
References: <4BCC5083.30801@gmail.com> <4BCCC05E.4030206@lsrfire.ath.cx>
	 <t2xbdca99241004200542ud4e8ea5azcad918c37bcacf1a@mail.gmail.com>
	 <4BCE134C.8090802@lsrfire.ath.cx> <4BD9E58E.8020406@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org, msysgit@googlegroups.com, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Johannes Sixt <j.sixt@viscovery.net>, 
	Junio C Hamano <gitster@pobox.com>, chris.gcode@googlemail.com
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: msysgit+bncCPLFkNe0FhCqvOreBBoEKuEfJw@googlegroups.com Fri Apr 30 11:09:22 2010
connect(): No such file or directory
Return-path: <msysgit+bncCPLFkNe0FhCqvOreBBoEKuEfJw@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ww0-f58.google.com ([74.125.82.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCPLFkNe0FhCqvOreBBoEKuEfJw@googlegroups.com>)
	id 1O7mDp-0007yG-Iw
	for gcvm-msysgit@m.gmane.org; Fri, 30 Apr 2010 11:09:21 +0200
Received: by wwb18 with SMTP id 18sf4461959wwb.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 30 Apr 2010 02:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:mime-version:received:received
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=Z/E0E7poYIWEx2yPSJBSopMMGEnW7bzU7BJJZSs97AI=;
        b=6yXf66Tlp48x53NQkUFpht8AGHpSKUW2cad1GovxRvSU8gFOb/X9yh69olhOxP7hrU
         ZOprZ7KO/5zNi03tdz1O7C+WS2ta4AqYwHJCdgO7D1iXD2XSvSF7860cCho7Bi+lrtYf
         fgJho/1SrVMhf/pXUXLmS03LwLnA0KdXBqFi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-authentication-results
         :x-original-sender:precedence:mailing-list:list-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type:content-transfer-encoding;
        b=RHM9/bEXmeSCl7t+EF8wSDgZcI04YaFRF1pDociW2vCmxHQ7w57jw0ZbcEyqcb4w3R
         nipTypyi1aYWTOr2acMMaXXKuZx6hlY/eoSBvaQvqyFQCZwm2ObUw1o8AyQJrE4Bfs1l
         dxZfTmPzpets1h+KoW3eBP2AxqLcpuXKHa3d8=
Received: by 10.223.58.16 with SMTP id e16mr2884053fah.6.1272618538737;
        Fri, 30 Apr 2010 02:08:58 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.35.68 with SMTP id o4ls21657657bkd.1.p; Fri, 30 Apr 2010 
	02:08:57 -0700 (PDT)
Received: by 10.204.49.76 with SMTP id u12mr503694bkf.15.1272618536819;
        Fri, 30 Apr 2010 02:08:56 -0700 (PDT)
Received: by 10.204.49.76 with SMTP id u12mr503693bkf.15.1272618536790;
        Fri, 30 Apr 2010 02:08:56 -0700 (PDT)
Received: from mail-bw0-f214.google.com (mail-bw0-f214.google.com [209.85.218.214])
        by gmr-mx.google.com with ESMTP id 17si229899bwz.15.2010.04.30.02.08.55;
        Fri, 30 Apr 2010 02:08:55 -0700 (PDT)
Received-SPF: pass (google.com: domain of sschuberth@gmail.com designates 209.85.218.214 as permitted sender) client-ip=209.85.218.214;
Received: by bwz6 with SMTP id 6so5452482bwz.19
        for <msysgit@googlegroups.com>; Fri, 30 Apr 2010 02:08:55 -0700 (PDT)
Received: by 10.204.84.5 with SMTP id h5mr6831078bkl.164.1272618535330; Fri, 
	30 Apr 2010 02:08:55 -0700 (PDT)
Received: by 10.204.55.132 with HTTP; Fri, 30 Apr 2010 02:08:55 -0700 (PDT)
In-Reply-To: <4BD9E58E.8020406@lsrfire.ath.cx>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of sschuberth@gmail.com designates 209.85.218.214 as permitted sender) 
	smtp.mail=sschuberth@gmail.com; dkim=pass (test mode) header.i=@gmail.com
X-Original-Sender: sschuberth@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146030>

On Thu, Apr 29, 2010 at 22:01, Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.=
cx> wrote:

> OK, I've been searching the web looking for documentation that explains
> the issue, but haven't found any watertight evidence.

Thanks Ren=C3=A9 for your research and for finally finishing the fix!

> It would be nice to reach chris.gcode, who originally reported this
> problem [5], and ask him to test. =C2=A0I couldn't find an email address =
on
> that webpage, though. =C2=A0His proposed patch there also used an upper l=
imit
> slightly below 32MB, but tried to compensate for capping by looping until
> the full requested size was written. =C2=A0That's not really needed.

I believe to have found his e-mail address on the msysGit mailing list
and put him on CC.

--=20
Sebastian Schuberth
