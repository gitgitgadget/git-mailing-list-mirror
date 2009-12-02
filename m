From: Alejandro Riveira <ariveira@gmail.com>
Subject: warning in git version 1.6.6.rc0.114.gc8648
Date: Wed, 2 Dec 2009 17:21:04 +0000 (UTC)
Message-ID: <hf67m0$r10$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 18:22:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFsud-0004qR-9C
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 18:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755334AbZLBRVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 12:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755329AbZLBRVY
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 12:21:24 -0500
Received: from lo.gmane.org ([80.91.229.12]:39816 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755327AbZLBRVV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 12:21:21 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NFstK-0004AO-TL
	for git@vger.kernel.org; Wed, 02 Dec 2009 18:21:26 +0100
Received: from 75.red-88-24-214.staticip.rima-tde.net ([88.24.214.75])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 18:21:26 +0100
Received: from ariveira by 75.red-88-24-214.staticip.rima-tde.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 18:21:26 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 75.red-88-24-214.staticip.rima-tde.net
User-Agent: Pan/0.133 (House of Butterflies)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134356>

Whenever i do a "git pull" to check updates to the kernel
or git repo i recieve

warning: 'git merge <msg> HEAD <commit>' is deprecated. Please update
your script to use 'git merge -m <msg> <commit>' instead.
In future versions of git, this syntax will be removed.
Already up-to-date.

git pull should be updated to not use a deprecated form of git merge.

Regards
