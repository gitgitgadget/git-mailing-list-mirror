From: Christian Couder <christian.couder@gmail.com>
Subject: Re: recovering a corrupted git repo
Date: Mon, 7 Jan 2013 10:33:00 +0100
Message-ID: <CAP8UFD2zRsJgUf9+EoCDURL4ywQFyPLTkQEGK1Af73m7e=ct5w@mail.gmail.com>
References: <50EA44BA.2030107@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 10:33:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts95A-0007Fi-KX
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 10:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203Ab3AGJdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 04:33:04 -0500
Received: from mail-bk0-f44.google.com ([209.85.214.44]:40516 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133Ab3AGJdC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 04:33:02 -0500
Received: by mail-bk0-f44.google.com with SMTP id w11so8195267bku.3
        for <git@vger.kernel.org>; Mon, 07 Jan 2013 01:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=52t3KynYOuMB4IgAszHbRzQ3cwR7+gWRXVkOTkVUkQI=;
        b=o8vr80ti1ttZuOgC/RcP9eAZ17AElzSgaoUhAOSGz+uY9/E24TB6jXiyUIl63mzlPZ
         9gcxZq+cYI4mfGs+cCpxsVnzZGaWp9rCdIoXdF5EuNZD2IF44ER+vsKE1P14pqh6zpnl
         C88orlQvI980CPXgfxAC5QbiZ+4HVxvejRLcNunho4P9WOCIJtRdxkvVEyYlqj9xpoZU
         Ec6CS/bl/pTcS1F0wZQiAlOXHvbqljqELzfYEInyCkV6ira4OrY+kMV2+iBXgA4zGoRX
         klrSxpCP031HY+GOxrKHwbdPwKY3jhwUxzZDn24sNd+5BNRiUy24ud+RdUQ16dWkYj33
         jQWg==
Received: by 10.205.129.17 with SMTP id hg17mr29358253bkc.41.1357551180759;
 Mon, 07 Jan 2013 01:33:00 -0800 (PST)
Received: by 10.204.129.70 with HTTP; Mon, 7 Jan 2013 01:33:00 -0800 (PST)
In-Reply-To: <50EA44BA.2030107@ubuntu.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212889>

On Mon, Jan 7, 2013 at 4:44 AM, Phillip Susi <psusi@ubuntu.com> wrote:
>
> I have not had any issue until I ran a git fsck recently, which
> repored gzip and crc errors in some pack files.  git fsck does not
> seem to repair the errors, only report them.  I would like to try to
> rebuild my repository, without downloading any more from the origin
> than I have to.  All of the commits I have added seem to still be
> intact, so I assume the corruption in somewhere in the upstream
> history packs.
>
> How can I correct the errors, and fetch the corrupted upstream
> history, while preserving my patches?  So far I have exported my
> patches as bundles, and made a fresh clone from upstream, then pulled
> the bundles back in, but there must be a better way that only fetches
> the corrupted bits from upstream?

The documentation about fixing broken repo is this one:

https://git.wiki.kernel.org/index.php/GitFaq#fix-broken-repo

Hope this helps,
Christian.
