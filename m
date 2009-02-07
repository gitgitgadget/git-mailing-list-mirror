From: bill lam <cbill.lam@gmail.com>
Subject: Re: can git reset or checkout be reverted?
Date: Sat, 7 Feb 2009 13:31:38 +0800
Message-ID: <20090207053137.GA7240@b2j>
References: <20090206141940.GB7231@b2j> <slrngoonqk.urh.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 06:37:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVfsX-000875-Bx
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 06:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbZBGFbp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Feb 2009 00:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbZBGFbp
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 00:31:45 -0500
Received: from ti-out-0910.google.com ([209.85.142.191]:24461 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbZBGFbo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 00:31:44 -0500
Received: by ti-out-0910.google.com with SMTP id d10so1195049tib.23
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 21:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dw4ysWM9RMq8yYyhUNwt/+Tk6qrQiIFJ8bJvnYoSKNk=;
        b=bBfCK4DHTzjvUtgdNuF1MD0NRNH0SsofBPLvbtrk9jTgOZKNsMWabbcOcrThowwie2
         AfIZ9dvprDWh+5YUGGmJOWK/kBmXAPC4v5KRLd/bxeNiAGSA4aIEa37ueLH9UGv3R6Br
         7w65gN8gNLusTLybvhZalygATMLBAVh+F3dIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=rncQrghhXenBhALrxrIM+T4/9YZlWn5vp5ZF8cAY23ihKOkMjiMJBeV5t4n4zJ8Bcn
         Kgv7OP+EIaNKvOxuXVat9SKx8EfDncGguaN4TwBcvFK0kMfEHTH/QVQDZ1IfkxVrrwio
         y7zzLVKiFqR7znzNZdIUMJPb9Z0VVNVo+1ky8=
Received: by 10.110.33.15 with SMTP id g15mr3931264tig.58.1233984701562;
        Fri, 06 Feb 2009 21:31:41 -0800 (PST)
Received: from localhost (n219079102072.netvigator.com [219.79.102.72])
        by mx.google.com with ESMTPS id b4sm62193tic.16.2009.02.06.21.31.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Feb 2009 21:31:40 -0800 (PST)
Mail-Followup-To: Sitaram Chamarty <sitaramc@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <slrngoonqk.urh.sitaramc@sitaramc.homelinux.net>
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108813>

Sitaram Matthieu Jakub

Many thanks for help!

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9281 =E5=8A=89=E7=A6=B9=E9=8C=AB  =E6=98=A5=E8=A9=9E
    =E6=96=B0=E5=A6=9D=E5=AE=9C=E9=9D=A2=E4=B8=8B=E6=9C=B1=E6=A8=93  =E6=
=B7=B1=E9=8E=96=E6=98=A5=E5=85=89=E4=B8=80=E9=99=A2=E6=84=81  =E8=A1=8C=
=E5=88=B0=E4=B8=AD=E5=BA=AD=E6=95=B8=E8=8A=B1=E6=9C=B5  =E8=9C=BB=E8=9C=
=93=E9=A3=9B=E4=B8=8A=E7=8E=89=E6=90=94=E9=A0=AD
