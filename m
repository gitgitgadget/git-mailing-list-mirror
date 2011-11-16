From: MikeW <mw_phil@yahoo.co.uk>
Subject: feature request: git format-patch - allow --suffix to work with --numbered-files
Date: Wed, 16 Nov 2011 13:02:52 +0000 (UTC)
Message-ID: <loom.20111116T135509-236@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 14:15:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQfKm-00081y-P6
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 14:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756833Ab1KPNPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 08:15:14 -0500
Received: from lo.gmane.org ([80.91.229.12]:54133 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756783Ab1KPNPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 08:15:11 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RQfKX-0007uQ-3w
	for git@vger.kernel.org; Wed, 16 Nov 2011 14:15:09 +0100
Received: from 94.72.250.67 ([94.72.250.67])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 14:15:09 +0100
Received: from mw_phil by 94.72.250.67 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 14:15:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 94.72.250.67 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110927 Fedora/3.6.23-1.fc14 Firefox/3.6.23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185543>

"Numbered files" is good for creating patches with uniform filenames, rather
than verbose filenames containing part of the commit message, but if working for
example with submodules, there is possible name collision if pooling the patches
in one place.

I thought that --suffix=$name would be a good way to disambiguate but found that
--numbered-files wins and kills any suffix.

Hence suggestion that --suffix used with --numbered-files is allowed to generate
a filename suffix as it does when not in "numbered files" mode.

In the absence of a --suffix command, the behaviour would be as now.
