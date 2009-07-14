From: Yakup Akbay <yakbay@ubicom.com>
Subject: Weird behavior of git rev-parse
Date: Tue, 14 Jul 2009 10:20:47 +0300
Message-ID: <4A5C31CF.2090204@ubicom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 14 10:29:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQdOW-00017Q-QL
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 10:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbZGNI32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 04:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbZGNI32
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 04:29:28 -0400
Received: from server70b.appriver.com ([74.205.4.150]:2299 "EHLO
	server70.appriver.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751490AbZGNI31 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 04:29:27 -0400
Received: by server70.appriver.com (CommuniGate Pro PIPE 5.2.14)
  with PIPE id 98416608; Tue, 14 Jul 2009 03:28:58 -0400
Received: from [216.112.109.98] (HELO stork.scenix.com)
  by server70.appriver.com (CommuniGate Pro SMTP 5.2.14)
  with ESMTP id 98416606 for git@vger.kernel.org; Tue, 14 Jul 2009 03:28:56 -0400
Received: from [172.18.200.186] ([172.18.200.186]) by stork.scenix.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 14 Jul 2009 00:18:42 -0700
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
X-OriginalArrivalTime: 14 Jul 2009 07:18:42.0828 (UTC) FILETIME=[516B8CC0:01CA0453]
X-Policy: GLOBAL - ubicom.com
X-Primary: yakbay@ubicom.com
X-Note: This Email was scanned by AppRiver SecureTide
X-Virus-Scan: V-
X-Note: TCH-CT/SI:0-40/SG:2 7/14/2009 3:28:33 AM
X-GBUdb-Analysis: 0, 216.112.109.98, Ugly c=0.616646 p=-0.874055 Source Normal
X-Signature-Violations: 0-0-0-1907-c
X-Note: Spam Tests Failed: 
X-Country-Path: PRIVATE->UNITED STATES->UNITED STATES
X-Note-Sending-IP: 216.112.109.98
X-Note-Reverse-DNS: 216.112.109.98.ptr.us.xo.net
X-Note-WHTLIST: yakbay@ubicom.com
X-Note: User Rule Hits: 
X-Note: Global Rule Hits: 114 115 116 117 121 122 214 
X-Note: Mail Class: VALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123228>

Hi,

instead of `git rev-list -2 HEAD` I've tried `git rev-parse -2 HEAD` 
just to see the effect of -N in rev-parse, but I've got this output:

    -2
    0294cdd1e2c5535f5b87eff4a1aff3390e03af39

Then I've tried

    $ git rev-parse -'hi, this is a test!'

the output is:

    -hi, this is a test!

Is this an expected behavior?


Another questions is, usage is printed if you omit the commit id in git 
rev-list (E.g. `git rev-list -2`). Is there a reason why HEAD is not 
taken as the default?

Regards,
Yakup
