From: Joe Perches <joe@perches.com>
Subject: Odd git am behavior rewriting subject, adding "ASoC: " prefix
Date: Tue, 04 Nov 2014 17:12:01 -0800
Message-ID: <1415149921.6634.1.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 05 02:18:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlpFO-0002bY-Jb
	for gcvg-git-2@plane.gmane.org; Wed, 05 Nov 2014 02:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbaKEBSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2014 20:18:51 -0500
Received: from smtprelay0013.hostedemail.com ([216.40.44.13]:54885 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751303AbaKEBSu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Nov 2014 20:18:50 -0500
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Nov 2014 20:18:50 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
	by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 0B2B9211558
	for <git@vger.kernel.org>; Wed,  5 Nov 2014 01:12:05 +0000 (UTC)
Received: from filter.hostedemail.com (unknown [216.40.38.60])
	by smtprelay01.hostedemail.com (Postfix) with ESMTP id 460DF23413
	for <git@vger.kernel.org>; Wed,  5 Nov 2014 01:12:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:,RULES_HIT:41:69:355:379:541:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1373:1381:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3653:3865:3867:3868:3871:3872:3874:4250:5007:6261:7903:10004:10400:10848:11658:11914:12043:12296:12517:12519:12679:13019:13069:13095:13311:13357:21080,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0
X-HE-Tag: price97_8643a34cda762
X-Filterd-Recvd-Size: 1441
Received: from joe-X200MA.home (pool-71-103-235-196.lsanca.fios.verizon.net [71.103.235.196])
	(Authenticated sender: joe@perches.com)
	by omf03.hostedemail.com (Postfix) with ESMTPA
	for <git@vger.kernel.org>; Wed,  5 Nov 2014 01:12:02 +0000 (UTC)
X-Mailer: Evolution 3.12.7-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a patch file created by git format-patch.

Applying it via git am changes the subject prefix.
Anyone know why?

$ git --version
git version 2.1.2

$ git am -i 0002-staging-ft1000-Logging-message-neatening.patch
Commit Body is:
--------------------------
staging: ft1000: Logging message neatening

Use a more common logging style.

o Convert DEBUG macros to pr_debug
o Add pr_fmt
o Remove embedded function names from pr_debug
o Convert printks to pr_<level>
o Coalesce formats and align arguments
o Add missing terminating newlines

Signed-off-by: Joe Perches <joe@perches.com>
--------------------------
Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all 

choosing "Y" emits:

Applying: ASoC: staging: ft1000: Logging message neatening

ASoC:? where does that come from?
