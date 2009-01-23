From: bill lam <cbill.lam@gmail.com>
Subject: does git config get any side effect other than changing .gitconfig
Date: Fri, 23 Jan 2009 11:12:10 +0800
Message-ID: <20090123031210.GB6931@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 23 04:13:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQCUO-00038S-Fv
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 04:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755691AbZAWDMR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jan 2009 22:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754943AbZAWDMR
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 22:12:17 -0500
Received: from ti-out-0910.google.com ([209.85.142.188]:23587 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbZAWDMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 22:12:16 -0500
Received: by ti-out-0910.google.com with SMTP id b6so3143986tic.23
        for <git@vger.kernel.org>; Thu, 22 Jan 2009 19:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=hhTVLuB3n6H8BRLK7G1bbnORGSqOWDyU0dE4U3xUOCc=;
        b=VDmooEIOXhdqUgGsIUOZ3TGIDpYlMRWoFTRYfWnnyeVQiDIwOXJdOM5U59n7dcf1tv
         PILY0w39IPlmJNY5DcukGjrI6+UjyESNR4V2OZEx+doiI5w/JpQzaxmZfSsfLPSpKyOT
         Eht6gfRAI109vumyYRO7eM40Ba6jO6zzZVVeM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        b=ad8iJFQt9aTIgVGKSBN9sbbV+CZD+TXYRFVpL0JJvPMLJXaqG/VJsGHEkeL/s4NTnT
         Y6hqra/BhiNYXTHpgO+ohHFzFqA3b9XynK0w5Kj0YNZRy4cAnC53m/lDS2MvVI207cAO
         UiEBcIxnuMm2CY0kRRyqDV06IBIwQZRnduUFk=
Received: by 10.110.49.6 with SMTP id w6mr14208tiw.39.1232680333832;
        Thu, 22 Jan 2009 19:12:13 -0800 (PST)
Received: from localhost (n218103237232.netvigator.com [218.103.237.232])
        by mx.google.com with ESMTPS id u8sm2631192tia.8.2009.01.22.19.12.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Jan 2009 19:12:12 -0800 (PST)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106826>

Suppose I got several git repositories to maintain, instead of using
command git config [--global] again and again.  Can I call up a text
editor to edit .git/config or .gitconfig manually, or just copy from
another .gitconfig ?

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9096 =E5=AE=8B=E4=B9=8B=E5=95=8F  =E9=A1=8C=E5=A4=A7=E5=
=BA=BE=E5=B6=BA=E5=8C=97=E9=A9=9B
    =E9=99=BD=E6=9C=88=E5=8D=97=E9=A3=9B=E9=9B=81  =E5=82=B3=E8=81=9E=E8=
=87=B3=E6=AD=A4=E5=9B=9E  =E6=88=91=E8=A1=8C=E6=AE=8A=E6=9C=AA=E5=B7=B2=
  =E4=BD=95=E6=97=A5=E5=BE=A9=E6=AD=B8=E4=BE=86
    =E6=B1=9F=E9=9D=9C=E6=BD=AE=E5=88=9D=E8=90=BD  =E6=9E=97=E6=98=8F=E7=
=98=B4=E4=B8=8D=E9=96=8B  =E6=98=8E=E6=9C=9D=E6=9C=9B=E9=84=89=E8=99=95=
  =E6=87=89=E8=A6=8B=E9=9A=B4=E9=A0=AD=E6=A2=85
