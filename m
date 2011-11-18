From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 8/8] Enable GIT_DEBUG_MEMCHECK on git_pathname()
Date: Fri, 18 Nov 2011 07:16:13 +0100
Message-ID: <CALKQrgfTKmSd8se3n3xq89SXRmNPm3qz3Ckv2mUghot8kStKxA@mail.gmail.com>
References: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
	<1321522335-24193-9-git-send-email-pclouds@gmail.com>
	<CALkWK0ndE1Q_jNSV7CBB5W2NyVhcy7kgNO5woWWOw6CXx3cxcA@mail.gmail.com>
	<20111117134201.GA30718@sigill.intra.peff.net>
	<CACsJy8A25SyLVKv8GwkYaHBJwU5tHqgdJK6L-upF9HWseFzCtQ@mail.gmail.com>
	<20111118012746.GA22485@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 07:16:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRHkN-0007VN-3Z
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 07:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756783Ab1KRGQT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Nov 2011 01:16:19 -0500
Received: from locusts.copyleft.no ([178.255.144.241]:55498 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756696Ab1KRGQS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2011 01:16:18 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1RRHkG-000Eh4-RW
	for git@vger.kernel.org; Fri, 18 Nov 2011 07:16:17 +0100
Received: by iage36 with SMTP id e36so3191757iag.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 22:16:13 -0800 (PST)
Received: by 10.43.53.1 with SMTP id vo1mr1307586icb.2.1321596973506; Thu, 17
 Nov 2011 22:16:13 -0800 (PST)
Received: by 10.42.229.193 with HTTP; Thu, 17 Nov 2011 22:16:13 -0800 (PST)
In-Reply-To: <20111118012746.GA22485@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185636>

On Fri, Nov 18, 2011 at 02:27, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Subject: notes merge: eliminate OUTPUT macro
>
> The macro is variadic, which breaks support for pre-C99 compilers,
> and it hides an "if", which can make code hard to understand on
> first reading if some arguments have side-effects.
>
> The OUTPUT macro seems to have been inspired by the "output" function
> from merge-recursive. =C2=A0But that function in merge-recursive exis=
ts to
> indent output based on the level of recursion and there is no similar
> justification for such a function in "notes merge".
>
> Noticed with 'make CC=3D"gcc -std=3Dc89 -pedantic"':
>
> =C2=A0notes-merge.c:24:22: warning: anonymous variadic macros were in=
troduced in C99 [-Wvariadic-macros]
>
> Encouraged-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Acked-by: Johan Herland <johan@herland.net>

--=20
Johan Herland, <johan@herland.net>
www.herland.net
