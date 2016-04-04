From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] comment for a long #ifdef
Date: Sun, 3 Apr 2016 21:54:16 -0400
Message-ID: <CAPig+cS=oGvs3zWA782APy7moo3N-4-Oe9B8obej5oWKxw9Gsg@mail.gmail.com>
References: <5701BCC1.9050306@mail.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ivan Pozdeev <vano@mail.mipt.ru>
X-From: git-owner@vger.kernel.org Mon Apr 04 03:55:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amtjs-00041P-Ok
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 03:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572AbcDDByR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 21:54:17 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:38638 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbcDDByR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 21:54:17 -0400
Received: by mail-ig0-f177.google.com with SMTP id ui10so58708972igc.1
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 18:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=WFHAvCxab2M0MbBVV0KCR0fGEoNNJQ2ngFxlvr3K09A=;
        b=AgpdvU7ht18qT8ddselvBmZWqRj6x+G6UZp9MWdU5j1uKtGCCyvhevCHG3zW86kkFP
         cT52pFsqNR179l+Iz97dSFxcCJG/xuEvCy2f8HK3fhcZqNjX7aZk5IvjN297qWqXnmCS
         1c0H0AtcZfRpeT5WC2w1IkPpCriVAQlulG8fA86RtrL4obJzgdr68aEH86ZJG6FHezW7
         1dhHiZRpnmBlRD+Hagbaqxv7eJwkK+dKmyvS3TLu9K5jApI0iz8rnKbXShBbqGsefYs0
         4NWcbv2L6gfUMK+Zw66h9nI5c0pw0GLlk+rIRGnIfgH13Mctp7JAWfS2/2crAe5cwVC1
         vYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=WFHAvCxab2M0MbBVV0KCR0fGEoNNJQ2ngFxlvr3K09A=;
        b=KVM73OU/gQfCvEBkzAqPEqoLCI2x84bTU7G5JUAEv0upq4tUoxIQwj18/TqWur9HOS
         y78gps8JZgLDIOuR3eJo6St8weWrvo8K13z0kQRI+ei2PcPM53lO3A+5HhcYfI9f1PVh
         YUP4G6KVvrNPIHxglBYbrVET4O87ry22pL3dnjYwhjQruy5w3ms+4foeVZyYsJ8LT7Si
         qRAEhGc8u36BoDGHCbJHLcNUzBavsCOffugYw7PYhUDG7S3Ooh0ZOO9VDryCzuICLPXd
         5UG+XFkO5zmesXOvUjEqW/N+XQ2Rgef9bA+9p3f7YYAScFlEIDbCenVzqFQhMGuCbEU4
         HLgg==
X-Gm-Message-State: AD7BkJJLmeYncJ3PS4bPyOSEPnYSshyGI277bzU1EWaeO1MDDQikfScSoX8Pkw6foCOgVNtzBxmh92INJenJqA==
X-Received: by 10.107.47.41 with SMTP id j41mr13565178ioo.168.1459734856419;
 Sun, 03 Apr 2016 18:54:16 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Sun, 3 Apr 2016 18:54:16 -0700 (PDT)
In-Reply-To: <5701BCC1.9050306@mail.mipt.ru>
X-Google-Sender-Auth: DKed56WkIKbKruLdKC8tKRCTJjE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290670>

On Sun, Apr 3, 2016 at 9:00 PM, Ivan Pozdeev <vano@mail.mipt.ru> wrote:
> ---

Missing sign-off. See Documentation/SubmittingPatches.

> compat/poll/poll.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/compat/poll/poll.c b/compat/poll/poll.c
> index db4e03e..5eb0280 100644
> --- a/compat/poll/poll.c
> +++ b/compat/poll/poll.c
> @@ -441,7 +441,7 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
> }
>
> return rc;
> -#else
> +#else /* #ifndef WIN32_NATIVE */
> static struct timeval tv0;
> static HANDLE hEvent;
> WSANETWORKEVENTS ev;
> @@ -622,5 +622,5 @@ restart:
> }
>
> return rc;
> -#endif
> +#endif /* #ifndef WIN32_NATIVE */
> }
