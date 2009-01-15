From: bill lam <cbill.lam@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.13
Date: Thu, 15 Jan 2009 23:41:08 +0800
Message-ID: <20090115154108.GB6938@b2j>
References: <20090113233643.GA28898@diku.dk> <20090114232456.GA6937@b2j> <20090114235607.GA5546@diku.dk> <20090115014617.GC6937@b2j> <20090115130659.GA18081@diku.dk> <20090115145003.GA6938@b2j> <20090115150841.GA23045@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Thu Jan 15 16:42:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNUMh-00006f-38
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 16:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966AbZAOPlQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2009 10:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754817AbZAOPlP
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 10:41:15 -0500
Received: from ti-out-0910.google.com ([209.85.142.187]:29220 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754405AbZAOPlO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 10:41:14 -0500
Received: by ti-out-0910.google.com with SMTP id b6so634491tic.23
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 07:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6agy4jIYL4Gq6d5e7/xGIvNIwEI3A+dIgYylug2bpIg=;
        b=oGLQNwajPIYwzmI5U3HI5CQUVs7ROig5ywFeU/H3F3edF0A90ICBwnaWQQzmguNgRy
         W/uLhS5vze9uobsR0/iWEoWurZ8zexCVGgnen6IdyrN80S4uJgA9hmzukiF5p4hR1CgB
         PKqb2tu28IkZiREvdYZQnH9p5EKea+KpFV1Rk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=nYqae/wfNRrJVuVEhXqZugEvFPx4I4usFCvduZEganb8d8vupJfwG+67yZIFTFYTOp
         MDYlessnbecLAtcns1V051PnKMOioleyQPPsDRVM3hOC1dE+D8DjFJtEi6KLP32ea8cy
         uUUh+D/eqJh3eoYW33BTCSDWQG2P7Y6cscCac=
Received: by 10.110.2.2 with SMTP id 2mr1812066tib.4.1232034072316;
        Thu, 15 Jan 2009 07:41:12 -0800 (PST)
Received: from localhost (pcd406163.netvigator.com [203.218.196.163])
        by mx.google.com with ESMTPS id u8sm116538tia.28.2009.01.15.07.41.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jan 2009 07:41:11 -0800 (PST)
Mail-Followup-To: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20090115150841.GA23045@diku.dk>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105838>

On Thu, 15 Jan 2009, Jonas Fonseca wrote:
> Then I am puzzled why the configure script doesn't find it. Can you s=
end
> me your config.log and the output of running configure. Maybe off-lis=
t.

I just delete everything and do a git reset --hard, ./configure does
detect ncursesw and link to it.  I'm not sure my previous error was
resulted from config cache.  I ldd tig and confirm indeed it linked to
the unicode version. =20

Sorry for the noise.  m(__)m

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9019 =E5=AD=9F=E6=B5=A9=E7=84=B6  =E5=A4=8F=E6=97=A5=E5=
=8D=97=E4=BA=AD=E6=87=B7=E8=BE=9B=E5=A4=A7
    =E5=B1=B1=E5=85=89=E5=BF=BD=E8=A5=BF=E8=90=BD  =E6=B1=A0=E6=9C=88=E6=
=BC=B8=E6=9D=B1=E4=B8=8A  =E6=95=A3=E9=AB=AE=E4=B9=98=E5=A4=9C=E6=B6=BC=
  =E9=96=8B=E8=BB=92=E8=87=A5=E9=96=91=E6=95=9E  =E8=8D=B7=E9=A2=A8=E9=80=
=81=E9=A6=99=E6=B0=A3  =E7=AB=B9=E9=9C=B2=E6=BB=B4=E6=B8=85=E9=9F=BF
    =E6=AC=B2=E5=8F=96=E9=B3=B4=E7=90=B4=E5=BD=88  =E6=81=A8=E7=84=A1=E7=
=9F=A5=E9=9F=B3=E8=B3=9E  =E6=84=9F=E6=AD=A4=E6=87=B7=E6=95=85=E4=BA=BA=
  =E4=B8=AD=E5=AE=B5=E5=8B=9E=E5=A4=A2=E6=83=B3
