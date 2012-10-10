From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: git checkout error
Date: Wed, 10 Oct 2012 10:52:11 +0200
Message-ID: <CAB9Jk9BmwuGXsQmQR3Ck58h2uA4gam8n-VWJTwgv_puJZB2sXg@mail.gmail.com>
References: <CAB9Jk9DUEL_J3MmH_4k7NC82m+crpCf1r3NS3gQBMZy+kvY3-A@mail.gmail.com>
	<m2lifg7zsj.fsf@igel.home>
	<CAB9Jk9CZ8d=8ugYs7XHXs84Kj9xJmTHZyZ2J0hU66OBS7YDZTg@mail.gmail.com>
	<7v626jdx8f.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9AFnauxX0dk8LfpBkpGDSWpWhqnzVew1Eo51K+qEA680A@mail.gmail.com>
	<7vpq4qdbas.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andreas Schwab <schwab@linux-m68k.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 10:52:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLs1i-0005Ew-59
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 10:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511Ab2JJIwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 04:52:14 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:62347 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab2JJIwM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 04:52:12 -0400
Received: by mail-vc0-f174.google.com with SMTP id fo13so442867vcb.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 01:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=B6IjLT0nrdL44dbjxVE6ogLJTNStQC2hi4cLdYNDomY=;
        b=zugqKGdaFt3fJzEWJcUIriQPZ5cB8XqGe4p3JCrSOYXnRrs4z67w2mYXR1I91v9OdK
         s73pnIOfN6pTjFEwuF+DNPKxecGRB/lDK/AS08S51s4AuvR/zE0v0ZJ/stqcG9FKiBdu
         rXBUGlK4rE11TDponFcY0LhmIoGDXuxwlikcDPCzbwJa4D312tKV6AlKjtKPdPir/lR2
         4IoxMZ/tdSFd0YlzFevFVOxuaH46kO5Ygf2KB4EOQdvpk/S7pw3JJU2XQ+d+FpPBC6bY
         7ItoaWkb1WxPQ4/4F7dJDrTmykUBjHaOztVNMwZVaRASBTTaCngwAMdUOvOwFpkGo/pN
         eTRQ==
Received: by 10.52.100.229 with SMTP id fb5mr3517402vdb.103.1349859131755;
 Wed, 10 Oct 2012 01:52:11 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Wed, 10 Oct 2012 01:52:11 -0700 (PDT)
In-Reply-To: <7vpq4qdbas.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207380>

Hi Junio

> It is not difficult.  The discussion on this list is usually done
> via patches, and without one, constant talking is buried in other
> noise and often go unnoticed.

Could you accept for very small changes also the simple indication of
the change itself instead of a patch?

>
> There is however an issue about documentation consistency.  Do we
> use elsewhere ( A | B | C ... ) to denote "You must write one (and
> only one) among A, B, C, ..." consistently in the documentation?

There is no standard for it. Posix provides a standard for commands:

     http://pubs.opengroup.org/onlinepubs/9699919799/

but does not mention (normal) parentheses to indicate choice.
There is one applicable standard for this, though, the ISO 14977:

     http://www.cl.cam.ac.uk/~mgk25/iso-14977.pdf

which gives parentheses "()" the meaning of grouping (and then with "|"
inside them, the meaning of choice).
Parentheses are used in:

    - git branch
    - git commit
    - git reset
    - git remote
    - git submodule
    - git bisect
    - git grep
    - git am
    - git apply
    - git format-patch
    - git cat-file
    - git commit-tree
    - git rev-list
    - git update-index

I did not find in the documentation an explanation of the use of
parentheses, but
to me they seem to have been used consistently.

-Angelo
