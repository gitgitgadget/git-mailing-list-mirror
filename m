From: bill lam <cbill.lam@gmail.com>
Subject: how to apply patch in the middle
Date: Thu, 15 Jan 2009 09:35:35 +0800
Message-ID: <20090115013535.GB6937@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 15 02:37:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNHAQ-0004dP-89
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 02:37:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbZAOBfn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jan 2009 20:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752224AbZAOBfm
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 20:35:42 -0500
Received: from ti-out-0910.google.com ([209.85.142.191]:60845 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbZAOBfl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 20:35:41 -0500
Received: by ti-out-0910.google.com with SMTP id b6so428337tic.23
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 17:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=CPhzKGkbvbAVpE/8mS/aYMJwIG/DNCI7lYazfUxuHMw=;
        b=InHwS/xhB5uuYxRI9YB0ZHf9/t6LJm/8FrYXXRAnXzsNnj9PxW+eYcMqCGOIwtvsKW
         mF3hiFRmroaGHV22nxFAVy/caMwqVGZqaHodYaBNkSIJGLZGkIwx3ojPczJUV9csrFC9
         UWtD012gK7eJ1D4sqivby6bKDx/PdqD5BfY88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        b=aqjtXYkgSDZc1kYgd1xRlfa1ytUpPsGpwJRixJ6XRVUZy4hB+/WrWBLG9L9FxySj8A
         LXMEklLc8lA560TeNLnAwBYupB3Q1vRPG+PQQF59U5ApxUtyXU8r05wfQcERGB4U/qh0
         WnyGRUGuVmeDmFfFJfj9Ce5adPNv2bkgl3NZc=
Received: by 10.110.50.19 with SMTP id x19mr987785tix.12.1231983339855;
        Wed, 14 Jan 2009 17:35:39 -0800 (PST)
Received: from localhost (pcd406163.netvigator.com [203.218.196.163])
        by mx.google.com with ESMTPS id 22sm2569196tim.15.2009.01.14.17.35.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Jan 2009 17:35:38 -0800 (PST)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105753>

I want to change history to rewrite

  - A - B - C - D - E - ..
=20
as

 - A - C' - D - E - ..

because rebase/squash cannot automatically resolve conflicts, I
generate a patch file from A to C

  git diff A C >pat

However I don't know how apply this patch and cancel the old B and C.
Sorry for this newbie question.

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9008 =E6=9D=9C=E7=94=AB  =E6=9C=9B=E5=B6=BD
    =E5=B2=B1=E5=AE=97=E5=A4=AB=E5=A6=82=E4=BD=95  =E9=BD=8A=E9=AD=AF=E9=
=9D=92=E6=9C=AA=E4=BA=86  =E9=80=A0=E5=8C=96=E9=8D=BE=E7=A5=9E=E7=A7=80=
  =E9=99=B0=E9=99=BD=E5=89=B2=E6=98=8F=E6=9B=89
    =E7=9B=AA=E8=83=B8=E7=94=9F=E5=B1=A4=E9=9B=B2  =E6=B1=BA=E7=9C=A5=E5=
=85=A5=E6=AD=B8=E9=B3=A5  =E6=9C=83=E7=95=B6=E5=87=8C=E7=B5=95=E9=A0=82=
  =E4=B8=80=E8=A6=BD=E7=9C=BE=E5=B1=B1=E5=B0=8F
