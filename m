From: bill lam <cbill.lam@gmail.com>
Subject: tracking binary files
Date: Thu, 19 Feb 2009 11:16:02 +0800
Message-ID: <20090219031602.GD20416@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 04:17:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZzQ4-0005mb-MH
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 04:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbZBSDQL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Feb 2009 22:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbZBSDQL
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 22:16:11 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:46404 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbZBSDQK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 22:16:10 -0500
Received: by ti-out-0910.google.com with SMTP id d10so109068tib.23
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 19:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=itvbaoeaC/pOAVqgzcOkTlxAv++oMPwmNR1mCb4gHT4=;
        b=yCYe1zJXcikRH5tJFotM0/UDBs2YMm6RT7J8nxwYbEc1Zn0vQz3kzmuJuFc+JdgOpE
         5I4VNmUu32KrBqW0/mkawjnTSoLwwQBGBJHRJQIJPBg1AIPCar/1XYu7uHhktIbcglCJ
         slqVKn4P1KlbOsDVGWIcsUoq2r4rCLLsyojbc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        b=N8tuZGBciXXUewGBYHLp5oRE0ecrsQwr+Lf5sKLGF7Nrjn84FUYXVpsphNrGLMfTxQ
         xXJHaaKbVWdSaC4ObAUrOYk1R2NKAgWM1MOwWia384zvcqCGXJBGnFyDBV5EMGmaP+LO
         3JSnfMTGtdj5EweIRgTi1iVnr0Mvt++5++NjI=
Received: by 10.110.47.17 with SMTP id u17mr4740271tiu.14.1235013368367;
        Wed, 18 Feb 2009 19:16:08 -0800 (PST)
Received: from localhost (pcd589101.netvigator.com [218.102.121.101])
        by mx.google.com with ESMTPS id 22sm1756822tim.24.2009.02.18.19.16.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Feb 2009 19:16:07 -0800 (PST)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110611>

I would like to use git to track some database files of sizes from 1MB
to 50MB.  I want to know does git compress them for storage or not.
If so, what will be the expected compression ratio.  Those files
normally compressed to 25% of original size using zip.

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9312 =E7=8E=8B=E7=B6=AD  =E6=B8=AD=E5=9F=8E=E6=9B=B2
    =E6=B8=AD=E5=9F=8E=E6=9C=9D=E9=9B=A8=E6=B5=A5=E8=BC=95=E5=A1=B5  =E5=
=AE=A2=E8=88=8D=E9=9D=92=E9=9D=92=E6=9F=B3=E8=89=B2=E6=96=B0  =E5=8B=B8=
=E5=90=9B=E6=9B=B4=E7=9B=A1=E4=B8=80=E6=9D=AF=E9=85=92  =E8=A5=BF=E5=87=
=BA=E9=99=BD=E9=97=9C=E7=84=A1=E6=95=85=E4=BA=BA
