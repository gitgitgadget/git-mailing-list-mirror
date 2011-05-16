From: Stephen Bash <bash@genarts.com>
Subject: Maint-only commits
Date: Mon, 16 May 2011 17:15:26 -0400 (EDT)
Message-ID: <6416457.30612.1305580526325.JavaMail.root@mail.hq.genarts.com>
References: <10397477.30610.1305580263246.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 23:15:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM58f-0007Mh-EE
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 23:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664Ab1EPVPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 17:15:34 -0400
Received: from hq.genarts.com ([173.9.65.1]:27133 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753671Ab1EPVPd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 17:15:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id B323BEA2320
	for <git@vger.kernel.org>; Mon, 16 May 2011 17:15:32 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jFRY4vFTyNez for <git@vger.kernel.org>;
	Mon, 16 May 2011 17:15:26 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 88372EA2304
	for <git@vger.kernel.org>; Mon, 16 May 2011 17:15:26 -0400 (EDT)
In-Reply-To: <10397477.30610.1305580263246.JavaMail.root@mail.hq.genarts.com>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173762>

Hi all-

In my office we've recently run into three separate fixes required on our maintenance branch that should not be included in master (our normal workflow is to make changes on maint, tag, release, and then merge to master).  Normally these "maint only" fixes are interspersed with commits that should go back into master.  In the past the "maint only" commits were rare, so I'd carefully use "merge -s ours" to avoid including the "maint only" changes in master.  But now I'm wondering if there's a better process/workflow?  Certainly a well crafted alias or custom command makes the user's life easier, but still clutters master with "extra" merges.

Any thoughts?  Thanks!

Stephen
