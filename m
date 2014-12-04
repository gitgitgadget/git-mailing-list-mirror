From: Guilherme <guibufolo@gmail.com>
Subject: Re: git add <single file> and git add <list of files> behave
 differentely for ignored files
Date: Thu, 4 Dec 2014 12:49:14 +0100
Message-ID: <CAMDzUtz2BiM88y6UF2h5-NHYg=tVzysyYD+feXxKNEe-LPYfSg@mail.gmail.com>
References: <CAMDzUtzQJoEi17OfX8FPOV6SDJ_ytJSH-YTKx2DtUON35-EVSg@mail.gmail.com>
 <20141204141100.742f32d74dbf8d65abc8c6ae@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Dec 04 12:50:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwUv8-0006zy-60
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 12:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbaLDLt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 06:49:57 -0500
Received: from mail-wi0-f176.google.com ([209.85.212.176]:59632 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542AbaLDLtz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 06:49:55 -0500
Received: by mail-wi0-f176.google.com with SMTP id ex7so34443473wid.3
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 03:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pgxm/ZAt1NU0EgyfnBs+TwbabrunLp2MnL+45s0ZiWw=;
        b=LORwjCHgFFN9N6MWrVpKOMdvDPBiNn9FUxHFg3pMFeex4v1dZQsD2F0s90PXd+PCq6
         2j8MT5jU1pVcuYchrCKO86wGLhFl2p5KQWwUCwljtsq/CkfNjmCwd2QOoqBRuVLTEJrD
         FaFrJZf4+3mBT3OYcOXVgsR5oc+QH0TN9rarNF/LYRC5+0oqmYtys+7sxZxUqbbboRjq
         Ji4ad0ieugdGcRcMJdIKzr4z5fkwqBJT6fVKF+PNSkq5HN91KiclIZPx/EFuViZZ64fg
         Y33UIaweuBmT4VOgO2t8y6khsnYcqBU/4dMblKqml44G8QvqC+2Hz55H0mb3tVa+Fjv2
         gHAA==
X-Received: by 10.194.91.205 with SMTP id cg13mr10543217wjb.21.1417693794622;
 Thu, 04 Dec 2014 03:49:54 -0800 (PST)
Received: by 10.27.54.80 with HTTP; Thu, 4 Dec 2014 03:49:14 -0800 (PST)
In-Reply-To: <20141204141100.742f32d74dbf8d65abc8c6ae@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260755>

I forgot to mention:

Environment: Cygwin

Git version 2.1.1

On Thu, Dec 4, 2014 at 12:11 PM, Konstantin Khomoutov
<flatworm@users.sourceforge.net> wrote:
> On Thu, 4 Dec 2014 10:06:23 +0100
> Guilherme <guibufolo@gmail.com> wrote:
>
>> I reported this issue on the git-user mailing list and they
>> redirected me here.
>>
>> The problem I have observed is that with a ignored path `git add
>> <single file>` behaves differently then `git add <list of files>`.
> [...]
>
> To those who's interested the original thread on git-users is
> https://groups.google.com/d/topic/git-users/322tole9am8/discussion
