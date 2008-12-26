From: bill lam <cbill.lam@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.6.1
Date: Fri, 26 Dec 2008 22:42:50 +0800
Message-ID: <20081226144250.GC7103@b2j>
References: <7v7i5odams.fsf@gitster.siamese.dyndns.org> <20081225100033.GA8451@b2j> <7v3agca7fp.fsf@gitster.siamese.dyndns.org> <20081225102527.GB8451@b2j> <7vvdt884xu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 26 15:44:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGDvG-0004rE-4j
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 15:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbYLZOm5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Dec 2008 09:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752273AbYLZOm5
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 09:42:57 -0500
Received: from ti-out-0910.google.com ([209.85.142.188]:44518 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbYLZOm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 09:42:56 -0500
Received: by ti-out-0910.google.com with SMTP id b6so7082672tic.23
        for <git@vger.kernel.org>; Fri, 26 Dec 2008 06:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oni2Hv27fLJnvQouKJONMRFQ4jRyYZJZh4nCZy5sGXs=;
        b=bpfcLmwQTIjiB/U42nneO7njooZfZ0VbDzXiKbAvjgeQzstadDyIOiC4zbrVsXAxHw
         uvPXBQODK+E5ezuDCTA48FIXoCWtrXwxY0t46sNgzqcnLGoPbwCkP/HKqp0upCDSBPUV
         13lgkJo7qHaxfiiEEyDhX+r3eW8ZqrRpUQfjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=tqksygHElrFhvv3uGLBmQZtlJn/l8e6ZmnYDNVz0rPeia6nxN1FUOn8j2q+tXqQ8XL
         HQZcXPWjofkPl1P0eMT8CbnLHnEC7hI/jWnkSTCBdNYtKaueNAthkQ3v3ED9oJrBBS2E
         XZnmm5TiwsAAwrc4sm1s/vwez2ig1sBqryjZc=
Received: by 10.110.93.12 with SMTP id q12mr4268566tib.10.1230302574736;
        Fri, 26 Dec 2008 06:42:54 -0800 (PST)
Received: from localhost (n218103234218.netvigator.com [218.103.234.218])
        by mx.google.com with ESMTPS id a14sm1200930tia.32.2008.12.26.06.42.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Dec 2008 06:42:53 -0800 (PST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vvdt884xu.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103943>

On Thu, 25 Dec 2008, Junio C Hamano wrote:
> build process); it is plausible that it has broken checks for detecti=
ng
> the need of NO_UINTMAX_T.
>=20
> Relevant part of configure.ac reads like this:
>=20
>     # Define NO_UINTMAX_T if your platform does not have uintmax_t
>     AC_CHECK_TYPE(uintmax_t,
>     [NO_UINTMAX_T=3D],
>     [NO_UINTMAX_T=3DYesPlease],[
>     #include <inttypes.h>
>     ])
>     AC_SUBST(NO_UINTMAX_T)
>=20
> and I do not see anything suspicious there...

Thanks, I guess the configure is not part of the repository and I use
a legacy configure from earlier version. After I run the make
configure again, it is now ok.

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9093 =E9=A7=B1=E8=B3=93=E7=8E=8B  =E5=9C=A8=E7=8D=84=E8=
=A9=A0=E8=9F=AC
    =E8=A5=BF=E8=B7=AF=E8=9F=AC=E8=81=B2=E5=94=B1  =E5=8D=97=E5=86=A0=E5=
=AE=A2=E6=80=9D=E4=BE=B5  =E9=82=A3=E5=A0=AA=E7=8E=84=E9=AC=A2=E5=BD=B1=
  =E4=BE=86=E5=B0=8D=E7=99=BD=E9=A0=AD=E5=90=9F
    =E9=9C=B2=E9=87=8D=E9=A3=9B=E9=9B=A3=E9=80=B2  =E9=A2=A8=E5=A4=9A=E9=
=9F=BF=E6=98=93=E6=B2=89  =E7=84=A1=E4=BA=BA=E4=BF=A1=E9=AB=98=E6=BD=94=
  =E8=AA=B0=E7=82=BA=E8=A1=A8=E4=BA=88=E5=BF=83
