From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 4 Sep 2010 23:16:30 +0200
Message-ID: <201009042316.38655.jnareb@gmail.com>
References: <AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com> <m3tym5mfce.fsf@localhost.localdomain> <AANLkTimhCi2vWWnHGwT5ToRtFbjkxTgVYVvYLR3UCb2S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Ted Ts'o" <tytso@mit.edu>, Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 23:17:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os06w-0000hg-52
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 23:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502Ab0IDVQ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 17:16:57 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36173 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051Ab0IDVQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 17:16:56 -0400
Received: by fxm13 with SMTP id 13so1918993fxm.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 14:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=unBx27OB+2e4AbAG3VQU6zpUqEkB+Xa+db2YDlav6zs=;
        b=pbCRL1EaMhEJfUdEaGPdMKOhcpnsDXBHGwurUWbYAzPwuGqEzhcox+gzgTrLlYz4Yr
         TOBghSzX/vBvSPXsKKU1r7yuW+Wa6nLmFWkakD5gKr7Bt3RSjl074rT//813mL29f5KX
         qeqHEcXcMO8LarDjB2TkFKtAYwnVno3zu/BAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=rZuRMadjfaE/+bQ7XxXu7O3yuHEDwVlJEg3C+98iOqhaM3Foq20hpj+hbuHeVgpWf+
         kPlBUbqG5+4AMMl2Da9TOZe8Q9SzgiSS04yOfMK+OVnyWsxEbLuKoTFP5UemkM5FCkdb
         GDIk+uo/7UCFNBRsUdZbYTTZ2ojI1U35X/mbQ=
Received: by 10.223.119.70 with SMTP id y6mr1097553faq.65.1283635015149;
        Sat, 04 Sep 2010 14:16:55 -0700 (PDT)
Received: from [192.168.1.13] (abwp23.neoplus.adsl.tpnet.pl [83.8.239.23])
        by mx.google.com with ESMTPS id u8sm1582206fah.12.2010.09.04.14.16.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 14:16:54 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTimhCi2vWWnHGwT5ToRtFbjkxTgVYVvYLR3UCb2S@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155359>

On Sat, Sep 4, 2010, Luke Kenneth Casson Leighton wrote:
> On Sat, Sep 4, 2010 at 9:20 PM, Jakub Narebski <jnareb@gmail.com> wro=
te:
>=20
> > Luke, you don't have to be peer-to-peer to be decentralized and
> > distributed. =C2=A0People from what I understand bitch most about
> > centralized (and closed) services.
>=20
> i've covered this in the FAQ i wrote:
>=20
> FAQ:
>=20
> Q: is git a "distributed source control system"?
> A: yeees, but the "distribution" part has to be done the hard way,
>    by setting up servers, forcing developers and users to configure
>    git to use those [single-point-of-failure] servers.  so it's
>    "more correct" to say that git is a "distributable" source control
>    system.
=20
"Distributed" is not equivalent to "peer to peer".
=20
> so if you believe that git is "distributed" just because people can
> set up a server.... mmm :)  i'd say that your administrative and
> technical skills are way above the average persons' capabilities.

Git is distributed at least in the sense that it is opposite
to centralized version control systems (like Subversion)
where you have and can have only single server with full repository.

Setting up server (git, smart HTTP, ssh) is not that hard.

> proper peer-to-peer networking infrastructure takes care of things
> like firewall-busting, by using UPnP automatically, as part of the
> infrastructure.

With "smart" HTTP transport support there is no need for any=20
firewall-busting.
=20
> come on, people - _think_.  we're so used to being able to run our ow=
n
> infrastructure and workaround problems or server down-time, but most
> people still use "winzip", if they have any kind of revision control
> _at all_.

In what way this paragraph refers to and is relewant with respect to
discussion in this subthread?

::plonk::
--=20
Jakub Narebski
Poland
