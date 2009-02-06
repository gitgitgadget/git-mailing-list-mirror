From: bill lam <cbill.lam@gmail.com>
Subject: can git reset or checkout be reverted?
Date: Fri, 6 Feb 2009 22:19:40 +0800
Message-ID: <20090206141940.GB7231@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 06 15:21:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVRZy-00028b-Nn
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 15:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757050AbZBFOTr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Feb 2009 09:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756949AbZBFOTr
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 09:19:47 -0500
Received: from ti-out-0910.google.com ([209.85.142.189]:26937 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756654AbZBFOTq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 09:19:46 -0500
Received: by ti-out-0910.google.com with SMTP id d10so1009760tib.23
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 06:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=lEOCrkRc7hXpiCD2fmRZ1XP0XfCHE9xzZI+K5qxFqeU=;
        b=HAH+i8hv0h/qf2QqzO+J9QuaIOIgWlA5hchQF+BeG8R4oceCt+9YBvRCoKLK5bSzBQ
         iHV6oWNf6qKTyezxQKPyVzW3BhM5yu0IHGmZFwOjfpHHFqqPl3G/nh1uMuB5FhmSGNp6
         RSArQ7I8HB46qQT6DI9TUzLOISzPtvwRtjxrs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        b=Wmp+fOuj9Rd0Ay6CNcjEwb+n/nJ30nBM81UVarEe3q69ojcwb65jQdKyC97VFCMPi4
         nj4Qx5IUVTzjPV74Fd9t9m4pqFtXyVsX/QZhlHo6ADFNwqRHcUnu3o/N7AtS6JMRm+aD
         7j6NWpR8OvweQw508RF5xaTHH9mzxQ/s1FPKY=
Received: by 10.110.17.14 with SMTP id 14mr2818113tiq.19.1233929984056;
        Fri, 06 Feb 2009 06:19:44 -0800 (PST)
Received: from localhost (n219079102072.netvigator.com [219.79.102.72])
        by mx.google.com with ESMTPS id i6sm998979tid.23.2009.02.06.06.19.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Feb 2009 06:19:43 -0800 (PST)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108715>

If I want to recall a old version of testing by

git reset --hard sha1
or
git checkout sha1

then git log does not show anything beyond that commit. It does give
some warning and recommend -b switch next time.  If I only do that by
accident or ignorance.  How to revert to the original HEAD?

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9274 =E9=9F=93=E7=BF=83  =E5=AF=92=E9=A3=9F
    =E6=98=A5=E5=9F=8E=E7=84=A1=E8=99=95=E4=B8=8D=E9=A3=9B=E8=8A=B1  =E5=
=AF=92=E9=A3=9F=E6=9D=B1=E9=A2=A8=E5=BE=A1=E6=9F=B3=E6=96=9C  =E6=97=A5=
=E6=9A=AE=E6=BC=A2=E5=AE=AE=E5=82=B3=E8=A0=9F=E7=87=AD  =E8=BC=95=E7=85=
=99=E6=95=A3=E5=85=A5=E4=BA=94=E4=BE=AF=E5=AE=B6
