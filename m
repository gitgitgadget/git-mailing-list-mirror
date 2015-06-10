From: Ed Avis <eda@waniasset.com>
Subject: Re: [PATCH] git-checkout.txt: Document "git checkout <pathspec>" better
Date: Wed, 10 Jun 2015 15:11:57 +0000 (UTC)
Message-ID: <loom.20150610T170737-586@post.gmane.org>
References: <5575F948.4060400@web.de> <xmqqioavob7n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 17:12:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2hgY-00079o-QE
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 17:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933662AbbFJPMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 11:12:41 -0400
Received: from plane.gmane.org ([80.91.229.3]:60327 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933490AbbFJPMT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 11:12:19 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Z2hfq-0006gs-4E
	for git@vger.kernel.org; Wed, 10 Jun 2015 17:12:14 +0200
Received: from 80.169.169.174 ([80.169.169.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 17:12:14 +0200
Received: from eda by 80.169.169.174 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 17:12:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.169.169.174 (Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:38.0) Gecko/20100101 Firefox/38.0 Cyberfox/38.0.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271298>

'restore' may be more consistent with git's internal terminology.
But from an outsider's perspective, 'revert' rather than 'restore' is in my
view much clearer and more consistent with other version control systems:
for example 'svn revert' is what you use to revert files in the working copy.

The original issue was that I naively expected that 'git checkout PATH' would
indeed just 'restore' some files, that is, create them when they are missing.
Its action is rather more drastic than that.

If 'revert' is not a suitable verb because of the existing git-revert, then
I suggest that 'overwrite' or 'replace' might better convey the idea of what
the command does.

-- 
Ed Avis <eda@waniasset.com>
