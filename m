From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] convert.c: Fix return type of git_path_check_eol()
Date: Tue, 22 Nov 2011 07:33:30 +0530
Message-ID: <CALkWK0=XMOivrQDkoCCBPNJ1JWnCJiGmDVmjGZHZz+X2C1P07A@mail.gmail.com>
References: <4ECA9B81.9070101@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Nov 22 03:03:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSfiH-0000x8-4w
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 03:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756905Ab1KVCDw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Nov 2011 21:03:52 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41878 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755320Ab1KVCDw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2011 21:03:52 -0500
Received: by wwe5 with SMTP id 5so11509964wwe.1
        for <git@vger.kernel.org>; Mon, 21 Nov 2011 18:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=cECf7nw5eVQiOpSFJ9RHnxWmyrWKhDYpOXDdQfqpoug=;
        b=E14Qu7Uyyir97oovSzV1FJRoY2P0oFfb6RJejV1w2HF3qc0zx+HrIkUBPDzUCy9rP3
         5UTcNwsjyKQbJXXgeXs4Utaz6wFd7eeR5usy5SuHEiTMbLe3+MV+WiF2dAqiEwxQku1K
         WNYw5YmZH5I76xwawh4K/oGaGgys4PzpH5LR8=
Received: by 10.227.208.81 with SMTP id gb17mr10823659wbb.24.1321927431137;
 Mon, 21 Nov 2011 18:03:51 -0800 (PST)
Received: by 10.216.176.13 with HTTP; Mon, 21 Nov 2011 18:03:30 -0800 (PST)
In-Reply-To: <4ECA9B81.9070101@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185773>

Hi Ramsay,

Ramsay Jones wrote:
> [...]
> diff --git a/convert.c b/convert.c
> index 038b0be..86e9c29 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -658,7 +658,7 @@ static enum crlf_action git_path_check_crlf(const=
 char *path, struct git_attr_ch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return CRLF_GUESS;
> =C2=A0}
>
> -static enum crlf_action git_path_check_eol(const char *path, struct =
git_attr_check *check)
> +static enum eol git_path_check_eol(const char *path, struct git_attr=
_check *check)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *value =3D check->value;
>

Looks good.  Thanks.

-- Ram
