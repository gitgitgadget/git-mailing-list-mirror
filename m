From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: allow --follow-tags' to be set by config push.followTags
Date: Sun, 15 Feb 2015 16:01:04 -0800
Message-ID: <CAPc5daXkf3Vc-kGsqQ4zo6qSMrh93GZbXeFK9oLwajyNahmx1Q@mail.gmail.com>
References: <1424043588-15994-1-git-send-email-cxreg@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Dave Olszewski <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 01:01:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YN97x-0003DK-Rl
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 01:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735AbbBPAB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2015 19:01:26 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:65425 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541AbbBPABZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2015 19:01:25 -0500
Received: by mail-ob0-f173.google.com with SMTP id uy5so37163984obc.4
        for <git@vger.kernel.org>; Sun, 15 Feb 2015 16:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=woxPMGSq4XJeSSrbjVfScmJZ0rfxo9jMu3ar0D0rwao=;
        b=M5DtliKR3ZKTTLMM0xJRJvkIwqifIAZxZrf69bSVEbZRLLqqOYvhJ1h6FkDjmv1lRh
         TAMk06ioQJUaarKaimLVIir0YHRg3Y8v00WYJHu25mwOhfJYapu2PXVKrrwS6uA9g652
         g514Nm0XoEpg/vxIVayg7CDD6C0DRjKbuaMJVaJeWcLEUvEeXXYAccGRbFo7rXbvAkx7
         0kOuVOx6Zk2+dViTwLYV6Rna1bOcKLTd2QT3i9aHrmaNXFGuMC0cxJBtO5M6usEeo8jG
         vvQH6nZcb7fL3CRCOl4RdjNSVSesCsaO9x50kP/jIWZg6iiKrNGUHqJxBc/HqH1NxYgi
         aPpQ==
X-Received: by 10.60.56.41 with SMTP id x9mr13412545oep.40.1424044884669; Sun,
 15 Feb 2015 16:01:24 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Sun, 15 Feb 2015 16:01:04 -0800 (PST)
In-Reply-To: <1424043588-15994-1-git-send-email-cxreg@pobox.com>
X-Google-Sender-Auth: FuY_mb3EyoX92nvoKN5j3h8zaOY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263864>

On Sun, Feb 15, 2015 at 3:39 PM, Dave Olszewski <cxreg@pobox.com> wrote:
> Signed-off-by: Dave Olszewski <cxreg@pobox.com>
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ae6791d..cdb8a99 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2079,6 +2079,9 @@ new default).
>
>  --
>
> +push.followTags::
> +       If set to true enable '--follow-tags' option by default.
> +

After setting this in your repository, does "git push --no-follow-tags" let
you override it if you want to do so for a single invocation?

If it does, the code is good but it should be documented here; if it
does not, it should be corrected and it should be documented here.

Thanks.
