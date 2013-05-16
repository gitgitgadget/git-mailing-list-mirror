From: David Aguilar <davvid@gmail.com>
Subject: Re: What's cooking in git.git (May 2013, #04; Wed, 15)
Date: Wed, 15 May 2013 17:25:52 -0700
Message-ID: <CAJDDKr5T6rcAukeDkU4niLn7gaz-+JMSE=fG3G4qdKuf-q6AaA@mail.gmail.com>
References: <7vmwrvajye.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 16 02:26:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucm1K-0000ps-6T
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 02:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896Ab3EPAZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 20:25:54 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:39345 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149Ab3EPAZx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 20:25:53 -0400
Received: by mail-wi0-f171.google.com with SMTP id hq7so3975512wib.10
        for <git@vger.kernel.org>; Wed, 15 May 2013 17:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=12tHAvttoBejjtI/xvqj4w1T+LrADVuuyrmObn6Jccw=;
        b=Icp/DQrVacJ62VxcIIqkWrSVBXvm2KvTpjw9HpgKITlfLZ6EgXjBX2Un8a2uzB3TKx
         iq3YJFmWMeSkZvKxgwzs7ou+RgmqA0bXmHOKjQJu6FXeCc/w+fqZtLIG2VgJZgNbECGv
         uFD3cVhc7DB5w9JvQ2/VVScREMg8lPy+uKe0XA7D+uX3MtYxMf/+WVvonRjXy/JQCBza
         Cuua1LQ+bp9UMoaVJHXhKPoRVzfdES8mrUEN2+3h4Qkt0k4f7B4Kjkf2QLubMk1n40M1
         n36shAhYbgMw+mIZqSctmb7D9YU2/qbJOJyFuNrZrrJhaX3ax5y1AwRQ5cwEHPNZtHRV
         ju1A==
X-Received: by 10.180.90.164 with SMTP id bx4mr19032270wib.13.1368663952181;
 Wed, 15 May 2013 17:25:52 -0700 (PDT)
Received: by 10.194.240.195 with HTTP; Wed, 15 May 2013 17:25:52 -0700 (PDT)
In-Reply-To: <7vmwrvajye.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224461>

On Wed, May 15, 2013 at 4:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.
>
> We are past -rc2 and haven't seen any regression reported since the
> feature freeze started, which may be a good sign (the coming release
> is perfect) or a bad sign (nobody is testing).  We'll see soon when
> we tag the 1.8.3 final sometime next week.  We may see subsystem
> (git-svn? gitk? git-gui?) and l10n updates before that happens.
>
> You can find the changes described here in the integration branches
> of the repositories listed at
>
>     http://git-blame.blogspot.com/p/git-public-repositories.html
>
> --------------------------------------------------
> [New Topics]
>
> * dw/asciidoc-sources-are-dot-txt-files (2013-05-10) 1 commit
>  - CodingGuidelines: Documentation/*.txt are the sources
>
>
> * fc/doc-style (2013-05-09) 2 commits
>  - SQUASH??? more consistently update docs
>  - documentation: trivial style cleanups
>
>
> * da/darwin (2013-05-15) 3 commits
>  - imap-send: eliminate HMAC deprecation warnings on Mac OS X
>  - cache.h: eliminate SHA-1 deprecation warnings on Mac OS X
>  - Makefile: fix default regex settings on Darwin
>
>  Waiting for polishing discussion to finish.

Thanks.

imap-send and cache.h are now on their v6 patch which I just sent.
That last few rounds have been cosmetic/superficial changes and I
would like to consider this topic "done".  We've painted this shed
enough times ;-)

I believe "fix default regex settings on Darwin" is uncontroversial
and should be included in the upcoming release.  It may even be
maint-worthy.  Without it we fail t0070-fundamental.sh.  The two
patches that follow it can wait and cook like normal.
--
David
