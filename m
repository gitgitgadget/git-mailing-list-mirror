From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git svn dcommit <branch> committed to trunk anyway
Date: Mon, 7 May 2012 19:47:22 +0530
Message-ID: <CAH3Anroub3a1+Nsj5C-ecTqaX9riUG7T27bHZYJOHiPJbeVCTQ@mail.gmail.com>
References: <CAH3AnroP+ckzgijibPDEupBCfUFu5Bwsq8YP58h+igXoJyJEyg@mail.gmail.com>
	<87txzsba0o.fsf@thomas.inf.ethz.ch>
	<CAH3Anrq5SGZZsTpKd1MFBRVD8xzsUvckt6d-BxtTYYce--F1+g@mail.gmail.com>
	<87havs6v9s.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 07 16:17:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SROkj-00037F-5g
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 16:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756836Ab2EGORY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 10:17:24 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37491 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756194Ab2EGORY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 10:17:24 -0400
Received: by wibhj6 with SMTP id hj6so3471903wib.1
        for <git@vger.kernel.org>; Mon, 07 May 2012 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=C+e29HEl8bEKSQdk792dZAVZSfdGwcghsRlVvfkm1ZI=;
        b=p16wuaV6Ri7Np0ooW+39LnqlF/ApIQd4SmOKk5WDandgTQo0AL06z0gSP7rJtpAUA2
         2iIXVqIJMSl5ZLYdjOy4STgTwEc96TDPVcjM6YfVqVG0itwv1icMXBcYiaIV8x6VJLOi
         QqiKAKnZs6Sa6c36gUs91xZkifyUy3BRBa07cqzHVb/uZoidvKO/gZ8gM/UKEE1sXIaY
         GMi9UyhuFflxeBIVRIHKetLep3fZctc++4pkrfoa1a+shfqfgv+3rkJOyWk8j5JEmwAt
         MJKiy77taY2nGGdSMpRNLs9CK3Ur7eAn5k+Ke5VPHDgD7NAcfxz0Itm373pf70JaD10V
         ywFw==
Received: by 10.180.92.130 with SMTP id cm2mr35737795wib.4.1336400243044; Mon,
 07 May 2012 07:17:23 -0700 (PDT)
Received: by 10.180.82.35 with HTTP; Mon, 7 May 2012 07:17:22 -0700 (PDT)
In-Reply-To: <87havs6v9s.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197274>

On Mon, May 7, 2012 at 5:46 PM, Thomas Rast <trast@student.ethz.ch> wro=
te:
> Jon Seymour <jon.seymour@gmail.com> writes:
> Oh, now I understand. =C2=A0Yes, specifying a revision C there acts m=
ostly as
> if you said
>
> =C2=A0git checkout C^0
> =C2=A0git svn dcommit
> =C2=A0git checkout -
>

Ok, I see my mistake - I had created the branch in SVN (using external
means, since git svn branch doesn't use an HTTP proxy), had failed to
fetch and then rebase my work onto remotes/<branch> and do the commit
from there. If I had done that, it would have worked as expected.

Thanks for your help.
