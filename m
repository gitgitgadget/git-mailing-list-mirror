From: bill lam <cbill.lam@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.6.1
Date: Thu, 25 Dec 2008 22:09:12 +0800
Message-ID: <20081225140912.GA7110@b2j>
References: <7v7i5odams.fsf@gitster.siamese.dyndns.org> <20081225100033.GA8451@b2j> <7v3agca7fp.fsf@gitster.siamese.dyndns.org> <20081225102527.GB8451@b2j> <49537197.1000805@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 25 15:10:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFqv9-0005HC-Kv
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 15:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbYLYOJT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Dec 2008 09:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbYLYOJT
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Dec 2008 09:09:19 -0500
Received: from ti-out-0910.google.com ([209.85.142.190]:54818 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbYLYOJS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2008 09:09:18 -0500
Received: by ti-out-0910.google.com with SMTP id b6so6688164tic.23
        for <git@vger.kernel.org>; Thu, 25 Dec 2008 06:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PRFvKXZTpgVR9+Aa/6BGfQcoGqGufDfaqFesu6psFgM=;
        b=wF9DJ4Y0lZZ6Nx0t/m/OyNs/Arsai91uqyq9ypGwbNQbbokqs2nMnF600snYWGrCyb
         pVkxENYaSnoetb1Wfw/uFJTqoxI3GKkpezT+EoahkuDCbEnhtWwAChfg78qo3+VLUZYo
         aGiJwVWDfopfsUkZDp81uq4SADLl/BMQvpUTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=mQrIc7RuluiVAZAjUunu2Y5HwPYmzfa5cStKbDddKOFeRGiAKQnCdClVv0wU2m0qSF
         COp/RzAvyGA/MKh4HHf2zgLB5tAm56yyTWdZ8BhWN5VLSGnDSvgk86lT3I0G+K5u0+ub
         Yp5u1QUesfQ8fmMZGktRPmuY7hB1LvePJANIM=
Received: by 10.110.31.5 with SMTP id e5mr3643314tie.32.1230214157024;
        Thu, 25 Dec 2008 06:09:17 -0800 (PST)
Received: from localhost (n218103235162.netvigator.com [218.103.235.162])
        by mx.google.com with ESMTPS id y3sm1277632tia.20.2008.12.25.06.09.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Dec 2008 06:09:15 -0800 (PST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <49537197.1000805@lsrfire.ath.cx>
User-Agent: Mutt/1.5.18 (2008-11-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103902>

On Thu, 25 Dec 2008, Ren=C3=A9 Scharfe wrote:
> configure seems to be confused.  What happens if you take it out of t=
he =20
> equation, i.e. run the following commands?
>
> 	$ make distclean
> 	$ make prefix=3D/usr

Thanks Ren=C3=A9!  I followed your installation, deleted the old config=
ure,
and it compiled successfully,

Happy holidays to everyone on mailing list!

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9104 =E6=9D=8E=E7=99=BD  =E5=A4=9C=E6=B3=8A=E7=89=9B=E6=
=B8=9A=E6=87=B7=E5=8F=A4
    =E7=89=9B=E6=B8=9A=E8=A5=BF=E6=B1=9F=E5=A4=9C  =E9=9D=92=E5=A4=A9=E7=
=84=A1=E7=89=87=E9=9B=B2  =E7=99=BB=E8=88=9F=E6=9C=9B=E7=A7=8B=E6=9C=88=
  =E7=A9=BA=E6=86=B6=E8=AC=9D=E5=B0=87=E8=BB=8D
    =E4=BD=99=E4=BA=A6=E8=83=BD=E9=AB=98=E8=A9=A0  =E6=96=AF=E4=BA=BA=E4=
=B8=8D=E5=8F=AF=E8=81=9E  =E6=98=8E=E6=9C=9D=E6=8C=82=E5=B8=86=E5=B8=AD=
  =E6=A5=93=E8=91=89=E8=90=BD=E7=B4=9B=E7=B4=9B
