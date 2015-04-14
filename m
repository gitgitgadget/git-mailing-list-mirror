From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/5] Documentation: add git-log --merges= option and
 log.merges config. var
Date: Tue, 14 Apr 2015 02:42:31 -0400
Message-ID: <CAPig+cQG4NxxmtaQ49xsU3g6UwZb0RqE67PnQBeYrRv=2CGodw@mail.gmail.com>
References: <1428938968-19013-1-git-send-email-koosha@posteo.de>
	<1428938968-19013-3-git-send-email-koosha@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Koosha Khajehmoogahi <koosha@posteo.de>
X-From: git-owner@vger.kernel.org Tue Apr 14 08:42:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhuYU-0000qi-Cj
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 08:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442AbbDNGmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 02:42:37 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:35674 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195AbbDNGmd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 02:42:33 -0400
Received: by lbbuc2 with SMTP id uc2so424491lbb.2
        for <git@vger.kernel.org>; Mon, 13 Apr 2015 23:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=itQXzge3OyVu3GeO7OH+F5Uj5fHO9CrNBNuZbg2ziuE=;
        b=E6Yp+iZnb04p5fx0lxrSS+i0EcMQe2OLiu7VWGZA5+UurYvXIpUkrEcm7MUiiTnTky
         ro4j5VeOTPb6CFfMxfH4MaURTP/cTr4e8f9eKzmBgrK8ImZw9l0JPP9immz1n562DToY
         t2EICZY1FFsdI3uiRnoMzOr7oRWz0zqydHRYU5DG6WeF9f/uTpXBq8VoMhhpzri1ejzE
         ZuPGP5UCour7GKuzvCDRP7+0/XQNw8RUqeJqHCoT87iJeXhzSK+eKmks6lLTkjPN+Ob7
         hTrI6VBDm30GEOJQMZkitGoMu76B2prrW6T/8qUPD7x9faPD5qyQKZJH+lchw3GqJcZZ
         lJwQ==
X-Received: by 10.152.170.136 with SMTP id am8mr17033849lac.102.1428993751238;
 Mon, 13 Apr 2015 23:42:31 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Mon, 13 Apr 2015 23:42:31 -0700 (PDT)
In-Reply-To: <1428938968-19013-3-git-send-email-koosha@posteo.de>
X-Google-Sender-Auth: M9y-rCW0xPOVikrqXdE3XHHC9VY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267117>

On Mon, Apr 13, 2015 at 11:29 AM, Koosha Khajehmoogahi <koosha@posteo.de> wrote:
> From: Junio C Hamano <gitster@pobox.com>
>
> [kk: added documentation in git-log.txt]
>
> Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
> ---
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index f620ee4..88f152f 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -96,6 +96,23 @@ if it is part of the log message.
>  --remove-empty::
>         Stop when a given path disappears from the tree.
>
> +--merges={show|hide|only}::
> +
> +       Limit the output by type of commits.
> +
> +       `hide`;;
> +               Hide merge commits from the output.
> +
> +       `only`;;
> +               Hide non-merge commits from the output (i.e showing
> +               only merge commits).
> +
> +       `show`;;
> +               Do not hide either merge or non-merge commits. This
> +               is primarily useful when the user has non-standard
> +               setting of `log.merges` configuration variable that
> +               needs to be overriden from the command line.

s/overriden/overridden/

>  --merges::
>         Print only merge commits. This is exactly the same as `--min-parents=2`.
>
> --
> 2.3.3.263.g095251d.dirty
