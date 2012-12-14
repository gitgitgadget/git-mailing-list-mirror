From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 4/4] Declare that HP NonStop systems require strings.h
Date: Fri, 14 Dec 2012 21:30:56 +0100
Message-ID: <50CB8C80.6040802@kdbg.org>
References: <CAEvUa7mSOe6gs8JqkewYV=CXt78Y68nTFbFEfEOuCzaV5-DO8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, gitster@pobox.com
To: David Michael <fedora.dm0@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 21:31:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tjbuh-0001I1-HR
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 21:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290Ab2LNUbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 15:31:01 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:61297 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932282Ab2LNUbA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 15:31:00 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7619C1000F;
	Fri, 14 Dec 2012 21:30:57 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B733A19F43B;
	Fri, 14 Dec 2012 21:30:56 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <CAEvUa7mSOe6gs8JqkewYV=CXt78Y68nTFbFEfEOuCzaV5-DO8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211504>

Am 14.12.2012 20:57, schrieb David Michael:
> This platform previously included strings.h automatically.  However, the
> build system now requires an explicit option to do so.
> 
> Signed-off-by: David Michael <fedora.dm0@gmail.com>
> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Makefile b/Makefile
> index fb78f7f..e84b0cb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1357,6 +1357,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>      # Added manually, see above.
>      NEEDS_SSL_WITH_CURL = YesPlease
>      HAVE_LIBCHARSET_H = YesPlease
> +    HAVE_STRINGS_H = YesPlease
>      NEEDS_LIBICONV = YesPlease
>      NEEDS_LIBINTL_BEFORE_LIBICONV = YesPlease
>      NO_SYS_SELECT_H = UnfortunatelyYes

If NONSTOP_KERNEL is the platform that defines __TANDEM, then this
should be squashed into the previous patch, shouldn't it?

--  Hannes
