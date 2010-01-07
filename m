From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/3] Bringing git-ls-files to porcelain level
Date: Fri, 8 Jan 2010 00:47:30 +0700
Message-ID: <fcaeb9bf1001070947u5859dda0vacbcc27298d664a4@mail.gmail.com>
References: <1262884076-12293-1-git-send-email-pclouds@gmail.com>
	 <vpq3a2hlsnx.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jan 07 18:47:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSwSP-0005kS-IZ
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 18:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190Ab0AGRrc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jan 2010 12:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067Ab0AGRrb
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 12:47:31 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:39037 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab0AGRrb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2010 12:47:31 -0500
Received: by pxi4 with SMTP id 4so1423224pxi.33
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 09:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DCd10rMkVLFu+474sAcPansIMKPAqM158tN6466dh2c=;
        b=ul4EX/9CP5FIlOCyBQ4BtrBbGK50I92QWnELgSDCopIefLvHS2FcSm6sV0ZyIykssl
         sxVMGTzcCpy4txTQ15gWSO3nzSrqu8OnoWjj8T6jjce/fSB2kAsqUfcFNVNGABKYIApI
         unDKwEBtyrE9m+PjUNJMvb5pbO8akqxMfXGAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Bz2uFhyfFVmEWgRQZyGUgpcQRhg9utU+iqsLsxh+aPdNUmqiLV1vRDyU6sMvCJ9YK4
         JTNAJNmkqyiQPQxFqj28ek7g3SeDgCAfD/yUHid5zq2cZQ2PiMJRQaATAxQ5wEn0zThf
         SRd/Bs3kiFdcYQLJ7048Z+uNacM7mOxSDd6qI=
Received: by 10.114.165.18 with SMTP id n18mr143567wae.154.1262886450355; Thu, 
	07 Jan 2010 09:47:30 -0800 (PST)
In-Reply-To: <vpq3a2hlsnx.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136367>

On 1/8/10, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>  > This is a hack, to scratch my itch. These patches add "git ls",
>  > which is equivalent to "git ls-files --max-depth 1|column"
>
>
> You also want --exclude-standard to be the default in porcelain.
>
>  I've had "alias.ls =3D ls-files --exclude-standard" for a while in m=
y
>  ~/.gitconfig ;-).

Yeah, just added that after realizing "git ls -o" is too annoying.
--=20
Duy
