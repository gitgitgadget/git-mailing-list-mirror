From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2] add DEVELOPER makefile knob to check for acknowledged warnings
Date: Fri, 26 Feb 2016 10:26:54 +0100
Message-ID: <F2BED69A-A595-40D5-9A03-4FCE2E67195D@gmail.com>
References: <1456389742-48052-1-git-send-email-larsxschneider@gmail.com> <xmqqd1rkpu2z.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Users <git@vger.kernel.org>, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 10:27:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZEfz-0002GL-5S
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 10:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbcBZJ1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 04:27:01 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33187 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbcBZJ07 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2016 04:26:59 -0500
Received: by mail-wm0-f50.google.com with SMTP id g62so64734112wme.0
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 01:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HdG7OQvdxsXIOQgxh1qvHf0v6efziqtZIsm7ESt0jqg=;
        b=p3W6XPHGq7T/Hl6JEmt5owKPszqsXEm6IaqiiquCF1vdBWMuV+z6pufpSyRG2TVAt3
         LfOCxAAIKXVDAPKKqhJZJKYmJ9ZPIEBUHJ+uZI9HVL2nc2JRspTPmbv8LNVSwx/uNg55
         StQW09gbUp6Gnjw2ZepE82BWzQnz0Mr/ZHXXsyzBmVwMcodH8iZHT3YHsPQsFTWxdxu/
         CNjxiJv31izYneLR/9NT7j37/Zyk/K334yDlZIkBVf7NVeflAiSDIs3jqMtSnia1uGOH
         ctEjLKT+ZzildOQJ4+S03cwLFMIbHFAZwU8IWohAOkMq6yES2nsI2d2MThUWyTIxGhq2
         8Iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HdG7OQvdxsXIOQgxh1qvHf0v6efziqtZIsm7ESt0jqg=;
        b=DrtYRXHPWIC6mZZqZQ9ivHgG18QOCKmk8D4aEp1OzCMUR1IXwkV/C755hWlSTC2YT/
         qBzkoSifBQdetzntQYCobFwV7AhohFBIw1hAnyedxnj/t37HFQGxn0l4YEVdOBn9C+rV
         hgHJxs8appwyhgnb6+/3tOvYzVTbjVsUPDneJEwlKe435Jkb++gYohCuV2ecnI06G9WX
         Er6whEJVObi3AjEUuGDTsl5bIazdyxI0noP6aPX+s7aMED5lDRkPWNDnZcgLS61tg4WR
         edQ+Lfmm0eKFHjoDAXSyTfULXPOq8qjuErST7WnotsoASEiCuGTjnbPH/jE5wRxC3+d5
         j5lw==
X-Gm-Message-State: AD7BkJLqWoLG70HLbUQkhSnw0FmyMeSn7ScVZlKodzdJQsTanH1BjAlQG55En+A9nFOSmQ==
X-Received: by 10.28.53.4 with SMTP id c4mr2091329wma.34.1456478817705;
        Fri, 26 Feb 2016 01:26:57 -0800 (PST)
Received: from [10.32.249.46] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id w17sm2041910wmw.5.2016.02.26.01.26.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Feb 2016 01:26:56 -0800 (PST)
In-Reply-To: <xmqqd1rkpu2z.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287558>

Thanks for the reviews and the fix :-)

Any thought on the "-Wold-style-declaration" problem mentioned in my first v2 email?

- Lars

> On 25 Feb 2016, at 18:40, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Perhaps squash these two while queuing to address comments from you two?
> 
> Thanks.
> 
> Documentation/CodingGuidelines |  3 ++-
> Makefile                       | 18 +++++++++---------
> 2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 1c676c2..0ddd368 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -173,7 +173,8 @@ For C programs:
> 
>  - As a Git developer we assume you have a reasonably modern compiler
>    and we recommend you to enable the DEVELOPER makefile knob to
> -   ensure your patch is clear of all compiler warnings we care about.
> +   ensure your patch is clear of all compiler warnings we care about,
> +   by e.g. "echo DEVELOPER=1 >>config.mak".
> 
>  - We try to support a wide range of C compilers to compile Git with,
>    including old ones. That means that you should not use C99
> diff --git a/Makefile b/Makefile
> index 9eb4032..7dc5b88 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -381,15 +381,15 @@ ALL_LDFLAGS = $(LDFLAGS)
> STRIP ?= strip
> 
> ifdef DEVELOPER
> -	CFLAGS +=	-Werror \
> -				-Wdeclaration-after-statement \
> -				-Wno-format-zero-length \
> -				-Wold-style-definition \
> -				-Woverflow \
> -				-Wpointer-arith \
> -				-Wstrict-prototypes \
> -				-Wunused \
> -				-Wvla
> +CFLAGS += -Werror \
> +	-Wdeclaration-after-statement \
> +	-Wno-format-zero-length \
> +	-Wold-style-definition \
> +	-Woverflow \
> +	-Wpointer-arith \
> +	-Wstrict-prototypes \
> +	-Wunused \
> +	-Wvla
> endif
> 
> # Create as necessary, replace existing, make ranlib unneeded.
