From: bill lam <cbill.lam@gmail.com>
Subject: how to git a read only directory
Date: Wed, 21 Jan 2009 16:33:54 +0800
Message-ID: <20090121083354.GG6970@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 21 09:35:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPYYl-0006G7-4q
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 09:35:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759414AbZAUIeH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2009 03:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757301AbZAUIeF
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 03:34:05 -0500
Received: from ti-out-0910.google.com ([209.85.142.188]:16770 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757155AbZAUIeB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 03:34:01 -0500
Received: by ti-out-0910.google.com with SMTP id b6so2804747tic.23
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 00:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=qcjfZF1lT361PdubKMgqFothb5fBKGRmlZ1dQVwQbf8=;
        b=gG8jQ7ZGNgowh3Pdof3fVCl7ZZWYoreFzzk4JjeSOqqUt8yhS4Q0g/73sVXk8UnZpD
         sQccLzAiEHTnSalFITv/6Eg1tlNfzKAYTFSY6isK7IXBbHYsUh+91ikYwTsTuNNO/i+l
         fc1+I5sxq/gCOEgxTcFUSIehirw1X17BAh++4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        b=GRtON092j0yxKnj9/vPQBMYlfUBsBX/DDr4axqysox4FZ9fLD8E6dxDnPH8lz4/mE6
         7U2nka0K4YERC1uElsl4s2ygEj5EdbUyQVXdlAkrWHz5djaecsxK6IKcQpZSETSTN+5g
         sd0vKQsxD746Cu9+HuPRdt7FQxhYylG1fouOk=
Received: by 10.110.61.18 with SMTP id j18mr4134526tia.56.1232526839093;
        Wed, 21 Jan 2009 00:33:59 -0800 (PST)
Received: from localhost (pcd589144.netvigator.com [218.102.121.144])
        by mx.google.com with ESMTPS id 14sm3566097tim.30.2009.01.21.00.33.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Jan 2009 00:33:58 -0800 (PST)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106578>

I want to use git to keep track of files inside /etc but do not want
to do it as a super user. Is that possible to put GIT_DIR under my
home directory and add public-read files inside /etc? Or that it could
be done in some other ways.

Thanks.

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9164 =E5=BC=B5=E5=96=AC  =E6=9B=B8=E9=82=8A=E4=BA=8B
    =E8=AA=BF=E8=A7=92=E6=96=B7=E6=B8=85=E7=A7=8B  =E5=BE=81=E4=BA=BA=E5=
=80=9A=E6=88=8D=E6=A8=93  =E6=98=A5=E9=A2=A8=E5=B0=8D=E9=9D=92=E5=A1=9A=
  =E7=99=BD=E6=97=A5=E8=90=BD=E6=A2=81=E5=B7=9E
    =E5=A4=A7=E6=BC=A0=E7=84=A1=E5=85=B5=E9=98=BB  =E7=AA=AE=E9=82=8A=E6=
=9C=89=E5=AE=A2=E9=81=8A  =E8=95=83=E6=83=85=E4=BC=BC=E6=AD=A4=E6=B0=B4=
  =E9=95=B7=E9=A1=98=E5=90=91=E5=8D=97=E6=B5=81
