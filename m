From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] custom log formats for "diff --submodule=log"
Date: Sun, 11 Nov 2012 18:35:16 +0530
Message-ID: <CALkWK0nT8RXXUUkLuS8zWVMG=wsm0b740q-qYb3iN3cO7Tb=0A@mail.gmail.com>
References: <20121108202940.GA7982@sigill.intra.peff.net> <CALkWK0mYs7Q1256gY7ZH3Ng3xbYv2+XVHCZ7XYWgWUp2O-VzqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Jeffrey S. Haemer" <jeffrey.haemer@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 11 14:05:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXXEV-0008Jo-Hz
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 14:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814Ab2KKNFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 08:05:38 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:60790 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082Ab2KKNFh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 08:05:37 -0500
Received: by mail-we0-f174.google.com with SMTP id t9so2412689wey.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 05:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aWdg+y52pZvloZLF8poxrIJ7RVT71hu5D1aN5tmgaVA=;
        b=UTR8pLrxARKRJCphqmvCfFM16JIz5z1jXhFwJgL6fzm4qydgYj/xP9RuLYPeUdTRZm
         82x5pJ3qyikHoAsBweGSxbfolg3WBu+sT4GvwEZTraC33Hsuoe3FxcVBURf7ZU76jk36
         waFZ/ZHN3RpxWx0zJfDKC5tlZpzcKlbjYd4wQmg98bVK/KiDfkPhUZfUu+QSpeVgFuzk
         3dHvj2tV1sGLs3uPdnVoKiCX8VZqxOkufrJ2pSgBXs46qgIDrXcMPsWvHwrIBwvipC8y
         Dw5dvYjdZIjUpKqVbw1PSlYqy7FwU692M/j8Q+Rq0azCdlfN0Gkg8gPhsjK3HnvZ3aeJ
         a70Q==
Received: by 10.181.11.233 with SMTP id el9mr10778245wid.3.1352639136562; Sun,
 11 Nov 2012 05:05:36 -0800 (PST)
Received: by 10.217.61.2 with HTTP; Sun, 11 Nov 2012 05:05:16 -0800 (PST)
In-Reply-To: <CALkWK0mYs7Q1256gY7ZH3Ng3xbYv2+XVHCZ7XYWgWUp2O-VzqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209351>

Hi again,

Ramkumar Ramachandra wrote:
> Don't you mean `git diff` in place of `git log -p`
> though?  I don't think `git log --submodule` does anything differently
> from `git log`.

Sorry for the nonsense.  I just realized that it affects the diffs
shown by `git log -p`.

Ram
