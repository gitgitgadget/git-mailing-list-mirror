From: bill lam <cbill.lam@gmail.com>
Subject: Re: pre-commit hook
Date: Sun, 22 Feb 2009 18:58:38 +0800
Message-ID: <20090222105838.GB8029@b2j>
References: <20090220091127.GA7415@b2j> <7v63j5t6r3.fsf@gitster.siamese.dyndns.org> <20090221035748.GC7409@b2j> <499FE579.1050700@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Feb 22 12:00:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbC4n-0004Og-FQ
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 12:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432AbZBVK6s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2009 05:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753361AbZBVK6r
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 05:58:47 -0500
Received: from ti-out-0910.google.com ([209.85.142.189]:13746 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324AbZBVK6q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 05:58:46 -0500
Received: by ti-out-0910.google.com with SMTP id d10so1119378tib.23
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 02:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GHiqhe6XVndmGAP2ndOoFuzAYd79zDeCnCH+jO+Rw5s=;
        b=eK6wjg2gAgoDbKX325ISBm8ukC9w+8x+xSPCFCa3pEBCNtn5AnSNC2FN3Wzhs1wHDl
         BqgXmk3XquXLYKmUmMr4tn2DDIuSd52+NkGr8jY4ZYFoKV6FBteKo6UQr5LqA6mgt9HR
         85hnGCHHFLi7E9KvD3H76C7NynUb71mM/aGTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=ICvH1RxvgcXMitO0x1XrPOZmmIHwSJLrEj3+/fNs5Um17JKLkXRirxSIsq6USuZ5zd
         16dw0uMcThKPGrtetJFhShjgKx+58S1K5XQZkSQ0EHjRUuwpN1cpqipT7PelTLc1qrZz
         BEr4rIl39cD6tJtH6IRf+GSA2KQhk6OiPWMG4=
Received: by 10.110.41.20 with SMTP id o20mr4052157tio.59.1235300324849;
        Sun, 22 Feb 2009 02:58:44 -0800 (PST)
Received: from localhost (n219078081066.netvigator.com [219.78.81.66])
        by mx.google.com with ESMTPS id 2sm3446903tif.6.2009.02.22.02.58.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Feb 2009 02:58:44 -0800 (PST)
Mail-Followup-To: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <499FE579.1050700@drmicha.warpmail.net>
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110995>

On Sat, 21 Feb 2009, Michael J Gruber wrote:
> > Isn't git-rev-parse (and all git-??? ) was deprecated in 1.6.2 ?
> >=20
>=20
> It's OK in hooks because the path is set appropriately there.

I make and install with prefix=3D/usr/bin , however I can only find git
inside /usr/bin; other git-???? are missing although they are built.
"which git-rev-parse" return nothing but "git rev-parse" can work.
Where are these git commands stored and how does the git locate them ?
=20
--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9169 =E5=83=A7=E7=9A=8E=E7=84=B6  =E5=B0=8B=E9=99=B8=E9=
=B4=BB=E6=BC=B8=E4=B8=8D=E9=81=87
    =E7=A7=BB=E5=AE=B6=E9=9B=96=E5=B8=B6=E9=83=AD  =E9=87=8E=E5=BE=91=E5=
=85=A5=E6=A1=91=E9=BA=BB  =E8=BF=91=E7=A8=AE=E7=B1=AC=E9=82=8A=E8=8F=8A=
  =E7=A7=8B=E4=BE=86=E6=9C=AA=E8=91=97=E8=8A=B1
    =E6=89=A3=E9=96=80=E7=84=A1=E7=8A=AC=E5=90=A0  =E6=AC=B2=E5=8E=BB=E5=
=95=8F=E8=A5=BF=E5=AE=B6  =E5=A0=B1=E5=88=B0=E5=B1=B1=E4=B8=AD=E5=8E=BB=
  =E6=AD=B8=E4=BE=86=E6=AF=8F=E6=97=A5=E6=96=9C
