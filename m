From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] contrib/subtree: remove "push" command from the "todo" file
Date: Thu, 5 Nov 2015 17:57:37 -0500
Message-ID: <CAPig+cR4ji2DT5ULmxq9nDoo+bEc6vRxsZ5u5RKco+svsvOkcw@mail.gmail.com>
References: <1446737217-6646-1-git-send-email-fabio.porcedda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	James Denholm <nod.helm@gmail.com>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Danny Lin <danny0838@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Thomas Ackermann <th.acker@arcor.de>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 23:57:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuTTS-0004ca-Ba
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 23:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756875AbbKEW5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 17:57:38 -0500
Received: from mail-yk0-f194.google.com ([209.85.160.194]:35883 "EHLO
	mail-yk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756348AbbKEW5h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 17:57:37 -0500
Received: by ykba4 with SMTP id a4so14505744ykb.3
        for <git@vger.kernel.org>; Thu, 05 Nov 2015 14:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=VYD5QMw16ihx4d9ccJT1h05l08EL8CTTSEPZ6P9cOfA=;
        b=JEF61DtDFsJoIyv47eWHnAaHhr3jLhkeaT3fqYLwHUXo3ecOxEdYGGhGwpQIvZf4ra
         7mA7bZ/FKnR4qABRD7ICa1rtZSE67T5jj3GxJPCE8mYiufeWzQlVdTtmvenxOLlqOrAD
         VNIQAy1rTNShqqT/0i5mBdDiUonBo6lHjEpaVf4d6PlGalC1tfkslSVPl/vmi7KfHyeJ
         yZe7plt73Dqu9tFrXLrp4c+5fpV2mcb2YylsSzds6GGUN5SSyqWvHqmyFDfZUiHacqUW
         2Kq+uJ2eGH/Hlm6eoOUhNKegj5a6ZKfOptUOZOux8G/T2PHO9d2+/P95yIIA8O9dDL+O
         l+hg==
X-Received: by 10.31.160.79 with SMTP id j76mr9685231vke.37.1446764257174;
 Thu, 05 Nov 2015 14:57:37 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Thu, 5 Nov 2015 14:57:37 -0800 (PST)
In-Reply-To: <1446737217-6646-1-git-send-email-fabio.porcedda@gmail.com>
X-Google-Sender-Auth: ETZChVPPOas9vL0QBMnNbAXMyWI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280943>

On Thu, Nov 5, 2015 at 10:26 AM, Fabio Porcedda
<fabio.porcedda@gmail.com> wrote:
> Because the "push" command is already avaiable, remove it from the

s/avaiable/available/

> "todo" file.
>
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> ---
> diff --git a/contrib/subtree/todo b/contrib/subtree/todo
> @@ -12,8 +12,6 @@
>                 exactly the right subtree structure, rather than using
>                 subtree merge...)
>
> -       add a 'push' subcommand to parallel 'pull'
> -
>         add a 'log' subcommand to see what's new in a subtree?
>
>         add to-submodule and from-submodule commands
> --
> 2.6.2
