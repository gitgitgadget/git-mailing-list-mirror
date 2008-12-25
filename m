From: bill lam <cbill.lam@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.6.1
Date: Thu, 25 Dec 2008 18:25:27 +0800
Message-ID: <20081225102527.GB8451@b2j>
References: <7v7i5odams.fsf@gitster.siamese.dyndns.org> <20081225100033.GA8451@b2j> <7v3agca7fp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 25 11:26:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFnQg-0000mn-3t
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 11:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbYLYKZi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Dec 2008 05:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbYLYKZh
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Dec 2008 05:25:37 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:26526 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbYLYKZh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2008 05:25:37 -0500
Received: by ti-out-0910.google.com with SMTP id b6so6627323tic.23
        for <git@vger.kernel.org>; Thu, 25 Dec 2008 02:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IvruKATzPgQGmRko86dJFZGAnlni+K7AJXW+WB4RJA8=;
        b=EYa0njOPdxjag48aC/+dewByN0pofcjdlJKGdLY0j1RqpBRympalCFOGHr97ikosHx
         bxa6yFzL2dRixWqF0ok93wd2RUyw8cvXbzHhO90iRRd4KvLEwhE6vVtNpfgNcMzE55Og
         /0zJ4yH6Iwuos39zBLAGYVAa7UfjyfscLjqVg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=h1hPCBxVxz+gfZkm29B9bV/QGTTWvxSFzYt2Py5Ya62UHbZsab63tOWB6A1LgJCBUB
         5h58Rs9ueBmjc9WHWnHsNhmz98+Ibt+mqOSbLjQOahCawLRcfGIfKjjuTSI6Djs3uCy+
         8bxCZcRImMGnTRU7SJFYaT18YfEMNeydE4GIs=
Received: by 10.110.40.8 with SMTP id n8mr61596tin.0.1230200735230;
        Thu, 25 Dec 2008 02:25:35 -0800 (PST)
Received: from localhost (n218103218097.netvigator.com [218.103.218.97])
        by mx.google.com with ESMTPS id y3sm7200089tia.0.2008.12.25.02.25.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Dec 2008 02:25:34 -0800 (PST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v3agca7fp.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-11-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103899>

> Why are you building with NO_UINTMAX_T to begin with?  Isn't ubuntu 8=
=2E10 a
> recent enough platform that ships with modern enough header files tha=
t
> define ANSI uintmax_t type?

No, I did not do anything on that,=20

make clean
=2E/configure --prefix=3D/usr
make=20

and this is the error logged.
=20
GIT_VERSION =3D 1.6.1
    * new build flags or prefix
In file included from /usr/include/netinet/in.h:24,
                 from git-compat-util.h:78,
                 from builtin.h:4,
                 from fast-import.c:142:
/usr/include/stdint.h:136: error: conflicting types for =E2=80=98uint32=
_t=E2=80=99
/usr/include/stdint.h:52: error: previous declaration of =E2=80=98uint3=
2_t=E2=80=99 was here
fast-import.c: In function =E2=80=98parse_progress=E2=80=99:
fast-import.c:2339: warning: ignoring return value of =E2=80=98fwrite=E2=
=80=99, declared with attribute warn_unused_result
make: *** [fast-import.o] Error 1

version of gcc:
gcc (Ubuntu 4.3.2-1ubuntu11) 4.3.2

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9105 =E6=9D=9C=E7=94=AB  =E6=9C=88=E5=A4=9C
    =E4=BB=8A=E5=A4=9C=E9=84=9C=E5=B7=9E=E6=9C=88  =E9=96=A8=E4=B8=AD=E5=
=8F=AA=E7=8D=A8=E7=9C=8B  =E9=81=99=E6=86=90=E5=B0=8F=E5=85=92=E5=A5=B3=
  =E6=9C=AA=E8=A7=A3=E6=86=B6=E9=95=B7=E5=AE=89
    =E9=A6=99=E9=9C=A7=E9=9B=B2=E9=AC=9F=E6=BF=95  =E6=B8=85=E8=BC=9D=E7=
=8E=89=E8=87=82=E5=AF=92  =E4=BD=95=E6=99=82=E5=80=9A=E8=99=9B=E5=B9=8C=
  =E9=9B=99=E7=85=A7=E6=B7=9A=E7=97=95=E4=B9=BE
