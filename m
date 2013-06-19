From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: small misspellings fixes
Date: Wed, 19 Jun 2013 09:45:47 +0530
Message-ID: <CALkWK0=PZXqY3EZj8vQpg3facOFjHp8eEuG4imAx5Qi89sY5+w@mail.gmail.com>
References: <alpine.DEB.2.00.1306190100190.8850@citymarket.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Veres Lajos <vlajos@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 06:16:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up9p7-0006kE-Mj
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 06:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979Ab3FSEQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 00:16:28 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:33695 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866Ab3FSEQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 00:16:28 -0400
Received: by mail-ie0-f175.google.com with SMTP id a13so11605212iee.6
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 21:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oMHRpeM9+yAMA9QFizJHx3y2mN0H652tPHF6U9OqUh0=;
        b=C0bMNpaip/QLCXtWCHkvb5vu+tw30g7VD+tWWAL5gbBBo3FgGIv67Xp/Y8bKs+MkWC
         rLjpeQOi1IXDjHyhZaRZpvXmem/Ag1SUGCqlWgla62/EN499mE1XKItkcCNPcksu5LH1
         RIlST/59ETb+D+L91FlfepcpMCJ5Dl/8it2wJyQlUoLwoRDTa3rjM9La5aZQqUjMAFZ2
         Dj998RUglpsBk1IF4PK9jgHxgbrY+Fo8o0zME2QGgvRoyk7kVL+ziRerkJq75vxfCTlp
         hXzIH32U20PB33hNJa2D0+c673vzgoYlJftFM9F5fXTVSn4j6Yc/W51k5ZY0WBtwJaIU
         otSA==
X-Received: by 10.42.73.138 with SMTP id s10mr375589icj.10.1371615387526; Tue,
 18 Jun 2013 21:16:27 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 21:15:47 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1306190100190.8850@citymarket.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228336>

Veres Lajos wrote:
> Subject: small misspelling fixes

Good.

> I am trying to convert this pull request:
> https://github.com/git/git/pull/42
> to a proper patch email
> (Sorry If I miss something about the process.)

This does not belong in the commit message: you don't want this to be
shown when someone is reading 'git log' output, do you?  Put such
comments under the "--" line after the signoff, so it'll be ignored by
git am.

Thanks.
