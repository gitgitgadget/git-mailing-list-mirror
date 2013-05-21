From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (May 2013, #05; Mon, 20)
Date: Mon, 20 May 2013 19:22:51 -0500
Message-ID: <CAMP44s2rk4WbiBLyW5MgXrrqVisXLmz=EF2DrUwHe6MGkYoq4A@mail.gmail.com>
References: <7v38thrxwo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 02:22:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeaLx-0006MM-Ed
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 02:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757235Ab3EUAWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 20:22:53 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:42606 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572Ab3EUAWw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 20:22:52 -0400
Received: by mail-lb0-f171.google.com with SMTP id v20so135925lbc.30
        for <git@vger.kernel.org>; Mon, 20 May 2013 17:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bttG4nzabBK8TfM62shw7lvA65o0dq1q56pSLTVyrLE=;
        b=uml4Zo2Mwzzhwn5qxlQdVujuxMrX23oyxtPnCVPji7ynApj51fsU1VwuCvf1iJaU9A
         qf+qiE5uLE1WvJ8kcito1E3DiJFFITYDeJkqiFpHX5ybr4FIt25O2cwcrIwkPoKLdMPP
         uaqUpWD3QG43Fgm988p0cUCGhJsbpkOHbhYi9PYamvw1jJ+BFjv9erqi9X1uXiO0njTC
         Nq362R0Y3C5Z290zjhxQKYyObyx8VvfQrNfyB007swzOXQ7XVH8R7SMqq9XbKauWrs2U
         j8VUkHpym1W2nigMUGu9d4ADthJx97IH6YtFDB36OGq1Vpd+/gHV9bW5xzBQXTkhPccK
         WHow==
X-Received: by 10.112.125.130 with SMTP id mq2mr204625lbb.103.1369095771405;
 Mon, 20 May 2013 17:22:51 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Mon, 20 May 2013 17:22:51 -0700 (PDT)
In-Reply-To: <7v38thrxwo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225004>

On Mon, May 20, 2013 at 7:15 PM, Junio C Hamano <gitster@pobox.com> wrote:

> * fc/at-head (2013-05-08) 13 commits
>  - sha1_name: compare variable with constant, not constant with variable
>  - Add new @ shortcut for HEAD
>  - sha1_name: refactor reinterpret()
>  - sha1_name: check @{-N} errors sooner
>  - sha1_name: reorganize get_sha1_basic()
>  - sha1_name: don't waste cycles in the @-parsing loop
>  - sha1_name: remove unnecessary braces
>  - sha1_name: remove no-op
>  - tests: at-combinations: @{N} versus HEAD@{N}
>  - tests: at-combinations: increase coverage
>  - tests: at-combinations: improve nonsense()
>  - tests: at-combinations: check ref names directly
>  - tests: at-combinations: simplify setup
>
>  Instead of typing four capital letters "HEAD", you can say "@"
>  instead.

This is not ready for next? Note that I specifically split the two
commits that were needed, the rest can wait.

-- 
Felipe Contreras
