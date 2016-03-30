From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 2/2 V2] MSVC: VS2013 comes with inttypes.h
Date: Wed, 30 Mar 2016 10:52:09 +0200
Message-ID: <56FB93B9.7090306@gmail.com>
References: <56FAACD4.9080504@cs-ware.de> <56FAB9FD.7080409@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Sven Strickroth <sven@cs-ware.de>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, blees@dcon.de
X-From: git-owner@vger.kernel.org Wed Mar 30 10:52:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alBrR-0001xu-QU
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 10:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758810AbcC3IwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 04:52:16 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36856 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbcC3IwM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 04:52:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id 20so12604802wmh.3
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 01:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=MQ74Lh/QnOaYFhtjlxXEO/CgZTjvLG/FlsNBG5JOcFc=;
        b=QqAvXm1oDQUgfd6DtlsaUrGwdcTf2wWIjOl6l+QS4E/lc3U5t6Gl8mxqPVtblUw5id
         HiVIZmEKMlntV921bQIlEc96xPlwLFjzTZ11S2liURt98SK7Qd7cHSu5JRXwM2s/qTzC
         wxC6U6iz4yfs2hH0fTfu5NqaUtgjmx9HUmsEC+DzmZid6Nd1IVzCpdgB1ClzVcsWNEs1
         KE4ebiXr3Cp5FidPiO7e77gy6Q1DtHqV+P1XXAeXae8Prn2XHPSdIB6B3qCb5vZkEx+H
         uYBAE+4NeYYka/7GWAV/6GYxu8Ld9wC9tBhtWucglbd7ncqtTq1EwdYG0t6sXRWSiFzT
         KI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:newsgroups:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=MQ74Lh/QnOaYFhtjlxXEO/CgZTjvLG/FlsNBG5JOcFc=;
        b=KgUQ7x8W7Z36i8fKsSslyH87LVuVAryrFWx6NhJdSNidiXzQC+6oJRR0jN1nlNtRlp
         Q/O3TT89yG9Oj7QCzKQc5rrvO2m3fa2Pp8RD+0De3w7f7Ekri0vMjIwJ9Prf8kiY1M7j
         UD7zxc1AOxgNJ/j9OSCnNqOAwLkVrsWqVG/r/RHHmoNxTeUWOgzcSDx5Z/ymKPOWCevr
         CrDfflJYS9OZtRi5NoA7VswcY+vwoDU2LL+AxveAzR87ndWlFq0pEqJqvvWfDWnZxKKg
         l3fOikrb6tbi8zJuOik/XCQ/5pMEXsAyssjR3700pk8+ED/fIGu6qQ9mGZfrfC0a9lVa
         /8vw==
X-Gm-Message-State: AD7BkJJJQDDJbETpVTOh6vKChzVd5VR2+Yegi81hSfNZYdGLsEOktNPWabMhWKdfgLs8Nw==
X-Received: by 10.28.139.129 with SMTP id n123mr8510535wmd.13.1459327931412;
        Wed, 30 Mar 2016 01:52:11 -0700 (PDT)
Received: from [10.223.62.205] ([131.228.216.133])
        by smtp.googlemail.com with ESMTPSA id m141sm18632733wma.3.2016.03.30.01.52.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2016 01:52:10 -0700 (PDT)
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <56FAB9FD.7080409@cs-ware.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290279>

On 3/29/2016 19:23, Sven Strickroth wrote:

> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -415,7 +415,7 @@ int mingw_offset_1st_component(const char *path);
>   extern void build_libgit_environment(void);
>   extern const char *program_data_config(void);
>   #define git_program_data_config program_data_config
> -#ifndef __MINGW64_VERSION_MAJOR
> +#if !defined(__MINGW64_VERSION_MAJOR) && (!defined(_MSC_VER) || _MSC_VER < 1800)
>   #define PRIuMAX "I64u"
>   #define PRId64 "I64d"
>   #else

ACK for this part. For reference see [1].

> diff --git a/compat/vcbuild/include/unistd.h b/compat/vcbuild/include/unistd.h
> index c65c2cd..b7cc48c 100644
> --- a/compat/vcbuild/include/unistd.h
> +++ b/compat/vcbuild/include/unistd.h
> @@ -45,11 +45,15 @@ typedef unsigned long long uintmax_t;
>   
>   typedef int64_t off64_t;
>   
> +#if !defined(_MSC_VER) || _MSC_VER < 1800
>   #define INTMAX_MIN  _I64_MIN
>   #define INTMAX_MAX  _I64_MAX
>   #define UINTMAX_MAX _UI64_MAX
>   
>   #define UINT32_MAX 0xffffffff  /* 4294967295U */
> +#else
> +#include<inttypes.h>
> +#endif

If we would do "#include <stdint.h>" here instead, we could lower the _MSC_VER requirement to at least 1700. According to the comment at [2] we could lower it even to 1600.

Also the original code is missing a single space after "#include".

[1] https://blogs.msdn.microsoft.com/vcblog/2013/07/19/c99-library-support-in-visual-studio-2013/
[2] https://stackoverflow.com/questions/126279/c99-stdint-h-header-and-ms-visual-studio#comment4620359_126279

Regards,
Sebastian
