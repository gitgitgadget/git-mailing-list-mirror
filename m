From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 4/4] Add Travis CI support
Date: Fri, 6 Nov 2015 04:56:17 -0500
Message-ID: <CAPig+cSc+BBgd3-UeVE79D9GWXfaQqbLCQdKo6FbhnPMsK_eFA@mail.gmail.com>
References: <1446800323-2914-1-git-send-email-larsxschneider@gmail.com>
	<1446800323-2914-5-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jean-Noel Avila <avila.jn@gmail.com>,
	Luke Diamand <luke@diamand.org>,
	David Turner <dturner@twopensource.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 10:56:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zudkw-00017d-3M
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 10:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbbKFJ4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 04:56:21 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36143 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032269AbbKFJ4T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 04:56:19 -0500
Received: by vkex70 with SMTP id x70so10569040vke.3
        for <git@vger.kernel.org>; Fri, 06 Nov 2015 01:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7Tvq6KXMx8xAcE/pUimazSVhF0EilG3oQPvX8W/ThSU=;
        b=vXOWZyCc7b3q9q9w0gtFVmqK7ezcS2O+TgoKEPHqP5e8MVBemULFB3YwSadw/toSpQ
         OZHH6IQxLnNIi6QA81h38w4Et5EqyWtZeGuk7u3OXsioPqPTOL95f9nv++3roQ3sLeW+
         f7aBSFyQL6Wj43Wlc8zdE46eQnTK6o2GM7Z/dNDAVN6/JO0sLueATnKLbfErmk6AWCgG
         xXArR+kR7q3WWJ50NPbsXhzy4xS3eFtrTfjPKn9Dm/we2SbfCIhHGGuygl9P4NBERlkD
         mZneUJwAWaZnGlnXl9UZvLanJqBRGuN0QEVulAFxnB4vgfFEmJRW0JxYYBRkrV67kRau
         hAxg==
X-Received: by 10.31.160.79 with SMTP id j76mr12074299vke.37.1446803778041;
 Fri, 06 Nov 2015 01:56:18 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Fri, 6 Nov 2015 01:56:17 -0800 (PST)
In-Reply-To: <1446800323-2914-5-git-send-email-larsxschneider@gmail.com>
X-Google-Sender-Auth: Y_iXtXSxTSuxldM2MI8gkIbY2mw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280972>

On Fri, Nov 6, 2015 at 3:58 AM,  <larsxschneider@gmail.com> wrote:
> The tests are currently executed on "Ubuntu 12.04 LTS Server Edition
> 64 bit" and on "OS X Mavericks" using gcc and clang.
>
> Perforce and Git-LFS are installed and therefore available for the
> respective tests.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> diff --git a/.travis.yml b/.travis.yml
> @@ -0,0 +1,131 @@
> +  matrix:
> +    -
> +      # NO_ICONV=YesPlease
> +    - >
> +      NO_CURL=YesPlease
> +      NO_D_INO_IN_DIRENT=YesPlease
> +      NO_DEFLATE_BOUND=YesPlease
> +      NO_EXPAT=YesPlease
> +      NO_GECOS_IN_PWENT=YesPlease
> +      NO_GETTEXT=YesPlease
> +      NO_HMAC_CTX_CLEANUP=YesPlease
> +      NO_HSTRERROR=YesPlease
> +      NO_INET_NTOP=YesPlease
> +      NO_INET_PTON=YesPlease
> +      NO_INITGROUPS=YesPlease
> +      NO_INTTYPES_H=YesPlease
> +      NO_IPV6=YesPlease
> +      NO_IPV6=YesPlease
> +      NO_LIBGEN_H=YesPlease
> +      NO_MEMMEM=YesPlease
> +      NO_MKDTEMP=YesPlease
> +      NO_MKSTEMPS=YesPlease
> +      NO_MMAP=YesPlease
> +      NO_NSEC=YesPlease
> +      NO_OPENSSL=YesPlease
> +      NO_PERL=YesPlease
> +      NO_PTHREADS=YesPlease
> +      NO_REGEX=YesPlease
> +      NO_SETENV=YesPlease
> +      NO_SETITIMER=YesPlease
> +      NO_SOCKADDR_STORAGE=YesPlease
> +      NO_STRCASESTR=YesPlease
> +      NO_STRLCPY=YesPlease
> +      NO_STRTOUMAX=YesPlease
> +      NO_STRUCT_ITIMERVAL=YesPlease
> +      NO_SYMLINK_HEAD=YesPlease
> +      NO_SYS_POLL_H=YesPlease
> +      NO_SYS_SELECT_H=YesPlease
> +      NO_UINTMAX_T=YesPlease
> +      NO_UNSETENV=YesPlease

Hmm, aren't you losing test coverage by disabling some of these? Is
that desirable for continuous integration testing? Am I missing
something?
