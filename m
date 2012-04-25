From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/10] i18n: apply: mark strings for translation
Date: Wed, 25 Apr 2012 15:50:11 -0700
Message-ID: <xmqqehrbbf4s.fsf@junio.mtv.corp.google.com>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
	<1335184230-8870-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 00:50:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNB2T-0003bN-3X
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 00:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433Ab2DYWuO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Apr 2012 18:50:14 -0400
Received: from mail-yx0-f202.google.com ([209.85.213.202]:61341 "EHLO
	mail-yx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932352Ab2DYWuM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Apr 2012 18:50:12 -0400
Received: by yenq2 with SMTP id q2so84949yen.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 15:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=HFLf+25GGlleYtBNtoanvkBP63AgG3pjtYpg2L0FAYE=;
        b=oiH14UhH4OTEm4I+OV1iZCAEAG9Vq/o1fqfbmB6KMjgtx66E9qA8/wE4uKGIX41S2+
         qVhmXrACks0VOw+d2HgAIFaplkZ3ZJefyXvzxXXxObXCSgZVedN0dhlbdmSIkSjTwms4
         xPY0OTVluIoxoK3+nUiBBxf6comfCDFYoOgo1Vx0b3QkVG6mYyHEeTvT3BaLKz0Trisk
         oyAcZo/ZKqaAEkY+pNN9WQjGJH9L0pQcHaid8lKPi5wIgMcXFkrpIAyROVQJPnz6RmQz
         sMzZHRe0q9ru9YYhE8bg7rA5lOiaq2ZKnOwWBuO4vW1yvpJ4I/ddG4AZ0gIAHlA7JXnd
         cH4g==
Received: by 10.236.118.37 with SMTP id k25mr7516923yhh.3.1335394211871;
        Wed, 25 Apr 2012 15:50:11 -0700 (PDT)
Received: by 10.236.118.37 with SMTP id k25mr7516873yhh.3.1335394211644;
        Wed, 25 Apr 2012 15:50:11 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id k54si1065835yhh.5.2012.04.25.15.50.11
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 25 Apr 2012 15:50:11 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 884621E0758;
	Wed, 25 Apr 2012 15:50:11 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 33759E125C; Wed, 25 Apr 2012 15:50:11 -0700 (PDT)
In-Reply-To: <1335184230-8870-8-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 23
 Apr 2012 19:30:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQnUtOFj2tPtfwiQxjNmtC0KZxAVgIZvFfjsH8WdKj+Ia0xdb8uc8wXIv/uTzUNtOtl5tan3ys6AqNexENGUfODMtcmYK4aMiouyOcP8C/uuBpQoR27Oz46wiJxJN1CtzNvasQA1v0/3yv5FIsgYQ4nq2HV3bYqg7+TasbBbNleURlh9bkY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196344>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> @@ -886,17 +886,17 @@ static char *gitdiff_verify_name(const char *li=
ne, int isnull, char *orig_name,
> ...
>  		if (!another || memcmp(another, name, len + 1))
> -			die("git apply: bad git-diff - inconsistent %s filename on line %=
d", oldnew, linenr);
> +			die(_("git apply: bad git-diff - inconsistent %s filename on line=
 %d"), oldnew, linenr);
>  		free(another);
>  		return orig_name;
>  	}

In this function, the parameter oldnew has "old" or "new" and the
callers (gitdiff_oldname() and gitdiff_newname()) do not have it marked
for translation.  Even if they did, it would result in a lego
composition, so you may have to switch between two translatable message=
s
here.
