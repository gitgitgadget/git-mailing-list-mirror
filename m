From: Robert Schiele <rschiele@gmail.com>
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Mon, 1 Sep 2008 06:22:50 +0200
Message-ID: <20080901042249.GI7185@schiele.dyndns.org>
References: <20080830173947.GF7185@schiele.dyndns.org> <7v63ph40at.fsf@gitster.siamese.dyndns.org> <32541b130808311129u79f4179enfabab8f5845ed522@mail.gmail.com> <200808312223.38222.jnareb@gmail.com> <20080831203427.GF10360@machine.or.cz> <48BB683F.6020308@zytor.com>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kjpMrWxdCilgNbo1"
Cc: Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Lea Wiemann <lewiemann@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 06:24:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka0xV-0001nc-7M
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 06:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbYIAEW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 00:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbYIAEW5
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 00:22:57 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:63943 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbYIAEW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 00:22:56 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1210640fgg.17
        for <git@vger.kernel.org>; Sun, 31 Aug 2008 21:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:from:reply-to;
        bh=ddmiYROkG/mF8o8rJCZFBwxxPJzAv83KHVoGrD3x9KE=;
        b=Uv8M71TuE1acJBJL1IOl07PHgp1rtjNOHijnibeVid6J/9IzUbpQeyj5Pne65T7j4U
         KdXoy2A/5fV2coM2g6lU9VLGTPJm8RMwrk0Po4etju+y7TqYUTd5+qbseiHVEkadRu+W
         QhwXbs+tz9+hrBP1n2TT0HLXbQEgYi3f/94EE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent:from:reply-to;
        b=QKNHuZQi6Vqt01SjtoM0TK9f6U32tcM9mM2wDbZhpSYdKJJb6/t3PZ3frpxXNfw17n
         8FeNDknZHR2C3IDefC7afz36zLSZiw5GFNO0WT5wi35NvqZ6RHIMfiVOZKcPHLrJUYUt
         fac9axjMRZgdyO+ZLt3Qrhf8vbtCx2GnP81S0=
Received: by 10.103.23.4 with SMTP id a4mr3962358muj.17.1220242973360;
        Sun, 31 Aug 2008 21:22:53 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [91.18.65.57])
        by mx.google.com with ESMTPS id j10sm8461210mue.17.2008.08.31.21.22.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Aug 2008 21:22:52 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 4520017D4E; Mon,  1 Sep 2008 06:22:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48BB683F.6020308@zytor.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94529>


--kjpMrWxdCilgNbo1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 31, 2008 at 08:57:51PM -0700, H. Peter Anvin wrote:
> I believe RHEL4 is Perl 5.6.1, but I could be wrong.

No, that's 5.8.5.  RHEL3 is 5.8.0.  RHEL2 is what you are talking about.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--kjpMrWxdCilgNbo1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQFIu24ZxcDFxyGNGNcRApnTAKDf0RkWxQceYmoiqYEu0i2AwBVJSwCg4ZAd
xA+NT9HovrRLSCAT0Tz5IRY=
=KsgE
-----END PGP SIGNATURE-----

--kjpMrWxdCilgNbo1--
