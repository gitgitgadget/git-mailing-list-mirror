From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] More typofixes.
Date: Mon, 29 Jul 2013 15:56:31 +0530
Message-ID: <CALkWK0m_vaOK6vDaauMsaUh91mDNqeyz2kDvFNoq+ruwztvDiA@mail.gmail.com>
References: <20130729081821.GA6758@domone.kolej.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
X-From: git-owner@vger.kernel.org Mon Jul 29 12:27:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3kfc-0001w6-ST
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 12:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579Ab3G2K1N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Jul 2013 06:27:13 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:40769 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab3G2K1M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jul 2013 06:27:12 -0400
Received: by mail-oa0-f50.google.com with SMTP id k7so12871393oag.9
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 03:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=cOFktBVHRA+4wePAHANxQWRizgTmulzex7ElL67pjJo=;
        b=WjEerO49adCNUExv0ecN4LGwzkolxcTrzc8QWP4uaQRvpmC+r8ul+JNwCh0HjMQb2w
         WG7+L5D+pF6mGvd6w8HDcuqe54wY7yk6iFZrWuT1KWS9KH0MZCzucTLodaX6RbmZABI5
         Cib83lt2Qm+TIKrQpLCQVeuKQokWlkXE6j7MFG/DE0OsNisg7fwvqWB/yUqHeSdjXXwo
         GD34P69kGjB2oNK1VpHUzTjv8tnIlADCD446Yinw2ljpXJ8LkCibXzdBJSZfhh1u8hfS
         pKr24d7QnlnxWfD/NVIaBqWlm9f4WlXhu+rN0JB5pCZkql3O4J5HH5Z3c5jgaviF9NWY
         J6+Q==
X-Received: by 10.50.72.73 with SMTP id b9mr910074igv.50.1375093631683; Mon,
 29 Jul 2013 03:27:11 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Mon, 29 Jul 2013 03:26:31 -0700 (PDT)
In-Reply-To: <20130729081821.GA6758@domone.kolej.mff.cuni.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231281>

Ond=C5=99ej B=C3=ADlka wrote:
> diff --git a/builtin/log.c b/builtin/log.c
> index 2625f98..01b49b3 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -304,7 +304,7 @@ static void setup_early_output(struct rev_info *r=
ev)
>          * tenth of a second, don't even bother doing the
>          * early-output thing..
>          *
> -        * This is a one-time-only trigger.
> +        * This is an one-time-only trigger.

I didn't look through your patch in detail, but this one caught my
eye: it's incorrect.
