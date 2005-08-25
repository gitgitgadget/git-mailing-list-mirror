From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [ANNOUNCE] GIT 0.99.5
Date: Thu, 25 Aug 2005 15:30:53 +1200
Message-ID: <46a038f9050824203027fbca0@mail.gmail.com>
References: <7vr7ci4u7q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 05:32:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E88SH-0003r8-O2
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 05:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbVHYDbA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 23:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbVHYDbA
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 23:31:00 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:43068 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964780AbVHYDbA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2005 23:31:00 -0400
Received: by rproxy.gmail.com with SMTP id i8so223669rne
        for <git@vger.kernel.org>; Wed, 24 Aug 2005 20:30:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hje4pjRKcQrxKS13lrRvKFP3csbMhR6FjDUIdNOGavzSz9uhh3rsSHN5mJGDyoD2LUFG+1AJSFKjMVPoceSJwCXj+QZjRU533+Ke/xhce72yREK/6k5zOHl+SEfMtqgnLcfySV1c1eoGFuTYgKb23QfaOEzYDuItEP5YuYo22wM=
Received: by 10.39.3.42 with SMTP id f42mr729683rni;
        Wed, 24 Aug 2005 20:30:53 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Wed, 24 Aug 2005 20:30:53 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7ci4u7q.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7741>

On 8/25/05, Junio C Hamano <junkio@cox.net> wrote:
> Have fun.

Yay!

> What to expect after 0.99.5
> ===========================

> Documentation
> -------------

Perhaps link the 'howto' docs from the git formal docs, so they are
visible via http://www.kernel.org/pub/software/scm/git/docs/

> * Accept patches from people who actually have done CVS
>   migration and update the cvs-migration documentation.
>   Link the documentation from the main git.txt page.

Yup, run trial conversions for about half a dozen cvs repos, and
currently tracking external cvs projects with git too. Will update
docs as I find time.

> * Update tutorial to cover shared repository style a bit more,
>   maybe with a toy project that involves two or three
>   repositories.

I recently wrote one such 'shared repo' tutorial for internal
consumption at work. Should clean it up, and add to the howto dir. The
incentive here would be to see the howtos on the web - and then I can
point people at it directly.

> Technical (milder)
> ------------------

Personally, I want to complete the Arch import. I'm interested in
feedback on the current code -- anyone has an interest in migration
from Arch or similar patch-centric SCM?

cheers,


martin
