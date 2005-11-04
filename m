From: walt <wa1ter@myrealbox.com>
Subject: Empty temp files in the .git/objects subdirectories
Date: Thu, 03 Nov 2005 16:56:58 -0800
Organization: none
Message-ID: <dkebkq$ova$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 04 02:01:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXpwF-000412-DI
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 02:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbVKDBAH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 20:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbVKDBAC
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 20:00:02 -0500
Received: from main.gmane.org ([80.91.229.2]:52876 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161051AbVKDA74 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2005 19:59:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EXpuL-0002xP-KV
	for git@vger.kernel.org; Fri, 04 Nov 2005 01:58:17 +0100
Received: from adsl-69-234-197-53.dsl.irvnca.pacbell.net ([69.234.197.53])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Nov 2005 01:58:17 +0100
Received: from wa1ter by adsl-69-234-197-53.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Nov 2005 01:58:17 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-197-53.dsl.irvnca.pacbell.net
User-Agent: Mail/News 1.6a1 (X11/20051103)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11113>

I've noticed (sometimes) after using cg-update to
pull from Linus's kernel tree, that I have multiple
empty files named *.temp in the various subdirectories
of .git/objects/.

These *.temp files don't exist in Linus's repository
on kernel.org, so I am assuming they must be created
locally at my end by either cogito or git (dunno which).

They cause no problems except for annoying warning
messages, for example, while doing a git-fsck-*.

I'm using git and cogito(HEAD), both updated by using
cg-update from their git repositories on kernel.org,
so I'm current up to the very last minute :o)

Any suggestions how I can discover who is leaving
behind all these spurious empty *.temp files?
