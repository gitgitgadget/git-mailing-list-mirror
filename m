From: Ryan Anderson <ryan@michonline.com>
Subject: Re: What's in git.git
Date: Thu, 9 Feb 2006 19:40:40 -0500
Message-ID: <20060210004040.GB2866@mythryan2.michonline.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05AA1FB3@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 01:42:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7MMM-0003KN-4V
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 01:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWBJAly (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 19:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWBJAly
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 19:41:54 -0500
Received: from mail.autoweb.net ([198.172.237.26]:50382 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1750888AbWBJAlx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 19:41:53 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1F7MM9-0003Ux-AW; Thu, 09 Feb 2006 19:41:50 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1F7MM8-0007af-6F; Thu, 09 Feb 2006 19:41:48 -0500
Received: from ryan by mythical with local (Exim 4.60)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1F7MLa-0000pU-4V; Thu, 09 Feb 2006 19:41:14 -0500
To: "Luck, Tony" <tony.luck@intel.com>
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F05AA1FB3@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15848>

On Thu, Feb 09, 2006 at 03:49:16PM -0800, Luck, Tony wrote:
> Looks very close to what I want.
> 
> > git checkout topic
> > git format-patch --stdout origin > topic-diff
> 
>  topic-diff contains each commit as a separate message
> 
> > $VISUAL topic-diff
> > # Fix comments
> 
>  so this needs some skill & care to rearrange the pieces
>  and end up with legal input to git-am

Doh, right, I was thinking "git apply" actually.  (Apply the whole thing
as  single diff - the comments from each commit in the middle should get
ignored.)

Note that I don't believe there is any need to combine the hunks, just
stick them there in order and it *should* do the right thing.

> Perhaps I'd like to have:
> 
>  git diff SHA-where-I-branched..HEAD
> 
> but I don't see the way to compute the SHA-where-I-branched

git-merge-base topic master ?

-- 

Ryan Anderson
  sometimes Pug Majere
