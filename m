From: bill lam <cbill.lam@gmail.com>
Subject: .ft tag in man
Date: Wed, 14 Jan 2009 13:21:26 +0800
Message-ID: <20090114052126.GA6849@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 14 06:22:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMyDR-0003kK-FA
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 06:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753703AbZANFVd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jan 2009 00:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753677AbZANFVd
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 00:21:33 -0500
Received: from ti-out-0910.google.com ([209.85.142.191]:51942 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbZANFVc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 00:21:32 -0500
Received: by ti-out-0910.google.com with SMTP id b6so177877tic.23
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 21:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=WhKkE18Uq2KXSyVCzxDKQAds3/tjO2B1GSimnMbmz68=;
        b=J+rkZEa3zZN+p1qUaGlKYX8dEjlGKKIUW3eJUvqVk3aORn2j8DIMhZz0nnsyvFsnBe
         t1Ul/sQhW+lcZnqIL7K6ZR8HC18HKNvvlV3sxVTGS5dG5IBNEox9Rdg/G/t6sNDlsrj/
         MKLxLrASs324TYSanP7LSXFIdcxs0ojf1l3cg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        b=B+cPeN0+jStx4WpuCfy4viPECUn7v/Lj9GABQoJWLMCWw4bciAhNvTo9VBBRrYnWEE
         RJq1NZKikgbcoBxpo0M3eeav3blCSavyOhXeJpw6junhHKr7Gqr0YkPW9Y7QA3jB9s+q
         M0P0coGLKKQO8vDHwNjBRFkCXfobL9v4MqbB4=
Received: by 10.110.5.18 with SMTP id 18mr1454390tie.54.1231910490918;
        Tue, 13 Jan 2009 21:21:30 -0800 (PST)
Received: from localhost (n218103235067.netvigator.com [218.103.235.67])
        by mx.google.com with ESMTPS id d4sm2783591tib.31.2009.01.13.21.21.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Jan 2009 21:21:29 -0800 (PST)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105583>

The diagram in man contain some .ft tag, eg inside
PAGE=3Dless git help rebase
it contains

           .ft C
                     A---B---C topic
                    /
               D---E---F---G master
           .ft

Is that intended or just an artefact?

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9244 =E6=9F=B3=E5=AE=97=E5=85=83  =E6=B1=9F=E9=9B=AA
    =E5=8D=83=E5=B1=B1=E9=B3=A5=E9=A3=9B=E7=B5=95  =E8=90=AC=E5=BE=91=E4=
=BA=BA=E8=B9=A4=E6=BB=85  =E5=AD=A4=E8=88=9F=E7=B0=91=E7=AC=A0=E7=BF=81=
  =E7=8D=A8=E9=87=A3=E5=AF=92=E6=B1=9F=E9=9B=AA
