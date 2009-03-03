From: bill lam <cbill.lam@gmail.com>
Subject: git-add and index
Date: Tue, 3 Mar 2009 15:20:08 +0800
Message-ID: <20090303072008.GB7478@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 03 08:21:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeOwm-0008TY-8E
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 08:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756151AbZCCHUT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 02:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755977AbZCCHUT
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 02:20:19 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:62435 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755832AbZCCHUR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 02:20:17 -0500
Received: by ti-out-0910.google.com with SMTP id d10so3050558tib.23
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 23:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=gOLPG72W5rLkXJmAKl08Ao/UgmsC0DGmjJmvNe0MMNg=;
        b=wxDv8xSy8+dxVp+/XzNKjuKNT8EC8aIEMLRcIeufxqc9ZZplpozBC6n8qSYG13PQds
         C5McfQjaPnXE+3JMKVniJ7O4QHVgo4Cr13jaqtou4bGU5eAsS28QRX0kZyEtHAZNSlqJ
         Ma8VKPv3uSHRkK9DJCZTQOGAjR0hDqEJ1PXzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        b=bxoWIsjJRyt+hWBiFC5MCph2b6ImVDGSGe1I4SN+RcnZWGd+lCLmJPwfHhHR1W+5hT
         deE7cUPkGLxnMb7tZkQ5lUi9hPRiRsTR87ilHi1H86o6eUPD1jULpjyADm9oSYd3EWWm
         6/nLmd/SUGgJsXqicn985v0duMyXSNtZP5u/k=
Received: by 10.110.14.12 with SMTP id 12mr9844430tin.22.1236064812669;
        Mon, 02 Mar 2009 23:20:12 -0800 (PST)
Received: from localhost (n218103218033.netvigator.com [218.103.218.33])
        by mx.google.com with ESMTPS id d4sm3017328tib.28.2009.03.02.23.20.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Mar 2009 23:20:11 -0800 (PST)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112010>

I have 2 questions related to index
1. Is it safe to just git-add (without commit) for local changes made
   before checkout or switch to another branch?
2. How to checkout the changes as recorded in index from git-add that
   not yet commit to the working tree?

Thanks!

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9179 =E7=8E=8B=E7=B6=AD  =E5=A5=89=E5=92=8C=E8=81=96=E8=
=A3=BD=E5=BE=9E=E8=93=AC=E8=90=8A=E5=90=91=E8=88=88=E6=85=B6=E9=96=A3=E9=
=81=93=E4=B8=AD=E7=95=99=E6=98=A5=E9=9B=A8=E4=B8=AD=E6=98=A5=E6=9C=9B=E4=
=B9=8B=E4=BD=9C=E6=87=89=E5=88=B6
    =E6=B8=AD=E6=B0=B4=E8=87=AA=E7=B8=88=E7=A7=A6=E5=A1=9E=E6=9B=B2  =E9=
=BB=83=E5=B1=B1=E8=88=8A=E9=81=B6=E6=BC=A2=E5=AE=AE=E6=96=9C  =E9=91=BE=
=E8=BC=BF=E8=BF=A5=E5=87=BA=E5=8D=83=E9=96=80=E6=9F=B3  =E9=96=A3=E9=81=
=93=E8=BF=B4=E7=9C=8B=E4=B8=8A=E8=8B=91=E8=8A=B1
    =E9=9B=B2=E8=A3=A1=E5=B8=9D=E5=9F=8E=E9=9B=99=E9=B3=B3=E9=97=95  =E9=
=9B=A8=E4=B8=AD=E6=98=A5=E6=A8=B9=E8=90=AC=E4=BA=BA=E5=AE=B6  =E7=82=BA=
=E4=B9=98=E9=99=BD=E6=B0=A3=E8=A1=8C=E6=99=82=E4=BB=A4  =E4=B8=8D=E6=98=
=AF=E5=AE=B8=E9=81=8A=E7=8E=A9=E7=89=A9=E8=8F=AF
