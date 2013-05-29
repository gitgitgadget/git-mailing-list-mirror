From: Ian Harvey <iharvey@good.com>
Subject: Re: [PATCH 2/2] archive: loosen restrictions on remote object lookup
Date: Wed, 29 May 2013 12:05:41 +0000 (UTC)
Message-ID: <loom.20130529T133942-310@post.gmane.org>
References: <20120111193916.GA12333@sigill.intra.peff.net> <20120111194232.GB12441@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 14:10:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhfCm-0006H5-Jc
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 14:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965975Ab3E2MKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 08:10:05 -0400
Received: from plane.gmane.org ([80.91.229.3]:37187 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965564Ab3E2MKE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 08:10:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UhfCd-0006C9-0N
	for git@vger.kernel.org; Wed, 29 May 2013 14:10:03 +0200
Received: from 217.150.97.26 ([217.150.97.26])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 May 2013 14:10:02 +0200
Received: from iharvey by 217.150.97.26 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 May 2013 14:10:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 217.150.97.26 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:21.0) Gecko/20100101 Firefox/21.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225797>

So, did this patch make it anywhere? We could really use it.

Here's the use case. The original ee27ca4 patch broke our build system when
the git server was upgraded to Debian Wheezy last night. The builder fetches
source from the repo in two pieces using git archive, and we need to make
sure both pieces are from the same commit. So we get a sha1 hash with git
ls-remote, and use it with git archive --remote. This, of course, breaks
with the 'no such ref' error.

At the very least, the documentation is wrong when it talks about passing a
commit ID to git archive: maintainers must surely agree that the
documentation and the actual behavior ought to match.

Personally, I'd like to see this patch adopted.

Thanks for listening,
Ian
