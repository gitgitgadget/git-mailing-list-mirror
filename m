From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH 3/3] The "curl" executable is no longer required
Date: Sun, 15 Jun 2008 20:52:43 +1000
Message-ID: <ee77f5c20806150352n6ccf00e9w8083a17d8c5c2326@mail.gmail.com>
References: <200806120920.31161.johan@herland.net>
	 <200806151216.01886.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 15 12:53:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7prg-0005kS-67
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 12:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756942AbYFOKwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 06:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756290AbYFOKwp
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 06:52:45 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:31182 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756173AbYFOKwo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 06:52:44 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3083369fgg.17
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 03:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=xYFEPHKM2nCBP8t8s5KcsFS2DyQJXJrW0JezT0CJxRg=;
        b=p0Cr/drCSiZ4dMjqf67d4CuW5pwLp3GlekOVTpUipArQB72Wy0RIfk0OF4uv7mmW8T
         GXQ9qv9Qn/ifQOO6yzpEtwAk4KDsysE3HUTRN2dWLkY+SxDpSTj+XbenkxdWXsLUkUPg
         oS23Tr9jWN4wtsHWmamr3V5EDHkkefOLE7PDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=njwUKZeIoHY/ioV8QuAS9eXGPFew/5xXy6FxQJYVH5WwHrfBL+ddixA1yAH88jLp7D
         0bs7JT7I76aaVc8Jlwi7TwXmUaVoD/bYQncoer3NLZLiYok1nmCQ/wU5o5rQeoCd3hf7
         FU2IBv+SKdsJ2SmHHIAUPlbzGvbFhnOY7v8rc=
Received: by 10.86.23.17 with SMTP id 17mr6854081fgw.32.1213527163626;
        Sun, 15 Jun 2008 03:52:43 -0700 (PDT)
Received: by 10.86.74.8 with HTTP; Sun, 15 Jun 2008 03:52:43 -0700 (PDT)
In-Reply-To: <200806151216.01886.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85077>

On Sun, Jun 15, 2008 at 8:16 PM, Johan Herland <johan@herland.net> wrote:

> diff --git a/git.spec.in b/git.spec.in
> index 97a26be..d946bb1 100644
> --- a/git.spec.in
> +++ b/git.spec.in
> @@ -12,7 +12,7 @@ BuildRequires:        zlib-devel >= 1.2, openssl-devel,
> curl-devel, expat-devel, gettex
>  BuildRoot:     %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
>
>  Requires:      perl-Git = %{version}-%{release}
> -Requires:      zlib >= 1.2, rsync, curl, less, openssh-clients, expat
> +Requires:      zlib >= 1.2, rsync, less, openssh-clients, expat
>  Provides:      git-core = %{version}-%{release}
>  Obsoletes:     git-core <= 1.5.4.2
>  Obsoletes:     git-p4

Shouldn't libcurl still be listed as a requirement? Or is it statically linked?


Dave.
