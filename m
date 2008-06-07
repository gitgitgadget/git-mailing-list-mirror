From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Allow the envelope sender to be set via configuration
Date: Sat, 07 Jun 2008 02:10:16 -0700 (PDT)
Message-ID: <m3fxrpy5ji.fsf@localhost.localdomain>
References: <1212824022-31991-1-git-send-email-ask@develooper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-15?q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 11:11:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4uSB-00039x-F9
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 11:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755105AbYFGJKX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Jun 2008 05:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755202AbYFGJKX
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 05:10:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:25500 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754959AbYFGJKV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jun 2008 05:10:21 -0400
Received: by fg-out-1718.google.com with SMTP id 19so914519fgg.17
        for <git@vger.kernel.org>; Sat, 07 Jun 2008 02:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=f6zHqw3xtd6RD9ot6VcEolbfttjEYdRZkeTcatZ3Pa0=;
        b=eEgwMkJs6UrKTUlzaQ5Yk6bqIr9odOwQcx62co9NrlMt8NetCl+9WJppWsb+FBvpCJ
         WRvvrv9pH7lZgJ7GeBaF5TK4WoIwW+kdZWGLeM4kQb3ZDf38pJmhig868RIrzkCUx01t
         d9s5h/i0ZUidYcNbh8yefqqZ52LSvxoFV++OE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=aOFzQ+F1Y79SMiCLGPD3aEBm3FGYXeN8yXwSBP2v0CNIO1WLKqkDsNCtvcU7W57LI4
         9Tf1Xs9ko17ea4rDoTZBUD8G5L1kmf+uP8Wm1Fx5jbRSzf9eblooCRx+fobr7FBXQ7/i
         T5FCkvPX0qgHPsSzpu3FrQFULx5m3CeFRIXcc=
Received: by 10.86.90.13 with SMTP id n13mr1592101fgb.3.1212829818323;
        Sat, 07 Jun 2008 02:10:18 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.218.155])
        by mx.google.com with ESMTPS id 4sm7039242fge.5.2008.06.07.02.10.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Jun 2008 02:10:16 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m579ABon031656;
	Sat, 7 Jun 2008 11:10:12 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m579AAwe031653;
	Sat, 7 Jun 2008 11:10:10 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1212824022-31991-1-git-send-email-ask@develooper.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84189>

Ask Bj=F8rn Hansen <ask@develooper.com> writes:

> ---
>  git-send-email.perl |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/git-send-email.perl b/git-send-email.perl
> index a598fdc..ec69c23 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -209,6 +209,7 @@ my %config_settings =3D (
>      "bcc" =3D> \@bcclist,
>      "aliasesfile" =3D> \@alias_files,
>      "suppresscc" =3D> \@suppress_cc,
> +    "envelopesender" =3D> \$envelope_sender,
>  );
> =20
>  # Handle Uncouth Termination

Thanks. Documentation, pretty please?

--=20
Jakub Narebski
Poland
ShadeHawk on #git
