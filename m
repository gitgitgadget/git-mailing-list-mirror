From: bill lam <cbill.lam@gmail.com>
Subject: how to reset to remote repo
Date: Mon, 23 Feb 2009 18:55:46 +0800
Message-ID: <20090223105546.GA7425@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 23 11:57:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbYVE-0007gd-1O
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 11:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947AbZBWKz6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Feb 2009 05:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752973AbZBWKz6
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 05:55:58 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:59513 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbZBWKz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 05:55:57 -0500
Received: by ti-out-0910.google.com with SMTP id d10so1454348tib.23
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 02:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=CF2AvEQFTLbAJqW0D9l7N6+521kMKeGFp67NwssU3kc=;
        b=En7LMmUp3DSfy614I/w94EMOraTaPbmwM9JXsglREmal2vQ45pa5q2wOHZHOR16zkK
         pJuoohx+lxyPfAMPVBfRiXOTFb3nxpUqRnZjghsAv49cI1wXooqOmn6hFIGzWToT6bnz
         egyFnvrOW4W+bkuAhehmQIgHMZn/QGZnlZnCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        b=muRlsIQlkGqOtq5e5UZJ6XOHEC2qIk07mIWKcVfxxPiuBCAq32CnsDbptKn8IslC3a
         xpIo3XzQ9vWGML+bRPVEor9vr0xPSM9sn4s/5fIokwk13wdhLAetNNSaY/cuIo0yyIAQ
         /SZyItdlDiXOM2Z+19V1eQE/wyyqM3lwR8Bho=
Received: by 10.110.2.2 with SMTP id 2mr5645040tib.29.1235386555945;
        Mon, 23 Feb 2009 02:55:55 -0800 (PST)
Received: from localhost (n219078081066.netvigator.com [219.78.81.66])
        by mx.google.com with ESMTPS id d4sm237006tib.28.2009.02.23.02.55.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Feb 2009 02:55:55 -0800 (PST)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111130>

I cloned some public git repos and made some local patches. Later I
pulled updates again and that merged with my patches. Now I want to
throw away my patches, how do I get a clean working repo that is a
100% clone of the remote repo?

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9285 =E5=BC=B5=E7=A5=9C  =E9=9B=86=E9=9D=88=E8=87=BA=E4=
=BA=8C=E9=A6=96=E4=B9=8B=E4=BA=8C
    =E8=99=A2=E5=9C=8B=E5=A4=AB=E4=BA=BA=E6=89=BF=E4=B8=BB=E6=81=A9  =E5=
=B9=B3=E6=98=8E=E9=A8=8E=E9=A6=AC=E5=85=A5=E5=AE=AE=E9=96=80  =E5=8D=BB=
=E5=AB=8C=E8=84=82=E7=B2=89=E6=B1=A1=E9=A1=8F=E8=89=B2  =E6=B7=A1=E6=8E=
=83=E8=9B=BE=E7=9C=89=E6=9C=9D=E8=87=B3=E5=B0=8A
