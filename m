From: Dror Livne <dror.livne@mobileye.com>
Subject: Fetch and refs/remotes/<refname>/HEAD
Date: Mon, 3 Aug 2015 13:28:05 +0000 (UTC)
Message-ID: <loom.20150803T151815-131@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 03 15:35:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMFtg-0006Ux-68
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 15:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022AbbHCNfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 09:35:13 -0400
Received: from plane.gmane.org ([80.91.229.3]:58348 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751947AbbHCNfM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 09:35:12 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZMFtR-0006P9-Nf
	for git@vger.kernel.org; Mon, 03 Aug 2015 15:35:06 +0200
Received: from fw.mobileye.com ([94.188.132.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 15:35:05 +0200
Received: from dror.livne by fw.mobileye.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 15:35:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 94.188.132.2 (Mozilla/5.0 (X11; Linux i686; rv:39.0) Gecko/20100101 Firefox/39.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275166>

I have noticed that when cloning a repository, I get a
refs/remotes/origin/HEAD symbolic ref.

On the other hand, when fetching a new remote, the remote HEAD is not set by
git-fetch (but can be added later by `git remote set-head ...')

I was under the impression that clone is equivalent to (at least) init+fetch.

Is there a rationale for that difference in behavior?

Dror Livne
