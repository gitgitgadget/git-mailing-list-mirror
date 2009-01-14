From: bill lam <cbill.lam@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.13
Date: Thu, 15 Jan 2009 07:24:56 +0800
Message-ID: <20090114232456.GA6937@b2j>
References: <20090113233643.GA28898@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Thu Jan 15 00:26:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNF81-0006YF-QE
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 00:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757637AbZANXZI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jan 2009 18:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757573AbZANXZH
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 18:25:07 -0500
Received: from ti-out-0910.google.com ([209.85.142.184]:48382 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757200AbZANXZE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 18:25:04 -0500
Received: by ti-out-0910.google.com with SMTP id b6so401575tic.23
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 15:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=w61hwadEKv7uCthJ8jU3cZRxHUlQzKTRF+vAoJn/khA=;
        b=hF8wkh4EZeKSGL3/UENJG13xcN2/pF7WtLD/DWFhsIpBDhJNP8H7C2Dj9q1Ta8K1F8
         UlOssboMtAMZFqtSeF6Lvf5VYFG4WUvKztYhI/Qs1vLCNAI8gyijR2JQwwIAdQghl1RT
         p6q8k1NJguApkvxEs61HnMv18g/i3YpDxN218=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=Ca1hKKsLrUXK4G6ntudESEsZ2Tp88Y9AZtypVud3PBxPFTchITV43znNdqyPq4AV+s
         fjn5/R8qeKG0Lxl811qiJUkHXneAB3ol2CUHQ4puukNPOq2GzWXUdakcf8aliordofVQ
         s3QunKzj+Cks9eOQTEMSSGGgr65TYFFPFgwTQ=
Received: by 10.110.86.3 with SMTP id j3mr794001tib.33.1231975501362;
        Wed, 14 Jan 2009 15:25:01 -0800 (PST)
Received: from localhost (pcd406163.netvigator.com [203.218.196.163])
        by mx.google.com with ESMTPS id u12sm2045473tia.9.2009.01.14.15.24.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Jan 2009 15:24:59 -0800 (PST)
Mail-Followup-To: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20090113233643.GA28898@diku.dk>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105729>

On Wed, 14 Jan 2009, Jonas Fonseca wrote:
> Tig is an ncurses-based text-mode interface for git. It functions mai=
nly

The Makefile does not link to the unicode version ncursesw, does it
still work for wide characters?

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9264 =E7=8E=8B=E6=98=8C=E9=BD=A1  =E8=8A=99=E8=93=89=E6=
=A8=93=E9=80=81=E8=BE=9B=E6=BC=B8
    =E5=AF=92=E9=9B=A8=E9=80=A3=E6=B1=9F=E5=A4=9C=E5=85=A5=E5=90=B3  =E5=
=B9=B3=E6=98=8E=E9=80=81=E5=AE=A2=E6=A5=9A=E5=B1=B1=E5=AD=A4  =E6=B4=9B=
=E9=99=BD=E8=A6=AA=E5=8F=8B=E5=A6=82=E7=9B=B8=E5=95=8F  =E4=B8=80=E7=89=
=87=E5=86=B0=E5=BF=83=E5=9C=A8=E7=8E=89=E5=A3=BA
