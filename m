From: =?windows-1251?B?wOvl6vHl6SDY8+zq6O0=?= <zapped@mail.ru>
Subject: Merge two different repositories (v2.4 + v2.5) into the one (v2.4 -> v2.5). Possible?
Date: Tue, 11 Jan 2011 13:41:01 +0300
Message-ID: <746745466.20110111134101@mail.ru>
Reply-To: =?windows-1251?B?wOvl6vHl6SDY8+zq6O0=?= <zapped@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 11 11:41:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcbfA-0004vu-6c
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 11:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755697Ab1AKKlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 05:41:13 -0500
Received: from smtp5.mail.ru ([94.100.176.132]:51024 "EHLO smtp5.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755645Ab1AKKlF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 05:41:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:Message-ID:Reply-To:From:Date; bh=yU7++y4YjGTj/ovJ6Y68SyklL1ynNH2aGBXqC1sUUSQ=;
	b=HQuS66qNeKiVyQcJEsS0VSqvcLNW2RSohn/4me6JxUjuB2dVgjQP6dAaO8oE9rgXjl97K61jy2mxuZ7adm7v+giCwZLpJbwaedVvZoUhys00x6wBk5f6Jz+/DRXs2I8d;
Received: from [85.140.106.43] (port=44160 helo=ppp85-140-106-43.pppoe.mtu-net.ru)
	by smtp5.mail.ru with asmtp 
	id 1Pcbex-00071v-00
	for git@vger.kernel.org; Tue, 11 Jan 2011 13:41:03 +0300
X-Mailer: The Bat! (v3.99.3) Professional
X-Priority: 3 (Normal)
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164927>

Hi all!

1.5 years ago I had sources of a project in a SVN repository (actually it does not
matter what SCM was used before). And I had two branches: v2.4 and v2.5.
They differed enough at that moment and (as usual for SVN branches)
laid in two different folders.
Then I had known of Git and I decided to try to use this powerful DVCS.
But as I was a newbie I created two git-repositories: one per each
branch. So v2.4 has its own git-repo. v2.5 (and above) has another one.

Now I'd like to merge them as v2.5 was a continuos branch from v2.4,
but without a rebasing (i.e. without a global changing of v2.5
repository, which already has another branches)
It must look like LAST commit of v2.4 should be a PARENT of FIRST commit of v2.5

Now there's a question: Is it possible to do so (no rebasing!), and If
"yes" then how to?
