From: Jake Goulding <goulding@vivisimo.com>
Subject: Re: [PATCH] Add --contains flag to git tag
Date: Tue, 20 Jan 2009 22:54:36 -0500 (EST)
Message-ID: <25058429.247441232510076471.JavaMail.root@scalix.vivisimo.com>
References: <20090121032058.GG21473@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jan 21 04:56:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPUCL-00080T-PK
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 04:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756932AbZAUDyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 22:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755601AbZAUDyi
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 22:54:38 -0500
Received: from scalix.vivisimo.com ([207.97.211.28]:58698 "EHLO
	mail.vivisimo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755922AbZAUDyh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 22:54:37 -0500
Received: from mail.vivisimo.com (localhost [127.0.0.1])
	by mail.vivisimo.com (Postfix) with ESMTP id 900DA852646;
	Tue, 20 Jan 2009 22:54:36 -0500 (EST)
In-Reply-To: <20090121032058.GG21473@genesis.frugalware.org>
X-Originating-IP: [72.65.210.219]
X-Mailer: Zimbra 5.0.9_GA_2534.RHEL4 (ZimbraWebClient - FF3.0 (Mac)/5.0.9_GA_2534.RHEL4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106566>

That is actually in a subsequent commit (in my unmarked patch sequence). 

I actually have 1 commit for the code change, one for documentation, and one for the test case. Should I squash all these together?

Also, my test case is in a separate file (t7704-tag-contains.sh) as that is how I read t/README. Was this incorrect?

Thanks!

-Jake

----- Original Message -----
From: "Miklos Vajna" <vmiklos@frugalware.org>
To: "Jake Goulding" <goulding@vivisimo.com>
Cc: git@vger.kernel.org
Sent: Tuesday, January 20, 2009 10:20:58 PM GMT -05:00 US/Canada Eastern
Subject: Re: [PATCH] Add --contains flag to git tag

On Tue, Jan 20, 2009 at 08:37:09PM -0500, Jake Goulding <goulding@vivisimo.com> wrote:
> Please let me know what else I have inevitably messed up, and I shall
> endeavor to fix and resubmit. 

Please document your improvements in Documentation/git-tag.txt and don't
forget to add a testcase to t7004-tag.sh.
