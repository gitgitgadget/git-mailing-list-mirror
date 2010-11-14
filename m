From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCHv2 0/2] Fix username and password extraction from HTTP URLs
Date: Sun, 14 Nov 2010 20:27:50 +0800
Message-ID: <AANLkTi=WPyDOtcfNhzgkmekkT6vPwBR3OM5Z83XkSaSq@mail.gmail.com>
References: <1289699475-11364-1-git-send-email-gabriel.corona@enst-bretagne.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, srabbelier@gmail.com
To: Gabriel Corona <gabriel.corona@enst-bretagne.fr>
X-From: git-owner@vger.kernel.org Sun Nov 14 13:27:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHbgb-00086x-J4
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 13:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401Ab0KNM1w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 07:27:52 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51805 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755370Ab0KNM1v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Nov 2010 07:27:51 -0500
Received: by eye27 with SMTP id 27so2585069eye.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 04:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=q8ROlFnWP08qKxF5daFWGsdmKyt4mD8QisdwGJuCvyU=;
        b=m0ySjJyGRZd/xdGKUJMJj/bt7zqCidpG7RrqDYUwv5PG25QMWEkmiqWBigNxnUBC24
         SXRu9a9xhzIzYYdwzH4HxG0EfOVemb7iubT0vI0KsENh4ycKR1dlGg48zRKJ0AM+CZrn
         DAdSGQhh+SsL1JC2qF/uKbPLl52US4f8vlpdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jOdR0vCM7lerMLyrBav6uX6/HncqGWwPEZ3Z7DaJ8EdM7JFdOquFmuT2YAJKxktXfF
         wNjhLxy/MjH49OaH8dHtpH19+Jt6Hbe5x8GyKOWdvkUz6qjOLjkVvtMUrjyWUxfB8/fR
         SucA3CGKBM3o5TRRtwyKxEmWB7AlRbb3zSHBc=
Received: by 10.213.26.14 with SMTP id b14mr4829571ebc.15.1289737670551; Sun,
 14 Nov 2010 04:27:50 -0800 (PST)
Received: by 10.213.112.195 with HTTP; Sun, 14 Nov 2010 04:27:50 -0800 (PST)
In-Reply-To: <1289699475-11364-1-git-send-email-gabriel.corona@enst-bretagne.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161408>

On Sun, Nov 14, 2010 at 9:51 AM, Gabriel Corona
<gabriel.corona@enst-bretagne.fr> wrote:
> Percent-decode username and password in HTTP URLs. This is necessary
> to specify a username with a '@' character in the URL.
>
> Gabriel Corona (2):
> =A0t5550: test HTTP authentication and userinfo decoding
> =A0Fix username and password extraction from HTTP URLs
>
> =A0http.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 12 +++++++++++-
> =A0t/lib-httpd.sh =A0 =A0 =A0 =A0 =A0| =A0 =A03 +++
> =A0t/lib-httpd/apache.conf | =A0 29 +++++++++++++++++++++++++++++
> =A0t/lib-httpd/passwd =A0 =A0 =A0| =A0 =A01 +
> =A0t/t5550-http-fetch.sh =A0 | =A0 =A07 +++++++
> =A05 files changed, 51 insertions(+), 1 deletions(-)
> =A0create mode 100644 t/lib-httpd/passwd

Although the esotericity of having non-alphanumeric symbols in user
names escapes me, both look good.

  Acked-by: Tay Ray Chuan <rctay89@gmail.com>

--=20
Cheers,
Ray Chuan
