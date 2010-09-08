From: Stephen Bash <bash@genarts.com>
Subject: git log for a merged branch
Date: Wed, 8 Sep 2010 10:04:34 -0400 (EDT)
Message-ID: <14267801.230161.1283954674012.JavaMail.root@mail.hq.genarts.com>
References: <22744209.230141.1283954076245.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 08 16:04:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtLGa-0001bu-9k
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 16:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368Ab0IHOEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 10:04:42 -0400
Received: from hq.genarts.com ([173.9.65.1]:37652 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752264Ab0IHOEl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 10:04:41 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 097E41E2629B
	for <git@vger.kernel.org>; Wed,  8 Sep 2010 10:04:40 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4fhOWju6XHuk for <git@vger.kernel.org>;
	Wed,  8 Sep 2010 10:04:34 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 1D35A1E26254
	for <git@vger.kernel.org>; Wed,  8 Sep 2010 10:04:34 -0400 (EDT)
In-Reply-To: <22744209.230141.1283954076245.JavaMail.root@mail.hq.genarts.com>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155784>

Hi everyone-

A coworker asked me a Git question yesterday that I can't answer, so I thought I'd pass it along:

Assume I have a release branch with bug fixes that is tagged at the end of the release cycle (let's call the tag tagFoo).  The release branch then gets merged back into mainline development (call the branch mainline), and the release branch is deleted.  If I want to see the commits (bug fixes) performed on the release branch, how do I do it?

I don't think
   git log mainline..tagFoo
works because all the commits of tagFoo are now reachable by mainline thanks to the merge.  Is there a simple way to express this concept?

Obviously in a pinch a simple
   git log tagFoo
will give you everything back to the beginning of time, but I think that's suboptimal...

To complicate things a bit more, in the real world there may be multiple merges from the release branch to mainline during the life of the release branch, so any solution that also deals with that would be outstanding (probably at the cost of additional complexity?)

Thanks,
Stephen
