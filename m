From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Is there interest in reading ~/.gitconfig.d/* and  /etc/gitconfig.d/*?
Date: Tue, 06 Apr 2010 02:02:26 -0700 (PDT)
Message-ID: <m36345hs4d.fsf@localhost.localdomain>
References: <z2s51dd1af81004011420ka5d3a800kf6b3e4591527fc12@mail.gmail.com>
	<alpine.DEB.2.00.1004040922500.30612@perkele.intern.softwolves.pp.se>
	<19384.17579.205005.86711@winooski.ccs.neu.edu>
	<u2i51dd1af81004060115t5f837840z5adcf83622fa8882@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eli Barzilay <eli@barzilay.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 11:02:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz4g8-00042M-Ay
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 11:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108Ab0DFJCb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 05:02:31 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:16958 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617Ab0DFJCa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 05:02:30 -0400
Received: by fg-out-1718.google.com with SMTP id 19so928977fgg.1
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 02:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=kBr/STGbF++B301+w0UkKUAH61WVSXoygUpftWhgW3E=;
        b=Frypj28QLTAZ22hUTj9AUTPfgEqRh3Y3t13YdNxcY4DOtVkG6DuLTJUccvC0HfMmzd
         6mLOJxqKXjtFsOurKXjqxILAx/0ncQ+AzLxNj729+EdtaDMC9wouwzFk32UaRaqWaCwP
         oQ37vIge9vhqxXQ1vaL2fwA/v2SDZXypHtloA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=Dg7Ctkls5OU2EmlpPqqJCjVMGuSm+F3AX6zO8gC1bAHvEaxEaZmu0d7Bi3wEYKymTY
         4qwyaQgjMOSc/iPKxb6iCILe3XLNj8a87pEWfAoG4ng/isRfZOkpakbAkK80V8nFRgcl
         QusKf2f9aOFVgHDtDcXiYhQlHKC80+HB2J2Bc=
Received: by 10.86.124.35 with SMTP id w35mr10627108fgc.49.1270544548281;
        Tue, 06 Apr 2010 02:02:28 -0700 (PDT)
Received: from localhost.localdomain (abwr38.neoplus.adsl.tpnet.pl [83.8.241.38])
        by mx.google.com with ESMTPS id 14sm8491567fxm.1.2010.04.06.02.02.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Apr 2010 02:02:26 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3691lnn025265;
	Tue, 6 Apr 2010 11:01:58 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3691OUY025255;
	Tue, 6 Apr 2010 11:01:24 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <u2i51dd1af81004060115t5f837840z5adcf83622fa8882@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144118>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
> On Sun, Apr 4, 2010 at 07:50, Eli Barzilay <eli@barzilay.org> wrote:

> > Isn't it better to have a way to include files instead?
>=20
> Probably yes. Programs like Apache HTTPD, rsyslog and others just use
> ${foo}conf.d by convention by supporting config inclusion.
>=20
> What would be the ideal config syntax for that? AFAICT git-config
> doesn't (yet) support top-level keys so maybe this:
>=20
>     [INCLUDE]
>         path =3D ~/.gitconfig.d/*
>=20
> Or if top-level support was added:
>=20
>     INCLUDE =3D ~/.gitconfig.d/*

<bikeshedding mode on>

I think that it would be better to use

        include ~/.gitconfig.d/*

<bikeshedding mode off>
--=20
Jakub Narebski
Poland
ShadeHawk on #git
