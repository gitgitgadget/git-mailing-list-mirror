From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH 3/6] l10n: Fix misuses of "nor"
Date: Mon, 17 Mar 2014 09:45:46 +0800
Message-ID: <CANYiYbE_WRhCAfDCpAskw4JqEnbZ3xg0MvK2FrYLZrhmkKuKhA@mail.gmail.com>
References: <1394872922-2000-1-git-send-email-jlebar@google.com>
	<1394872922-2000-4-git-send-email-jlebar@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Justin Lebar <jlebar@google.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 02:45:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPMck-0004dm-B5
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 02:45:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbaCQBpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2014 21:45:49 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:35152 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070AbaCQBps (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 21:45:48 -0400
Received: by mail-we0-f175.google.com with SMTP id q58so3949440wes.20
        for <git@vger.kernel.org>; Sun, 16 Mar 2014 18:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3olfKZ0na7TKkSHsuS0uOUdtOGYd7/NYjfJLC89OWHM=;
        b=iP6e5WFakqWfQTCy52Li0ksf8SKl/IDAxZuUZTb3DHlvZ+b9jA9C6wI8JUawbvTaO4
         /2M5X9sjjTSg38VskiDHbSZ8g5ihb1wAAOmHDj6IKTYQlN/kBGGwS/0ScQfk97dqRyok
         bB21mkzcpUHDBNtBGwpav3cV3qLFbYbENXly0nR7hcb5VjVdu6DPy/sP3YhEEKk4abI9
         UXNgfSF0GGHIh2XOniOd/9cImr6Nd1HtV/Fdt273ROYP0cqq+BhBhmhoN0TFygB46mUN
         iwNgsv/bL+8MMM1EFiBLFkJgWD3LHMXATMqezBSp4Aos1tMQzf0jjJwqhhMpNU9dhwm6
         Eeug==
X-Received: by 10.195.13.234 with SMTP id fb10mr40706wjd.50.1395020747029;
 Sun, 16 Mar 2014 18:45:47 -0700 (PDT)
Received: by 10.217.58.65 with HTTP; Sun, 16 Mar 2014 18:45:46 -0700 (PDT)
In-Reply-To: <1394872922-2000-4-git-send-email-jlebar@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244218>

2014-03-15 16:41 GMT+08:00 Justin Lebar <jlebar@google.com>:
> Signed-off-by: Justin Lebar <jlebar@google.com>
> ---
>  po/bg.po    | 6 +++---
>  po/de.po    | 6 +++---
>  po/fr.po    | 6 +++---
>  po/git.pot  | 6 +++---
>  po/it.po    | 2 +-
>  po/pt_PT.po | 2 +-
>  po/sv.po    | 6 +++---
>  po/vi.po    | 6 +++---
>  po/zh_CN.po | 6 +++---
>  9 files changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/po/bg.po b/po/bg.po
> index fb450b2..983e575 100644
> --- a/po/bg.po
> +++ b/po/bg.po
> @@ -3699,13 +3699,13 @@ msgstr ""
>
>  #: builtin/clean.c:906
>  msgid ""
> -"clean.requireForce set to true and neither -i, -n nor -f given; refusing to "
> +"clean.requireForce set to true and neither -i, -n, nor -f given; refusing to "
>  "clean"
>  msgstr ""
>

Hi Justin,

All the msgids you patched are extracted from Git source code using gettext,
So please patch the original files where the msgids are came from, such as
builtin/clean.c.


-- 
Jiang Xin
