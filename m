From: Brian Foster <brian.foster@maxim-ic.com>
Subject: [Q] Comparing differences introduced by two commits?
Date: Wed, 22 Aug 2012 14:10:12 +0200
Message-ID: <2794881.R5SsgFdXjR@laclwks004>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 22 14:30:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4A4Z-0004qV-TJ
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 14:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755911Ab2HVMaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 08:30:05 -0400
Received: from antispam01.maxim-ic.com ([205.153.101.182]:54429 "EHLO
	antispam01.maxim-ic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864Ab2HVMaD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 08:30:03 -0400
X-Greylist: delayed 1183 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Aug 2012 08:30:03 EDT
X-ASG-Debug-ID: 1345637417-02ae98188a278120001-QuoKaX
Received: from maxdalex01.maxim-ic.internal (maxdalex01.maxim-ic.internal [10.16.15.101]) by antispam01.maxim-ic.com with ESMTP id 8oSaFtIEoBcq4CrA for <git@vger.kernel.org>; Wed, 22 Aug 2012 07:10:17 -0500 (CDT)
X-Barracuda-Envelope-From: brian.foster@maxim-ic.com
Received: from maxsvlex02.maxim-ic.internal (10.32.112.18) by
 maxdalex01.maxim-ic.internal (10.16.15.101) with Microsoft SMTP Server (TLS)
 id 8.3.192.1; Wed, 22 Aug 2012 07:10:15 -0500
Received: from laclwks004.localnet (10.201.0.45) by
 maxsvlex02.maxim-ic.internal (10.32.112.18) with Microsoft SMTP Server (TLS)
 id 8.3.192.1; Wed, 22 Aug 2012 05:10:14 -0700
X-ASG-Orig-Subj: [Q] Comparing differences introduced by two commits?
User-Agent: KMail/4.8.4 (Linux/3.2.0-29-generic; KDE/4.8.4; x86_64; ; )
X-Barracuda-Connect: maxdalex01.maxim-ic.internal[10.16.15.101]
X-Barracuda-Start-Time: 1345637417
X-Barracuda-URL: http://AntiSpam02.maxim-ic.com:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at maxim-ic.com
X-Barracuda-Spam-Score: 0.12
X-Barracuda-Spam-Status: No, SCORE=0.12 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=5.0 tests=CN_BODY_332
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.106384
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.12 CN_BODY_332            BODY: CN_BODY_332
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204013>


Hello,

 I have two commits A and B.  They are on separate branches.
 Commit A is a older version of B.  I want to see what, if
 any, differences there are between what commit A changes
 and what commit B changes.  (The relative positions of
 two commits may also differ in the two branches; that is, 
 there may have been some commit re-ordering.)

 Ideally, the contents of the commit-message are also taken
 into account (albeit things like the commit-Id, dates, and
 so on will differ and therefore should be ignored).

 I realize the history leading up to each commit can itself
 cause what the commits change to differ, even if the "net
 result" of the two commits is the same.  For my purposes,
 this is a noise issue, and I'm happy to consider A and B 
 as not causing the same changes (i.e., as being different),
 albeit if the only difference is the line numbers, then it
 would be nice to ignore that.

 In the past I've done:

    diff <(git show A) <(git show B)

 which produces rather messy output but is Ok when dealing
 with just one or two sets of A/B commits.  I now have a
 large-ist set of A/B commits, and the above is impractical.

 Some searching hasn't found any suggestions I'm too happy
 with, albeit I've very possibly overlooked something.

 Any suggestions?
cheers!
	-blf-

-- 
Brian Foster
Principal MTS, Software        |  La Ciotat, France
Maxim Integrated Products      |  Web:  http://www.maxim-ic.com/
