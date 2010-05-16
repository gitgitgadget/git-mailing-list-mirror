From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Has anyone looked at Gettext support for Git itself?
Date: Sun, 16 May 2010 13:12:55 +0000
Message-ID: <AANLkTilWXqXUtDU-r6j6DwBJWK3JoQNwGnnQPHQWhIUF@mail.gmail.com>
References: <AANLkTinlDF-aKDjwvgZEqtUgzW7MCIuElQ_RfJn_RkZp@mail.gmail.com>
	 <m3pr0wd880.fsf@localhost.localdomain>
	 <AANLkTikgs3d1YagU5lRCkEM9uwWe9dmifbHvIjhsk_wF@mail.gmail.com>
	 <20100516053651.GB17200@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 16 15:13:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODdeW-0004PG-M4
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 15:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540Ab0EPNNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 May 2010 09:13:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65055 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510Ab0EPNM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 May 2010 09:12:56 -0400
Received: by fxm6 with SMTP id 6so2897513fxm.19
        for <git@vger.kernel.org>; Sun, 16 May 2010 06:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=6kpqq5ktaDOJWHS1nnSGYMFdptl+gfP/DrVI0xCzhPk=;
        b=mEmy/fhUyFPb06wvpObxY01oV2QCkAT2G/hiF6OGzuf0axz5IEFZuYajCRNN8SfUo4
         xYCp0sKWN8nxbVPK05I9qkrt0rW2BUZVCbfklOvUjqkWD6yofYMoCAfXZlzllmtBLbL6
         zMLI3DP5vjHbeo7h1M5tFcHp49gS8SbXGmikA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=eRSdxUyqWYKVP2aVJiKktC4rk3oXe4eHauYwpBflHUqsr1XbMawq5ULrhbc37jvqtT
         vL5nNHckoChnWkQMvTiBABA+HlnOYaRVNCd0Z05rz5AJTzAnqRE5JftF7w8jdWFqOOt+
         R2OyVs97dHL/Z1pwLVwA/1Y6p3ikMdhAN8kHc=
Received: by 10.223.101.81 with SMTP id b17mr4667033fao.17.1274015575356; Sun, 
	16 May 2010 06:12:55 -0700 (PDT)
Received: by 10.223.109.78 with HTTP; Sun, 16 May 2010 06:12:55 -0700 (PDT)
In-Reply-To: <20100516053651.GB17200@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147188>

On Sun, May 16, 2010 at 05:36, Dmitry Potapov <dpotapov@gmail.com> wrote:
> 'echo -n' is not portable, and it is not used in git for this reason.

> If gettext does not add the trailing newline to the message then it is
> clearly not equivalent replacement.

That was just meant to be a non-working example of how we could read
gettext from .sh too. I didn't actually try to run it. Obviously a
real implementation wouldn't use 'echo -n' and wouldn't suffer from
newline issues.

I just wanted to show that regardless of whether the program is in C,
Perl or Shell a gettext implementation can degrade gracefully. That's
all.
