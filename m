From: tsuna <tsunanet@gmail.com>
Subject: Re: [PATCH] Undefine strlcpy if needed.
Date: Sun, 24 Aug 2014 04:13:42 -0700
Message-ID: <CAFKYj4dQhGgpS9Vf=5qoku49jEkR0ko7TuBNu4sQAJyiD7y+cg@mail.gmail.com>
References: <1408854741-13956-1-git-send-email-tsunanet@gmail.com>
 <1408854930-14322-1-git-send-email-tsunanet@gmail.com> <53F9C818.8020607@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Aug 24 13:14:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLVkT-0004HU-GL
	for gcvg-git-2@plane.gmane.org; Sun, 24 Aug 2014 13:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbaHXLOF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Aug 2014 07:14:05 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:37404 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376AbaHXLOE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Aug 2014 07:14:04 -0400
Received: by mail-oa0-f45.google.com with SMTP id i7so10019183oag.32
        for <git@vger.kernel.org>; Sun, 24 Aug 2014 04:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=/Vbly4FksU8X1HNi2OJTAgL1QLhkWxPq3zbpi6DcBXw=;
        b=Gq8Y/rkDmIjuqaoXUuIUyJw+YgFkTOb/CKAnsRCCWzjX8ffLeavxICz0BBorkbF/7G
         QUGymP4H+wIuKfFOfKLEo5SaC5Sirtg5K3/W5m6jOKMkE/tod7wJh1t42dJWQfWzszaE
         Zi5Kt/61fvy78wH1qCiEtUlm/HC7HV+jvg5M9yR2m5dAlI46O6HQoqFymUVh1m4bal48
         OEDhu7H1+J14/2WwUqEhKKvM+13uo68VRBRDI9z6bObYJNybQZs8s526Q4qI3+GlGHPo
         8PhkPHcldP0QoZUN8r7XTVyMsG1JEVTDo3P1IxEbPoetsygcvFmifxUAjc1T6dTVovwy
         l0xA==
X-Received: by 10.182.29.234 with SMTP id n10mr695527obh.67.1408878843029;
 Sun, 24 Aug 2014 04:14:03 -0700 (PDT)
Received: by 10.182.188.37 with HTTP; Sun, 24 Aug 2014 04:13:42 -0700 (PDT)
In-Reply-To: <53F9C818.8020607@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255787>

On Sun, Aug 24, 2014 at 4:10 AM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
> Hmm, which version of OS X are we talking about?

OS X 10.9.4:

$ uname -a
Darwin damogran.local 13.3.0 Darwin Kernel Version 13.3.0: Tue Jun  3
21:27:35 PDT 2014; root:xnu-2422.110.17~1/RELEASE_X86_64 x86_64

> config.mak.uname contains this:
>
>         ifeq ($(shell expr "$(uname_R)" : '[15]\.'),2)
>                 NO_STRLCPY =3D YesPlease
>
> What does ./configure put in config.mak.autogen for NO_STRLCPY?

NO_STRLCPY=3D

I guess I saw all the warnings because I did just a =E2=80=9Cgit pull =E2=
=80=94rebase
&& make -j8=E2=80=9D without running =E2=80=9Cmake configure && ./confi=
gure=E2=80=9D.

--=20
Benoit "tsuna" Sigoure
