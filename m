From: walt <w41ter@gmail.com>
Subject: Is this a git-bisect bug?
Date: Sat, 21 Feb 2009 09:07:28 -0800
Message-ID: <gnpccl$l69$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 18:09:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LavLn-00044I-Aw
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 18:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbZBURHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 12:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbZBURHq
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 12:07:46 -0500
Received: from main.gmane.org ([80.91.229.2]:49803 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571AbZBURHp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 12:07:45 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LavKH-0003vJ-Kv
	for git@vger.kernel.org; Sat, 21 Feb 2009 17:07:41 +0000
Received: from adsl-69-234-214-52.dsl.irvnca.pacbell.net ([69.234.214.52])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Feb 2009 17:07:41 +0000
Received: from w41ter by adsl-69-234-214-52.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Feb 2009 17:07:41 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-214-52.dsl.irvnca.pacbell.net
User-Agent: Thunderbird/3.0a2pre (X11; 2009022105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110965>

I'm using the current git.git to bisect a bug in Linus.git.

I got this far and then ran into trouble:
good 2.6.29-rc5-00094-gc951aa6
bad  2.6.29-rc5-00112-g3501033

A glance at git log will show that those two commits were
both from Feb 17 with only one other commit between them.

So, why does this happen?:

$git bisect start 3501033 c951aa6
Bisecting: 8 revisions left to test after this
be716615fe596ee117292dc615e95f707fb67fd1] x86, vm86: fix preemption bug

git log shows that commit is from Jan 13, way back in 2.6.29-rc3.
Can anyone reproduce/explain this?

Thanks!
