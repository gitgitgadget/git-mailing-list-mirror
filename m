From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git svn: add an option to recode pathnames
Date: Fri, 30 Jul 2010 07:59:21 +0000
Message-ID: <20100730075921.GA9596@dcvr.yhbt.net>
References: <ylnfxcfdeyq.fsf@tmsoft-ltd.kiev.ua> <20090729185919.GA13518@dcvr.yhbt.net> <4C523935.5070504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Statyvka <dstatyvka@tmsoft-ltd.kiev.ua>, git@vger.kernel.org
To: Robert Pollak <robert.pollak@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 09:59:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OekV5-0006nI-ST
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 09:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588Ab0G3H7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 03:59:23 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54615 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303Ab0G3H7W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 03:59:22 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id C93C91F505;
	Fri, 30 Jul 2010 07:59:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4C523935.5070504@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152222>

Robert Pollak <robert.pollak@gmail.com> wrote:
> Introduce a new option 'svn.pathnameencoding' that instructs git svn to
> recode pathnames to a given encoding.  It can be used by windows users
> and by those who work in non-utf8 locales to avoid corrupted file names
> with non-ascii characters.
> 
> Signed-off-by: Dmitry Statyvka <dstatyvka@tmsoft-ltd.kiev.ua>
> [robert.pollak@gmail.com: renamed the option and added manpage documentation]
> Signed-off-by: Robert Pollak <robert.pollak@gmail.com>
> ---
> 
> Hello Eric,
> 
> since the patch is useful to me, I have made the requested option name
> change and added some manpage documentation. Please consider applying the
> patch or give me additional feedback.

Thanks Robert!

It looks alright to me and I've acked and pushed it out to
git://git.bogomips.org/git-svn (crediting Dmitry as the author)

If it's not too much trouble, having a test case to ensure it stays
working with future changes would be nice.

> This is the first patch I submit on this list, so I hope it's ok.

For addendum changes, the standard we seem to have adopted is
first initials above the Signed-off/Acked-by lines:

>From 3713e2226bcda64513efd537f370ce4d7f767a1e Mon Sep 17 00:00:00 2001
From: Dmitry Statyvka <dstatyvka@tmsoft-ltd.kiev.ua>
Date: Fri, 30 Jul 2010 04:30:13 +0200
Subject: [PATCH] git svn: add an option to recode pathnames

Introduce a new option 'svn.pathnameencoding' that instructs git svn to
recode pathnames to a given encoding.  It can be used by windows users
and by those who work in non-utf8 locales to avoid corrupted file names
with non-ascii characters.

[rp: renamed the option and added manpage documentation]

Signed-off-by: Dmitry Statyvka <dstatyvka@tmsoft-ltd.kiev.ua>
Signed-off-by: Robert Pollak <robert.pollak@gmail.com>
Acked-by: Eric Wong <normalperson@yhbt.net>
---
<snip>
-- 
Eric Wong
