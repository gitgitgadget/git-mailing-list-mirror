From: "George Spelvin" <linux@horizon.com>
Subject: Re: Git feature request: --amend older commit
Date: 17 Aug 2012 13:00:05 -0400
Message-ID: <20120817170005.27451.qmail@science.horizon.com>
References: <502E725B.2040906@alum.mit.edu>
Cc: git@vger.kernel.org
To: linux@horizon.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Aug 17 19:00:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2PuB-0004hc-1M
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 19:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951Ab2HQRAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 13:00:09 -0400
Received: from science.horizon.com ([71.41.210.146]:26218 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751764Ab2HQRAH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 13:00:07 -0400
Received: (qmail 27452 invoked by uid 1000); 17 Aug 2012 13:00:05 -0400
In-Reply-To: <502E725B.2040906@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203624>

> Have you tried "git rebase --autosquash"?  It does part of what you are 
> asking for and additionally allows multiple fixup commits to be queued 
> up and processed in a single rebase.

No, I hadn't!  It's not *quite* as simple as what I had hoped for, but
definitely is progress in that direction.

In particular, I can probably manage to use those to write a script that
does what I want.  Something that ends up with something like
"EDITOR=/bin/true git rebase -i --autosquash $base"

Thanks you!  I apologize for my failure to (Re-) RTFM.  I have done so
numerous times, but the feature wasn't there last time I looked.
