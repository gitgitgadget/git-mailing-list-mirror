From: Ryan McCue <lists@rotorised.com>
Subject: ls-tree and wildcards
Date: Sun, 13 May 2012 01:07:41 +1000
Message-ID: <4FAE7CBD.3020605@rotorised.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 17:17:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STE4u-0005lB-T2
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 17:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755626Ab2ELPRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 May 2012 11:17:47 -0400
Received: from mta22-data1.ironport2.cbr1.mail-filtering.com.au ([117.55.227.22]:58219
	"EHLO mta22-data1.ironport2.cbr1.mail-filtering.com.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755214Ab2ELPRr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2012 11:17:47 -0400
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 May 2012 11:17:46 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhYLAMB7rk+va78LgWdsb2JhbABEgx6wdAEBFiYnBAMBgkxAPRYYAwIBAgFYCAEBiAmZZKBvjXyDJgSXDoRRE41G
X-IronPort-AV: E=Sophos;i="4.75,575,1330866000"; 
   d="scan'208";a="13564191"
Received: from ju001lcs02.dfw.the-server.net.au (HELO ju001lcs02.dfw.the-server.com.au) ([175.107.191.11])
  by smtp-data2.ironport2.cbr1.mail-filtering.com.au with ESMTP; 13 May 2012 01:07:44 +1000
Received: from [124.191.162.147] (port=46615 helo=[192.168.0.2])
	by ju001lcs02.dfw.the-server.com.au with esmtpa (Exim 4.77)
	(envelope-from <lists@rotorised.com>)
	id 1STDv5-003iLk-A6
	for git@vger.kernel.org; Sun, 13 May 2012 01:07:43 +1000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197735>

Good evening folks,

I'm attempting to grab relevant information for files in a tree matching 
a given pattern with wildcards. The help for ls-tree indicates that it 
can accept a pattern of files to match, however I'm not able to see that.

$ git ls-tree origin/master
...
100644 blob 8c391e8fb44a38e1389a710ebf8af79612e592a6    screenshot-1.png
100644 blob ecb7159c1c02567e9cd5da83c254c538d331f733    screenshot-2.png
100644 blob f58eea7e27f98c01038262b823aa73ccd64cb01e    screenshot-3.png
100644 blob 07e64def408145660cee657a46947077374762cc    screenshot-4.png
$ git ls-tree origin/master screenshot*
$

(I've also tried quoting to ensure it's not bash playing up)

Is there some issue with the command I'm issuing? The documentation 
seems to indicate that I should be getting back the files which match 
the pattern.

Thanks,

-- 
Ryan McCue
<http://ryanmccue.info/>
