From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 4/6] Turn setup code in t2007-checkout-symlink.sh into a test
Date: Fri, 07 May 2010 13:23:00 -0700 (PDT)
Message-ID: <m3tyqjea33.fsf@localhost.localdomain>
References: <1273261025-31523-1-git-send-email-avarab@gmail.com>
	<1273261025-31523-4-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 22:23:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAU4l-00058w-Eo
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 22:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757083Ab0EGUXE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 16:23:04 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52028 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755667Ab0EGUXC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 16:23:02 -0400
Received: by fxm10 with SMTP id 10so1067957fxm.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 13:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=QX1KI5b4BMCav8j+u29w2n9VTIczv7SpHhmuoJ1EdQ8=;
        b=pnMN/5B57KmU+ByCO6lEaHT0GcTf3vY/K7xJre3AIbNc13VF/IXduwq0C44Ke0fw3V
         9qzRa0q2/Xjb65F8ojwWb2RQjr5XxXKSiVioaLWgMKG/ZUpjrV23IP0VmKqWUNbFXKdF
         NKGw8gjR8pRX5nlqQxt4p5a2DFHqS93h1EVX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=mKWcgCnbNGqfCNiWy0gtoiTS+4unxWllYVMNgGxr3xhVPzhzQggQCgX//rnwEB9KAb
         7SLSxCsC8MOARt1K63BdCFJZSHabphYyKTT0Ygau5w7cqWg3R18FnX1C+ahHBr9uaV4I
         D0ozpBlX2vHww+WXk4qT6XT3jeZM+aYoYx0eE=
Received: by 10.102.14.25 with SMTP id 25mr257855mun.30.1273263780598;
        Fri, 07 May 2010 13:23:00 -0700 (PDT)
Received: from localhost.localdomain (abvc175.neoplus.adsl.tpnet.pl [83.8.200.175])
        by mx.google.com with ESMTPS id 23sm10115554mum.6.2010.05.07.13.22.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 May 2010 13:23:00 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o47KMOYu012597;
	Fri, 7 May 2010 22:22:35 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o47KM8kR012593;
	Fri, 7 May 2010 22:22:08 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1273261025-31523-4-git-send-email-avarab@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146586>

=C6var Arnfj=F6r=F0 Bjarmason  <avarab@gmail.com> writes:

> Previously the test would print to stdout which interfered with the
> TAP output. Now this scaffolding code is just a normal test.
>=20
> Signed-off-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>

That's a good change anyway, independent on the TAP-ification of
output of git test suite.

> ---
>  t/t2007-checkout-symlink.sh |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/t/t2007-checkout-symlink.sh b/t/t2007-checkout-symlink.s=
h
> index 616ca2a..05cc8fd 100755
> --- a/t/t2007-checkout-symlink.sh
> +++ b/t/t2007-checkout-symlink.sh
> @@ -44,8 +44,10 @@ test_expect_success 'switch from symlink to dir' '
> =20
>  '
> =20
> -rm -fr frotz xyzzy nitfol &&
> -git checkout -f master || exit
> +test_expect_success 'Remove temporary directories & switch to master=
' '
> +	rm -fr frotz xyzzy nitfol &&
> +	git checkout -f master
> +'
> =20
>  test_expect_success 'switch from dir to symlink' '
> =20
> --=20
> 1.7.1.dirty
>=20

--=20
Jakub Narebski
Poland
ShadeHawk on #git
