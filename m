From: bill lam <cbill.lam@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.13
Date: Thu, 15 Jan 2009 09:46:17 +0800
Message-ID: <20090115014617.GC6937@b2j>
References: <20090113233643.GA28898@diku.dk> <20090114232456.GA6937@b2j> <20090114235607.GA5546@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Thu Jan 15 02:47:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNHKm-0007il-LC
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 02:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbZAOBqY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jan 2009 20:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbZAOBqY
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 20:46:24 -0500
Received: from ti-out-0910.google.com ([209.85.142.190]:63205 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbZAOBqX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 20:46:23 -0500
Received: by ti-out-0910.google.com with SMTP id b6so430871tic.23
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 17:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=t2L491/TOrH78qEjxoCuSDXpI617j+ChLz8hOO0U8qQ=;
        b=Fn/xuS6SPFfTHBsDylf5Dc3gQeWx6OShLvFG83DUD1JWiIFyGWTnN63YL7GsOankOF
         LsDi7aD+869XlZOXjFsDNfzpWzGYOyH1WlklBOvXxDB6Rl09z00gzNbRo6Ihl+Ki9Ch/
         Ph1tm3xZLjCf3qSN+lB0YtEc9GZAwL1/PEkRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=eHVmDWVlBFQCetJPpO3/EPQ63foaVhcyVIWE1bs39yzOfawY3PG7cRR530TmHHITE9
         fPZH/zQWeHfxH4dFGILcUOaQp0cmbxhX+BcjVN71x7+rPSx372WU8G+5ASdEt7kGJzTy
         LPPptyAa2c0h64zG5jWIfuVJXLrlNH5taRrc4=
Received: by 10.110.14.3 with SMTP id 3mr986508tin.29.1231983981656;
        Wed, 14 Jan 2009 17:46:21 -0800 (PST)
Received: from localhost (pcd406163.netvigator.com [203.218.196.163])
        by mx.google.com with ESMTPS id u12sm2345498tia.9.2009.01.14.17.46.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Jan 2009 17:46:20 -0800 (PST)
Mail-Followup-To: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20090114235607.GA5546@diku.dk>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105757>

On Thu, 15 Jan 2009, Jonas Fonseca wrote:
> Yes, it works. You can either create a file called config.make with a
> line saying:
>=20
> 	LDLIBS =3D -lncursesw
>=20
> or use the configure file. If you are not using the tarball generate =
it
> with:
>=20
> 	make configure

I use the git source. Even after make configure and  ./configure, it
still links to the non-unicode ncurses. Should it make ncursesw as=20
default if detected available albeit this can be changed manually?

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9319 =E6=9D=8E=E7=99=BD  =E6=B8=85=E5=B9=B3=E8=AA=BF=E4=
=B8=89=E9=A6=96=E4=B9=8B=E4=B8=89
    =E5=90=8D=E8=8A=B1=E5=82=BE=E5=9C=8B=E5=85=A9=E7=9B=B8=E6=AD=A1  =E5=
=B8=B8=E5=BE=97=E5=90=9B=E7=8E=8B=E5=B8=B6=E7=AC=91=E7=9C=8B  =E8=A7=A3=
=E9=87=8B=E6=98=A5=E9=A2=A8=E7=84=A1=E9=99=90=E6=81=A8  =E6=B2=88=E9=A6=
=99=E4=BA=AD=E5=8C=97=E5=80=9A=E9=97=8C=E5=B9=B2
