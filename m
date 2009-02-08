From: bill lam <cbill.lam@gmail.com>
Subject: tool and worktree
Date: Sun, 8 Feb 2009 11:44:06 +0800
Message-ID: <20090208034406.GB7230@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 08 05:02:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW0rn-0005uy-NX
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 05:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbZBHDoN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Feb 2009 22:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbZBHDoM
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 22:44:12 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:52713 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbZBHDoM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 22:44:12 -0500
Received: by ti-out-0910.google.com with SMTP id d10so1414655tib.23
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 19:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=mQ6syCyK2UfnB/3ISe1GRcD17rabjYr+pYf8GY1aimg=;
        b=dgKzxwjv+WZ8wubpF6DPMYmyR5qvTaV28qNuJ9H3/5MiR+lbivLk22tfv5anh9QGiu
         oaS8GnddS79llGwytnQqRsrQr1aTKXFrHWYXJIKusYmJZrNi7P4DpJT5H8k+kxyuRP0y
         +u1tPs4nSKqAKfWEWy8XTIuVHIel8zcTwVGvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        b=LOFClUTBj4oQw1M7HcvAZHa55h+jA5j3jCuSyY6A690mdisvAdrnuhlv40CjaG/evl
         OFZRMA2gz8VRHeGnBiecZlrdBUH2vc+NK3CyGWMwv2vvzG5UqHpVEUDNlcHQghrkLc8m
         0swrC+QO7BYYSM1N57yPQskZ6MpIfBzm4EQzs=
Received: by 10.110.43.16 with SMTP id q16mr5660971tiq.27.1234064650461;
        Sat, 07 Feb 2009 19:44:10 -0800 (PST)
Received: from localhost (pcd632187.netvigator.com [218.102.164.187])
        by mx.google.com with ESMTPS id i9sm3876037tid.33.2009.02.07.19.44.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Feb 2009 19:44:09 -0800 (PST)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108917>

I track /etc using a config

[core]
	repositoryformatversion =3D 0
	filemode =3D true
	bare =3D false
	worktree =3D /etc
	logAllRefUpdates =3D true
	excludesfile =3D

But that can not be handled by tools,

git gui : cannot use funny .git directory .
tig : status view said, The status view requires a working tree

Can these be improved?
=20
--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9314 =E7=8E=8B=E6=98=8C=E9=BD=A1  =E9=95=B7=E4=BF=A1=E6=
=80=A8
    =E5=A5=89=E5=B8=9A=E5=B9=B3=E6=98=8E=E9=87=91=E6=AE=BF=E9=96=8B  =E4=
=B8=94=E5=B0=87=E5=9C=98=E6=89=87=E5=85=B1=E5=BE=98=E5=BE=8A  =E7=8E=89=
=E9=A1=8F=E4=B8=8D=E5=8F=8A=E5=AF=92=E9=B4=89=E8=89=B2  =E7=8C=B6=E5=B8=
=B6=E6=98=AD=E9=99=BD=E6=97=A5=E5=BD=B1=E4=BE=86
