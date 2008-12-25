From: bill lam <cbill.lam@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.6.1
Date: Thu, 25 Dec 2008 18:00:33 +0800
Message-ID: <20081225100033.GA8451@b2j>
References: <7v7i5odams.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 25 11:02:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFn2X-00032p-9L
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 11:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbYLYKAm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Dec 2008 05:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbYLYKAm
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Dec 2008 05:00:42 -0500
Received: from ti-out-0910.google.com ([209.85.142.191]:33156 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbYLYKAl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2008 05:00:41 -0500
Received: by ti-out-0910.google.com with SMTP id b6so6621242tic.23
        for <git@vger.kernel.org>; Thu, 25 Dec 2008 02:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Lce7f/QghCytZh7xcgQt7T6hf7YWq90cBye+6vhlYrY=;
        b=esQjwXnxN9XGrVQ5jlGkyaoIf0LnAAp+Jb+DEJXrRhYrPiuLTOzLOzxpoWy+1u9fIA
         hkzn5WgcBEJBI4OEm/jvt7pkXjQD1ct9nV626/6FRF5zl1j4UmEJZTMC60o8FQW9w5OY
         QIGE1XZuRIKp6dVu/swIdEbHzHv9tp0Z+i5g0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=slpmmqGiaJLDbySE96VjlUDyKTN2srFe1Wbi/V60QB8UsvH8znP3OZE17gG/GOWaOS
         rQXCAO5C99HpZUK2pM4Cf7LoTxJKmcB7kvyX8Aln1SiW75HeMxwcUEB5iZcp1Zsi+jiz
         QtFty797QyOj4hcMdhA0gEVtrO+dMsEzzv6vE=
Received: by 10.110.21.17 with SMTP id 17mr14720848tiu.26.1230199239951;
        Thu, 25 Dec 2008 02:00:39 -0800 (PST)
Received: from localhost (n218103218097.netvigator.com [218.103.218.97])
        by mx.google.com with ESMTPS id 22sm3443973tim.15.2008.12.25.02.00.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Dec 2008 02:00:38 -0800 (PST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v7i5odams.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-11-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103897>

On ubuntu64 8.10, the NO_UINTMAX_T seems cause some trouble, I have to
comment out the block (in the Makefile),

fdef NO_UINTMAX_T
 BASIC_CFLAGS +=3D -Duintmax_t=3Duint32_t
ndif

to make a successful compilation. Does it happen to me only?

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9282 =E7=99=BD=E5=B1=85=E6=98=93  =E5=BE=8C=E5=AE=AE=E8=
=A9=9E
    =E6=B7=9A=E6=BF=95=E7=BE=85=E5=B7=BE=E5=A4=A2=E4=B8=8D=E6=88=90  =E5=
=A4=9C=E6=B7=B1=E5=89=8D=E6=AE=BF=E6=8C=89=E6=AD=8C=E8=81=B2  =E7=B4=85=
=E9=A1=8F=E6=9C=AA=E8=80=81=E6=81=A9=E5=85=88=E6=96=B7  =E6=96=9C=E5=80=
=9A=E8=96=B0=E7=B1=A0=E5=9D=90=E5=88=B0=E6=98=8E
