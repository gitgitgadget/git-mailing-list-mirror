From: bill lam <cbill.lam@gmail.com>
Subject: Re: what are plumbing and porcelain
Date: Wed, 21 Jan 2009 14:07:26 +0800
Message-ID: <20090121060726.GE6970@b2j>
References: <20090121052741.GC6970@b2j> <200901202350.15011.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 07:09:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPWGo-0004ju-N5
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 07:08:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbZAUGHe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2009 01:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbZAUGHe
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 01:07:34 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:60094 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbZAUGHd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 01:07:33 -0500
Received: by ti-out-0910.google.com with SMTP id b6so2756652tic.23
        for <git@vger.kernel.org>; Tue, 20 Jan 2009 22:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MB4eXVt2ANfMcIMcafUZE+ZaWe+zUdI0wFbup178IZc=;
        b=OfZqrcy7MCInK0Do+OMYOjSe0UU8z2l84fPq7OoUTdinT/bKpfc3R4Cqm2F2uRDhiD
         43tN93fnEhDIE1hDHi5sBHqf3zfmW7GLv5bPhdtI3wnKwySZPV1cEUz6eJSmgboVz9Ur
         ulf6/+Aq58zAQFdm4elyw3PSMHL1+TQyzE960=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=wa0yeFRlv83NwgEaTAY6tV03IwWEzXaLZDEZ4jhLGS757z0PBjotx0szgRvFXEeuDW
         SpTyJ7DaYhY7QYPfIPxL52O98X9QeHr1qh4kobHb2tKuL2TMQijbmGZ6vMOHeJJLi3El
         dBN8QSQHXf+c4RVCZi6uAZ+POhB/CeiJLQkaY=
Received: by 10.110.109.19 with SMTP id h19mr146286tic.45.1232518052213;
        Tue, 20 Jan 2009 22:07:32 -0800 (PST)
Received: from localhost (pcd589144.netvigator.com [218.102.121.144])
        by mx.google.com with ESMTPS id d7sm108259tib.37.2009.01.20.22.07.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Jan 2009 22:07:30 -0800 (PST)
Mail-Followup-To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200901202350.15011.bss@iguanasuicide.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106570>

On Tue, 20 Jan 2009, Boyd Stephen Smith Jr. wrote:
> "plumbing" are the commands that do low-level operations.  Generally,=
=20
> end-users won't have to use them much, if at all, but they=20

I can see now gitk should probably be porcelain. But how about
commands such as git add or git rebase used with either the -i switch
on or off?

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9299 =E6=9D=8E=E5=95=86=E9=9A=B1  =E5=AF=84=E4=BB=A4=E7=
=8B=90=E9=83=8E=E4=B8=AD
    =E5=B5=A9=E9=9B=B2=E7=A7=A6=E6=A8=B9=E4=B9=85=E9=9B=A2=E5=B1=85  =E9=
=9B=99=E9=AF=89=E8=BF=A2=E8=BF=A2=E4=B8=80=E7=B4=99=E7=AD=86  =E4=BC=91=
=E5=95=8F=E6=A2=81=E5=9C=92=E8=88=8A=E8=B3=93=E5=AE=A2  =E8=8C=82=E9=99=
=B5=E7=A7=8B=E9=9B=A8=E7=97=85=E7=9B=B8=E5=A6=82
