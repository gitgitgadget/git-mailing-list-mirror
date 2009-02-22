From: bill lam <cbill.lam@gmail.com>
Subject: Re: pre-commit hook
Date: Sun, 22 Feb 2009 22:13:59 +0800
Message-ID: <20090222141359.GA7403@b2j>
References: <20090220091127.GA7415@b2j> <7v63j5t6r3.fsf@gitster.siamese.dyndns.org> <20090221035748.GC7409@b2j> <499FE579.1050700@drmicha.warpmail.net> <20090222105838.GB8029@b2j> <fabb9a1e0902220317m3f241bf4y118c5dee4cf0c06b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 15:15:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbF7I-0001Tx-GD
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 15:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbZBVOOI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2009 09:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752414AbZBVOOG
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 09:14:06 -0500
Received: from ti-out-0910.google.com ([209.85.142.190]:23182 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298AbZBVOOF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 09:14:05 -0500
Received: by ti-out-0910.google.com with SMTP id d10so1150535tib.23
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 06:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=X00+F7wpjHd2r3ECSaF7nnchOOCra952YmcyZlAxot8=;
        b=YGpQDOx/qDB3m+J20d/miqAp6KrzQVr4EEY6Q1g/ywsIlrHfvduz3NtCEvQi630n/e
         sUK50Fa3DsqqsJNtY3XIXZ/cXEIefwqGFcYV5/mO8k48LrYDSQnxeHkTAp+1SWtPH3xJ
         2rxX6JH3v5C2qY2/T6exbfZmXdBYkfeamiBxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=UDIocpESXSrM9y1mrr4hpcEXdwbM4bUB8b+mCnonTl7POgZ2wYrz6LfXx0DB01FK5R
         j1CdzfhKr+v4nUbzXkwmDO+IbEuguEMA11FiRfk0UJj4Wvas0rXD0MbjsKPY9t/Y1QyI
         uppJJUmIDSM+jsJj1Yzb6EX5SBZnlFuA974ME=
Received: by 10.110.69.5 with SMTP id r5mr4253328tia.36.1235312043272;
        Sun, 22 Feb 2009 06:14:03 -0800 (PST)
Received: from localhost (n219078081066.netvigator.com [219.78.81.66])
        by mx.google.com with ESMTPS id y5sm4840061tia.37.2009.02.22.06.14.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Feb 2009 06:14:02 -0800 (PST)
Mail-Followup-To: Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <fabb9a1e0902220317m3f241bf4y118c5dee4cf0c06b@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111009>

On Sun, 22 Feb 2009, Sverre Rabbelier wrote:
> Have a look at the output of `git --exec-path`.

Thanks, Sverre.

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9021 =E7=8E=8B=E6=98=8C=E9=BD=A1  =E5=90=8C=E5=BE=9E=E5=
=BC=9F=E5=8D=97=E9=BD=8B=E7=BF=AB=E6=9C=88=E6=86=B6=E5=B1=B1=E9=99=B0=E5=
=B4=94=E5=B0=91=E5=BA=9C
    =E9=AB=98=E8=87=A5=E5=8D=97=E9=BD=8B=E6=99=82  =E9=96=8B=E5=B8=B7=E6=
=9C=88=E5=88=9D=E5=90=90  =E6=B8=85=E8=BC=9D=E6=B7=A1=E6=B0=B4=E6=9C=A8=
  =E6=BC=94=E6=BC=BE=E5=9C=A8=E7=AA=97=E6=88=B6  =E8=8B=92=E8=8B=92=E5=B9=
=BE=E7=9B=88=E8=99=9B  =E6=BE=84=E6=BE=84=E8=AE=8A=E4=BB=8A=E5=8F=A4
    =E7=BE=8E=E4=BA=BA=E6=B8=85=E6=B1=9F=E7=95=94  =E6=98=AF=E5=A4=9C=E8=
=B6=8A=E5=90=9F=E8=8B=A6  =E5=8D=83=E9=87=8C=E5=85=B6=E5=A6=82=E4=BD=95=
  =E5=BE=AE=E9=A2=A8=E5=90=B9=E8=98=AD=E6=9D=9C
