From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/4] remote.c: introduce branch.<name>.pushremote
Date: Mon, 18 Mar 2013 18:23:41 -0400
Message-ID: <CAPig+cQ5-07+oRYCym+9wA-C020oZ3V9_ZhE8o_RU-1OGqhpmg@mail.gmail.com>
References: <1363612575-7340-1-git-send-email-artagnon@gmail.com>
	<1363612575-7340-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 23:25:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHiUL-0007m4-K4
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 23:25:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755483Ab3CRWXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 18:23:44 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:40911 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054Ab3CRWXm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 18:23:42 -0400
Received: by mail-la0-f45.google.com with SMTP id er20so6777481lab.4
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 15:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=MNn+8n9zpWd3pfIZ9NHfYvg1DF0mPdScREgyYy9yIGo=;
        b=HFJn9Cbws7Dwe0IJw81UOgPaRlzXuZvKlovf6a7+XHq32snAtZMX8yHNP/xojbKLi8
         IWy8WLL6SgKB9O2vkVTEBqaFAknFHP7IaMiTlGTDtHSbESPkCnQhhEVyjQDdL01Y0qOR
         UmLurLjlJLuKe30wDkE2a+sDGLJSkA/S/WyrcLskS6e04pG4gMSRNvqru43TQ5HoSDcV
         yTPFRuXA8La6mjq4kDP7azUo5dhFBQm7ApyXA1nWL3BkbhkSR+snKMUa+9Rn2CUnl/JY
         eM6KPVMCpfsNGZTndHvmh7zC90fTMCcw6zrc1WxBW41gwOCbuwToLXZHBAmTbAy8qWTR
         vNdQ==
X-Received: by 10.152.104.199 with SMTP id gg7mr16145079lab.14.1363645421334;
 Mon, 18 Mar 2013 15:23:41 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Mon, 18 Mar 2013 15:23:41 -0700 (PDT)
In-Reply-To: <1363612575-7340-5-git-send-email-artagnon@gmail.com>
X-Google-Sender-Auth: dgT8bxW3IamkpmGrTyF-5yFiMQk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218461>

On Mon, Mar 18, 2013 at 9:16 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> -       If no remote is configured, or if you are not on any branch,
> -       it defaults to `origin` for fetching and `remote.pushdefault`
> -       for pushing.
> +       The remote to push to, for the current branch, may be further
> +       overriden by `branch.<name>.pushremote`.  If no remote is

s/overriden/overridden/

> +       configured, or if you are not on any branch, it defaults to
> +       `origin` for fetching and `remote.pushdefault` for pushing.
> +
>  remote.pushdefault::
>         The remote to push to by default.  Overrides
> -       `branch.<name>.remote` for all branches.
> +       `branch.<name>.remote` for all branches, and is overriden by

Ditto: s/overriden/overridden/

> +       `branch.<name>.pushremote` for specific branches.
