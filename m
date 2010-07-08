From: Hal Eisen <eisen@dunhackin.org>
Subject: Question about git revert
Date: Wed, 7 Jul 2010 18:50:19 -0700
Message-ID: <20100708015019.GP10042@volcano.builtonlinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 08 03:57:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWgMQ-0003Zx-AM
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 03:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758341Ab0GHB5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 21:57:05 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.39]:47251 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756080Ab0GHB5D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 21:57:03 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Jul 2010 21:57:03 EDT
Received: (qmail 23413 invoked from network); 8 Jul 2010 01:50:20 -0000
Received: from dsl092-009-231.sfo1.dsl.speakeasy.net (HELO volcano.builtonlinux.com) ([66.92.9.231])
          (envelope-sender <eisen@volcano.builtonlinux.com>)
          by mail1.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <eisen@dunhackin.org>; 8 Jul 2010 01:50:20 -0000
Received: by volcano.builtonlinux.com (Postfix, from userid 1000)
	id B2F313E70B; Wed,  7 Jul 2010 18:50:19 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150525>

I did a search of the archives for this mailing list, and couldn't
find anything applicable.

I am having the same problem as Joshua Cheek.  He asked this question
on StackOverflow about a month ago.

http://stackoverflow.com/questions/2938301/git-remove-specific-commit

There are no merges involved.  I would be perfectly happy having
another commit in my history which documents the reverting of a prior
commit.

The problem seems to stem from git-revert not properly calculating the
"cleanness" of the prior commit, and incorrectly thinking that later
commits depend on the to-be-reverted commit.

I have seen other web sites which suggest using git to manually
generate a diff, and then applying it as a reverse patch, but that
seems like a kludge.

What is the best solution for this use case?

Thanks,
Hal
