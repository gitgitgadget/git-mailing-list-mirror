From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] i18n: po for zh_cn
Date: Wed, 1 Feb 2012 18:48:49 +0100
Message-ID: <CACBZZX6mHQ8NLWiBjp5OtDpFAc1=s9XfzHY5HhQ-26pqLXQ3bg@mail.gmail.com>
References: <1328111436-58925-1-git-send-email-worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 18:49:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RseJ2-0007Vn-6S
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 18:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522Ab2BARtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 12:49:11 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:46306 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751890Ab2BARtK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2012 12:49:10 -0500
Received: by lagu2 with SMTP id u2so798467lag.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 09:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YxqLQ5be2SG9GfpYV77UYJseewgVjEWIRytNFk85ODk=;
        b=GpXMopuIlFhYyLQJor5MJzGzWH8m72xuGebSC5Zrmriyk4Xm4dz+oNYzsB8aVxSTEo
         Y56ABAQC9AiFdtEepKXA8q2d2hfCaF/xUaKgxG6qKr0W7mGgh5ShKL40BMmixbA5z+UI
         glagvoXhU6aopvm2njwSRX2eWDW/PAgOcwFIw=
Received: by 10.112.49.201 with SMTP id w9mr6893364lbn.23.1328118549226; Wed,
 01 Feb 2012 09:49:09 -0800 (PST)
Received: by 10.112.30.67 with HTTP; Wed, 1 Feb 2012 09:48:49 -0800 (PST)
In-Reply-To: <1328111436-58925-1-git-send-email-worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189529>

On Wed, Feb 1, 2012 at 16:50, Jiang Xin <worldhello.net@gmail.com> wrote:
> Git can speak Chinese now.

That's very nice, and it passes the msgfmt --check test as well, so
all looks good.

As an aside doesn't the bug / workaround described in
https://github.com/git/git/blob/master/gettext.c#L35 impact chinese
especially badly? I'd expect any place where we use strerror() to show
up as total gibberish.

Nothing to be done about that though than providing non-broken printf
functions though, just curious.

> +#: wt-status.c:207
> +msgid "bug"
> +msgstr "bug"

It also looks like we could do away with making this available for
translation, and it should actually be something like "if you see this
report a bug in Git" instead.
