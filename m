From: Pete Harlan <pchpublic88@gmail.com>
Subject: Re: [PATCH 1/5] status: document the -v/--verbose option
Date: Thu, 23 Apr 2015 17:27:47 -0700
Message-ID: <CAM=ud8zLDTYUp12BsVjWH5=8rg=HxbtdBxL2L9x=3+FQVJBqrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Apr 24 02:27:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlRTI-0005T2-Ps
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 02:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934258AbbDXA1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 20:27:49 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34130 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934223AbbDXA1s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 20:27:48 -0400
Received: by qkgx75 with SMTP id x75so21506924qkg.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2015 17:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=fze/Px2PNA4hwMBsMSOdOhrBJHHqIuzltZ+cDvOnRj8=;
        b=Rh3fOW0lSVxEtHNRUsy8icFmo5SF7RN295VIjaQ+jh0TwPf8UnPhO7CPtPKFHSOSkh
         deQaw4+qenSL7q2e5kjycmcSPc7H35exZ3tSDaY2yZ3vrogBjmMfMsiXhyl7gwHLzU5D
         rbQKIyP2WOw8r5lt/8Y3UKZzHG88jp7kxYu1dqZKNw4jnSt8yBXE89iS1D4oLZtqrOlO
         MSGm0QsEzjA6lKGEuN1gB82P5V6x51wmG+mRzV6tIzdXqYkNHuMEQdNjST3v+mrtgEdT
         zQHOD6FvS46VmXQ4KNgnSum9W1Sb6Ju8VbcaW/uSTd8tgkMh2Dp7VJTuBF8lMzmVTBMz
         AvXQ==
X-Received: by 10.55.25.228 with SMTP id 97mr10691450qkz.105.1429835267094;
 Thu, 23 Apr 2015 17:27:47 -0700 (PDT)
Received: by 10.140.40.80 with HTTP; Thu, 23 Apr 2015 17:27:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267715>

Junio writes:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
> > Document `git status -v`, including its new doubled `-vv` form.
> >
> > Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> >---
>
> Will queue on mg/status-v-v series, which did add description for
> "commit -v", but "status -v" did not have the description to begin
> with and we missed it.
[...]
> > +-v::
> > +--verbose::
> > + In addition to the names of files that have been changed, also
> > + show the textual changes that are staged to be committed
> > + (i.e., like the output of `git diff`). If `-v` is specified

Should this be `git diff --cached`?

> > + twice, then also show the changes in the working tree that
> > + have not yet been staged (i.e., like the output of `git diff
> > + --cached`).

...and should this just be `git diff`?

--Pete

(Sorry for not replying to the email; bit of a mess here in my setup.)
