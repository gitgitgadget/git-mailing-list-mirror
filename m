From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH] parse-options: fix the description of defval
Date: Sun, 29 Mar 2015 17:08:54 +0800
Message-ID: <CACRoPnTjAu_pyPp2TXZGou=H8mkXBmQqgxGNusjW6u8peEfw6Q@mail.gmail.com>
References: <E8C3474A-5A3A-4A51-A798-84FB9AD46A9F@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ivan Ukhov <ivan.ukhov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 11:09:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yc9DR-0002Sc-VS
	for gcvg-git-2@plane.gmane.org; Sun, 29 Mar 2015 11:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbbC2JI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2015 05:08:57 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:34519 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbbC2JI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2015 05:08:56 -0400
Received: by lagg8 with SMTP id g8so97890768lag.1
        for <git@vger.kernel.org>; Sun, 29 Mar 2015 02:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8Bdl78sOpCtoCVQTPPUwDs4qUhU+3bYXEo3XlsrdP0g=;
        b=YG7y410uF8566GIYsNq2dVCs1NCBgVFgqpmOSK1TXEvIew3WNOV3OhWuswZXqcYiGm
         m1Ocj7qF0jtqHs9bigv9Rlx1p0l+ZdTB7G6NGylHtHSJ3rBwgvxWZH3DSPONtpaZ/HFu
         IMA5+Fo3s8Si/Tcf6Eqqs1d1IHkdH3hQH/QzmHXBSzFQh7lNclY5R88TYLbaBDihVrhk
         +53gYrTSfyrj/NVvoXQF+mA4fJmit4ea+O+ZaoCTY/6BoHbAcNT8rBlyHdLUF6xAATax
         opFn0LzaKuRXlgoJtFxZbZyzoEJWxh7SemhvL4Mb/1E5P0NMXJwSSP93+zVfBQPMBul/
         6tZw==
X-Received: by 10.152.87.115 with SMTP id w19mr24571763laz.66.1427620134639;
 Sun, 29 Mar 2015 02:08:54 -0700 (PDT)
Received: by 10.112.130.228 with HTTP; Sun, 29 Mar 2015 02:08:54 -0700 (PDT)
In-Reply-To: <E8C3474A-5A3A-4A51-A798-84FB9AD46A9F@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266432>

Hi,

On Sun, Mar 29, 2015 at 4:32 PM, Ivan Ukhov <ivan.ukhov@gmail.com> wrote:
> Since the deletion of OPT_SET_PTR, defval can no longer contain a pointer.
>

Actually, it can contain a pointer for OPTION_CMDMODE, OPTION_STRING
and OPTION_FILENAME. Since we are on the topic of updating the
documentation, I think it would be great if the documentation
mentioned these option types as well.

Thanks,
Paul
