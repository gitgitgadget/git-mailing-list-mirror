From: Stephen Bash <bash@genarts.com>
Subject: Merging split files
Date: Fri, 18 Mar 2011 09:22:36 -0400 (EDT)
Message-ID: <2495196.195017.1300454556155.JavaMail.root@mail.hq.genarts.com>
References: <31155742.183989.1300374518689.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 14:22:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0Zdi-0001N7-Gg
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 14:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756502Ab1CRNWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 09:22:44 -0400
Received: from hq.genarts.com ([173.9.65.1]:55966 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756420Ab1CRNWo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 09:22:44 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id C38BAEA2350
	for <git@vger.kernel.org>; Fri, 18 Mar 2011 09:22:42 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jFgg0-9q+R7o for <git@vger.kernel.org>;
	Fri, 18 Mar 2011 09:22:36 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 53CA4EA22DF
	for <git@vger.kernel.org>; Fri, 18 Mar 2011 09:22:36 -0400 (EDT)
In-Reply-To: <31155742.183989.1300374518689.JavaMail.root@mail.hq.genarts.com>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169317>

Hi all-

In our previous release foo.cxx contained both the base class and a few subclasses.  Since then the number of subclasses has grown, and we've split foo.cxx (base and sub-classes) into foo-base.cxx (base class) and foo-defs.cxx (sub-classes).  Since the release, we've had a few bug fixes in foo.cxx on the maintenance branch, and need to merge those back to development.  When I did the merge Git identified foo.cxx as moved to foo-defs.cxx, which worked for most changes, but a few needed to be in foo-base.cxx.  In this case it was a pretty trivial manual resolution, but is there a method for handling merges of split files?

Thanks,
Stephen
