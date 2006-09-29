From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Make cvsexportcommit work with filenames containing spaces.
Date: Fri, 29 Sep 2006 09:25:10 +0200
Message-ID: <200609290925.11909.robin.rosenberg@dewire.com>
References: <20060922223506.3377.34859.stgit@lathund.dewire.com> <200609290128.56217.robin.rosenberg@dewire.com> <7vy7s3npo9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 09:25:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTCk2-0002qS-C9
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 09:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161470AbWI2HY7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 03:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161471AbWI2HY7
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 03:24:59 -0400
Received: from [83.140.172.130] ([83.140.172.130]:21868 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S1161470AbWI2HY6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Sep 2006 03:24:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id 3B4F4802898;
	Fri, 29 Sep 2006 09:22:07 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 00958-04; Fri, 29 Sep 2006 09:22:06 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [10.1.2.238])
	by torino.dewire.com (Postfix) with ESMTP id D71B180288F;
	Fri, 29 Sep 2006 09:22:04 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.4
In-Reply-To: <7vy7s3npo9.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28099>

fredag 29 september 2006 08:37 skrev Junio C Hamano:
> Please do not do more than one patch per e-mail; I'll have to
> save the attachment in separate files and manually make commits,
> which is more work.
>
> The build procedure for the release to build rpms runs testsuite
> as part of it, so I need to think a bit how to proceed with this
> patch.  Leaving the test failing on FC5 means I won't be able to
> cut binary releases.  Checking early in the test script to see
> if "patch" can grok a diff for a file with whitespaces, and
> skipping the whitespace test if we have a bad "patch", seems to
> the best workaround.
>
> BTW, the addition of TAB to the patch tail is done by "git diff"
> automatically for files with whitespace in them in the proposed
> updates version in "pu" (and it is done conditionally only for
> files whose names have whitespace), so I think your fix will
> become redundant when it graduates to "master".

But, then I can stop here, because that sounds like a much better solution. My
hack is kind-of-kludgy anyway. I'll look in the pu branch. Still want the test 
cases, although not complete?

-- robin
