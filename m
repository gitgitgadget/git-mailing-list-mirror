From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH] contrib: add a credential helper for Mac OS X's keychain
Date: Wed, 14 Sep 2011 06:24:39 -0400
Message-ID: <CAEBDL5X9jic1GVNWdWVcvSfWELTu79oE2eEiPHEsxS0hV+ZigA@mail.gmail.com>
References: <1315683874-95583-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <junio@kernel.org>,
	Jeff King <peff@peff.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 12:24:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3me8-0001mF-MR
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 12:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756340Ab1INKYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 06:24:41 -0400
Received: from mail-vw0-f42.google.com ([209.85.212.42]:42224 "EHLO
	mail-vw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756269Ab1INKYk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 06:24:40 -0400
Received: by vwl1 with SMTP id 1so2507366vwl.1
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 03:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=oLqKEmX9Z0kqt9irhCGhaBLcHXJ5+mDkXAMk/c5Edcs=;
        b=CyUbraWYm6FDiNkW/AqwjDsvgbmPBhq1mWZEEdzXiePFnc9DMQ3hD/p2QGwT0cZIYS
         75u2xk9GuHv17UAOZR7ugsJWz69lFCuyWDIzjPbXw7ppgCh6cb384iQyZ4kmaCXlPQsj
         LHCVBXwAfgMsyupXaO9jx6ORfnrG/k7S9p/QA=
Received: by 10.52.91.115 with SMTP id cd19mr3311774vdb.526.1315995879573;
 Wed, 14 Sep 2011 03:24:39 -0700 (PDT)
Received: by 10.52.160.196 with HTTP; Wed, 14 Sep 2011 03:24:39 -0700 (PDT)
In-Reply-To: <1315683874-95583-1-git-send-email-jaysoffian@gmail.com>
X-Google-Sender-Auth: 5l2uvr55QifjYfL6uufflt3R4kc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181349>

On Sat, Sep 10, 2011 at 3:44 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> A credential helper which uses /usr/bin/security to add, search,
> and remove entries from the Mac OS X keychain.
>
> Tested with 10.6.8.
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
> This is a quick script to explore the new credential API. A more robust
> implementation would be to link to OS X's Security framework from C.

I'm pretty close with a version of this that is written in C.  I've
done it as a completely separate build from git, although it probably
wouldn't be hard to make it build in the contrib area.

If no one else picks it up, I may look at doing a version against the
secrets api for Linux too.

-John
