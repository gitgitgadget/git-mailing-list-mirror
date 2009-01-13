From: bill lam <cbill.lam@gmail.com>
Subject: how to combine 2 commits?
Date: Tue, 13 Jan 2009 12:54:22 +0800
Message-ID: <20090113045422.GA6940@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 13 05:55:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMbJh-0008Da-5F
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 05:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754285AbZAMEyb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jan 2009 23:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754173AbZAMEya
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 23:54:30 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:7156 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbZAMEy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 23:54:29 -0500
Received: by ti-out-0910.google.com with SMTP id b6so12168369tic.23
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 20:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=uJO9WjAJImwcJq/HX8VpqrHX9j6yuOAJtQxbJ3QT570=;
        b=sdvkdkLV5/Pkke9fM4gHDs4YHZJLdIfKWIKsIfksOmMDIS0X9lfuGWOgaHm6rrx93c
         yMB3O1ItekIp9cv5hJqlp8tUmNXYFJ53oyu4aFjN/lKTtq5YT6NZB5gLd/sZWomuF629
         /Cb3CdUck08OQLav40LY8BaLHTcVDKCVnVjXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        b=MreO4v7gGn0WZw97idfe/yaU6YI7iRQ2UhlFmLowWjeNULLagZwR2gdSvWYAgLlDl/
         WHH8+so6onn6N2wCOV4T2UkzI5SNMeeMKAM0iEpgmmhxPd3DAVBiUhANj3juvCAFipFS
         MEppTv1Jw4Ypght+fH2UcezRFatzcOLDPuUMw=
Received: by 10.110.69.5 with SMTP id r5mr44577970tia.36.1231822468024;
        Mon, 12 Jan 2009 20:54:28 -0800 (PST)
Received: from localhost (n218103237205.netvigator.com [218.103.237.205])
        by mx.google.com with ESMTPS id y5sm2556199tia.21.2009.01.12.20.54.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Jan 2009 20:54:26 -0800 (PST)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105454>

Sorry I don't know the correct git terminology for it.  I make some
changes to scripts but also accidentally changed all scripts to use
dos linefeed.  Failed to notice this and commit all changes. Then I
tried to correct it by changing all scripts back to unix linefeed and c=
ommit again.

How to combine these 2 commits so that the changes of linefeed cancel
out each other and the history only shows the intended changes of the
few scripts.

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9234 =E6=9D=8E=E7=99=BD  =E6=80=A8=E6=83=85
    =E7=BE=8E=E4=BA=BA=E6=8D=B2=E7=8F=A0=E7=B0=BE  =E6=B7=B1=E5=9D=90=E8=
=B9=99=E8=9B=BE=E7=9C=89  =E4=BD=86=E8=A6=8B=E6=B7=9A=E7=97=95=E6=BF=95=
  =E4=B8=8D=E7=9F=A5=E5=BF=83=E6=81=A8=E8=AA=B0
