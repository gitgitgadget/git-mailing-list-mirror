From: bill lam <cbill.lam@gmail.com>
Subject: Re: does git config get any side effect other than changing
	.gitconfig
Date: Fri, 23 Jan 2009 11:41:57 +0800
Message-ID: <20090123034157.GD6931@b2j>
References: <20090123031210.GB6931@b2j> <200901222126.46964.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 04:43:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQCx8-0000v8-L6
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 04:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754964AbZAWDmG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jan 2009 22:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754093AbZAWDmF
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 22:42:05 -0500
Received: from ti-out-0910.google.com ([209.85.142.184]:25568 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745AbZAWDmE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2009 22:42:04 -0500
Received: by ti-out-0910.google.com with SMTP id b6so3146664tic.23
        for <git@vger.kernel.org>; Thu, 22 Jan 2009 19:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sfw2GuyPqWUL/KeT6sCLbxBe907FdfPE8Udv++tnRuo=;
        b=C31HnL0AWM8US0lNbrC9Zbt744qJiszOg2Aoiv+EPHHQ5MV1o4/3s3TNy3BRr9nUcZ
         5eA/wtFW9P89xBC7k3AaWToRLEs7RuqN1Gci1Zz0ftXipoqr1QB73+qfJVzkxGwRua50
         AFs0tHfOGcqM44J0fYmiQrryay/7mTH2LoPOU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=dbSvuHB8yJS76OL+A10NcECBk30yN9uC3eeVfw051sMcCsgdgmpGIrs+HiQyGjlxoq
         v/sB+Uox+qf7vP4AYYNmsYv/DejWl2oJnAwaQZXZEdB19zQsL1/Exg2xsMtY8UQ/7afu
         PBTOvXu2GA2EYMZYrc4k2MxBIaZnfwJ/g09QA=
Received: by 10.110.63.6 with SMTP id l6mr206366tia.50.1232682121836;
        Thu, 22 Jan 2009 19:42:01 -0800 (PST)
Received: from localhost (n218103237232.netvigator.com [218.103.237.232])
        by mx.google.com with ESMTPS id i6sm2175646tid.16.2009.01.22.19.41.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Jan 2009 19:42:00 -0800 (PST)
Mail-Followup-To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200901222126.46964.bss@iguanasuicide.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106829>

On Thu, 22 Jan 2009, Boyd Stephen Smith Jr. wrote:
> >Suppose I got several git repositories to maintain, instead of using
> >command git config [--global] again and again.  Can I call up a text
> >editor to edit .git/config or .gitconfig manually, or just copy from
> >another .gitconfig ?
>=20
> Yes.  Absolutely.

Thanks for confirmation.  I realised that the subject is in the
opposite tone to the message body.

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9157 =E6=9D=8E=E5=95=86=E9=9A=B1  =E9=A2=A8=E9=9B=A8
    =E6=B7=92=E6=B6=BC=E5=AF=B6=E5=8A=8D=E7=AF=87  =E7=BE=88=E6=B3=8A=E6=
=AC=B2=E7=AA=AE=E5=B9=B4  =E9=BB=83=E8=91=89=E4=BB=8D=E9=A2=A8=E9=9B=A8=
  =E9=9D=92=E6=A8=93=E8=87=AA=E7=AE=A1=E7=B5=83
    =E6=96=B0=E7=9F=A5=E9=81=AD=E8=96=84=E4=BF=97  =E8=88=8A=E5=A5=BD=E9=
=9A=94=E8=89=AF=E7=B7=A3  =E5=BF=83=E6=96=B7=E6=96=B0=E8=B1=90=E9=85=92=
  =E9=8A=B7=E6=84=81=E6=96=97=E5=B9=BE=E5=8D=83
