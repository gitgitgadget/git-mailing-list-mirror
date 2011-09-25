From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH/RFC 1/2] is_url: Remove redundant assignment
Date: Sun, 25 Sep 2011 17:26:27 +0800
Message-ID: <CALUzUxp-++A7azzimE1mjvPVoGxRM4rzYt9z66CmFb0B3vi7dQ@mail.gmail.com>
References: <1316927182-14212-1-git-send-email-pangyanhan@gmail.com>
	<1316927182-14212-2-git-send-email-pangyanhan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pang Yan Han <pangyanhan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 25 11:26:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7kz3-0002vu-Kg
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 11:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847Ab1IYJ0n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Sep 2011 05:26:43 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51632 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750Ab1IYJ0n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Sep 2011 05:26:43 -0400
Received: by fxe4 with SMTP id 4so5108478fxe.19
        for <git@vger.kernel.org>; Sun, 25 Sep 2011 02:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=gVEmDmkxZIQQJ5tCM1vSHQw0Tyge/RQGhvQzGw+AQjY=;
        b=R566Yb1VT9Lktw326VtT/78qW1mrjXiS5frvKCVu9/OG8xrlFiHnZR7dBrP2dmtont
         RsCDyBcyYPC99f4afV9cKp/77EOqDuJfOec9PRv+VQ3eE7X9GA8cpnjVQ9e4H2xWVFSB
         iS3RCfV4UnTWLdAHqChhuhajCgCC76XKaS5jY=
Received: by 10.223.53.78 with SMTP id l14mr8432219fag.140.1316942788030; Sun,
 25 Sep 2011 02:26:28 -0700 (PDT)
Received: by 10.223.79.65 with HTTP; Sun, 25 Sep 2011 02:26:27 -0700 (PDT)
In-Reply-To: <1316927182-14212-2-git-send-email-pangyanhan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182062>

On Sun, Sep 25, 2011 at 1:06 PM, Pang Yan Han <pangyanhan@gmail.com> wr=
ote:
> Signed-off-by: Pang Yan Han <pangyanhan@gmail.com>
> ---
> =A0url.c | =A0 =A01 -
> =A01 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/url.c b/url.c
> index 3e06fd3..d2e17e6 100644
> --- a/url.c
> +++ b/url.c
> @@ -22,7 +22,6 @@ int is_url(const char *url)
>
> =A0 =A0 =A0 =A0if (!url)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> - =A0 =A0 =A0 url2 =3D url;
> =A0 =A0 =A0 =A0first_slash =3D strchr(url, '/');
>
> =A0 =A0 =A0 =A0/* Input with no slash at all or slash first can't be =
URL. */

Looks correct. Perhaps you could mention in the patch message that

  There are no operations on url2 until another assignment to it later
at line 41.

--=20
Cheers,
Ray Chuan
