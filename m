From: =?UTF-8?B?Sm9uYXMgRmxvZMOpbg==?= <jonas.floden@gmail.com>
Subject: [EGIT] Checking out signed tags fails
Date: Tue, 16 Sep 2008 14:58:52 +0200
Message-ID: <gaoaif$2up$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 15:01:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfaAJ-0004Rh-Jz
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 15:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610AbYIPM7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 08:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754589AbYIPM7L
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 08:59:11 -0400
Received: from main.gmane.org ([80.91.229.2]:42429 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753245AbYIPM7K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 08:59:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kfa91-00074r-L1
	for git@vger.kernel.org; Tue, 16 Sep 2008 12:59:03 +0000
Received: from c-d2c9e253.93-16-64736c12.cust.bredbandsbolaget.se ([83.226.201.210])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 12:59:03 +0000
Received: from jonas.floden by c-d2c9e253.93-16-64736c12.cust.bredbandsbolaget.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 12:59:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-d2c9e253.93-16-64736c12.cust.bredbandsbolaget.se
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95998>

When trying to check-out a signed tag I get the following Error:
Unable to switch branches

Reason:
  Mapping commit: refs/tags/v1.3.1.1

And in details:
Object XXX is not a commit.

The object ID shown is actually the id for the tag object and not the
tagged commit.

This was tested with the latest master. It seemed commit 1f460e2 (Tests
and fixes for dereferencing tags in Repository.resolve(), 2008-09-12)
would fix it, but it didn't.

Thanks,

Jonas
