From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v4 23/23] compat/mingw.h: Fix the MinGW and msvc builds
Date: Wed, 25 Dec 2013 23:08:57 +0100
Message-ID: <CABPQNSa+mtVoMiN_mxVfYW_=JMxO-0Odv5uLnGhknNhDq1yWrw@mail.gmail.com>
References: <20131221135651.GA20818@sigill.intra.peff.net> <20131221140052.GW21145@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 25 23:10:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VvweN-00027w-Rj
	for gcvg-git-2@plane.gmane.org; Wed, 25 Dec 2013 23:10:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410Ab3LYWJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Dec 2013 17:09:39 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:62490 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294Ab3LYWJi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Dec 2013 17:09:38 -0500
Received: by mail-ie0-f180.google.com with SMTP id tp5so7811660ieb.25
        for <git@vger.kernel.org>; Wed, 25 Dec 2013 14:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=jIpVvV604mIHs2ECZ+8ZUOblHuwU4S4OzFZ5fUV4fJo=;
        b=ogaI5sEia/aYTyqkt/iEUh77v1d6mIT2n6cgPaJ6jg4YrylvFx1EsbqXUlKRBg0CQv
         EUHE2tXBGjsns3ENMXNNIsFTO+1I/zkG6yMe+KsuK/UdR5nBPQEqXZqgDhLUXDlQfJDH
         G17alipNtVYX4cgaCepsnV6169HIAGYWD6rovwB27yS3tgIaWHaPNfL68ZsXnaf0q7Lv
         zGmS12hZ59s1jKYrfh6Uu3kdD4zl/1uNu1YXB1RiqPZHFZg698YwBYwR6tCQEJJE930g
         Q6rteWp/LV1aEjjB2JAd4HgrZQIRFAcGyJYn0EXad+41X9+A1qk98w8jGM0dD2ySvunQ
         sdrw==
X-Received: by 10.50.87.33 with SMTP id u1mr31017627igz.42.1388009377906; Wed,
 25 Dec 2013 14:09:37 -0800 (PST)
Received: by 10.64.249.33 with HTTP; Wed, 25 Dec 2013 14:08:57 -0800 (PST)
In-Reply-To: <20131221140052.GW21145@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239680>

On Sat, Dec 21, 2013 at 3:00 PM, Jeff King <peff@peff.net> wrote:
> From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  compat/mingw.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 92cd728..8828ede 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -345,6 +345,7 @@ static inline char *mingw_find_last_dir_sep(const char *path)
>  #define PATH_SEP ';'
>  #define PRIuMAX "I64u"
>  #define PRId64 "I64d"
> +#define PRIx64 "I64x"
>

Please, move this before patch #8, and adjust the commit message.
