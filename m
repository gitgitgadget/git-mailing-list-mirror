From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Fwd: [PATCH] git-svn: added an --include-path flag
Date: Wed, 24 Apr 2013 21:28:56 +0000
Message-ID: <20130424212856.GA23696@dcvr.yhbt.net>
References: <CAHpQJx0iT_+pOzdEJ-uyn7GjkXs8ZwhfPoMYpQDxwAB5mQ1xrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Paul Walmsley <pjwhams@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 23:29:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV7FS-00037M-UT
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 23:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758388Ab3DXV26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 17:28:58 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54140 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758073Ab3DXV25 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 17:28:57 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2594C1F5B5;
	Wed, 24 Apr 2013 21:28:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAHpQJx0iT_+pOzdEJ-uyn7GjkXs8ZwhfPoMYpQDxwAB5mQ1xrw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222328>

Paul Walmsley <pjwhams@gmail.com> wrote:
> Hi,
> Please forgive the direct approach, but I submitted a git-svn patch to the
> git list which sank without any comment. As major contributors to git-svn I
> would like to solicit your feedback on it. The patch is so that git svn
> clone supports '--include-path' as a complement to '--ignore-path'.  I had
> a need for this as our SVN repository has many top level folders of which
> only a few may be needed for any project.  I wanted to contribute the patch
> back as I think it may be useful to others. I've included unit tests too.

No forgivness necessary, it's standard practice to Cc maintainers in git
(and Linux kernel) patch submissions :)

(Re-adding git ML-as Cc)

> --- /dev/null
> +++ b/t/t9147-git-svn-include-paths.sh
> @@ -0,0 +1,150 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2009 Vitaly Shukela
> +# Copyright (c) 2009 Eric Wong

Use your name (and current year) in copyright headers for your
submissions.


I'll take a closer look at the rest of the patch later, but your patch
below appears line-wrapped and mangled (see
Documentation/SubmittingPatches).

Also, we'd greatly appreciate you omit HTML from emails in the future.

Thanks.
