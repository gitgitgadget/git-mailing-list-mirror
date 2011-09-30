From: Peter Shenkin <shenkin@gmail.com>
Subject: Re: [PATCH] Clarify that '--tags' fetches tags only
Date: Fri, 30 Sep 2011 02:51:21 +0000 (UTC)
Message-ID: <loom.20110930T041939-332@post.gmane.org>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com> <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com> <119711285.RuumktFLOq@hyperion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 05:20:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Te2-00069t-Ei
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 05:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756689Ab1I3DUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 23:20:07 -0400
Received: from lo.gmane.org ([80.91.229.12]:38755 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756588Ab1I3DUG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 23:20:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R9Tdt-00068S-4l
	for git@vger.kernel.org; Fri, 30 Sep 2011 05:20:05 +0200
Received: from h-67-101-25-249.nycmny83.dynamic.covad.net ([67.101.25.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 05:20:05 +0200
Received: from shenkin by h-67-101-25-249.nycmny83.dynamic.covad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 05:20:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 67.101.25.249 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.835.186 Safari/535.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182462>

Hi,

I just searched the List to see if there were any postings on
"fetch --tags", because I was recently  thrown for a loop by
the fact the this command retrieves only tags (and commits
needed to fulfill them). So I was very happy to find this
discussion. I was actually trying to figure out whether the
observed behavior is a bug, given that there is no mention of
it in the documentation.

Perhaps it will be useful to say what would have been most
helpful for me. In the current documentation for "fetch
--tags", one sentence reads, "This flag lets all tags and
their associated  objects be downloaded." The following small
modification would, IMO, be sufficient: "This flag causes all
tags and their associated objects (only) to be downloaded."

Now I have a related question. I always want to retrieve all
tags from tracking branches when I do a "git pull". Right now,
if I want to do this, it seem (unless I am missing something)
that I have to do "git fetch --tags; git fetch;  git merge". Is
there a way I can put something into my .git/config file so
that I get this effect simply by doing a "git pull"? That's
what I was trying to do when I added "tagopt = --tags".

Thanks,
-P.
