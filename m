From: SungHyun Nam <goweol@gmail.com>
Subject: 'git add' regression in git-1.7?
Date: Fri, 19 Feb 2010 13:30:54 +0900
Message-ID: <hll45t$50o$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 05:31:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiKWS-0005PJ-5p
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 05:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520Ab0BSEbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 23:31:19 -0500
Received: from lo.gmane.org ([80.91.229.12]:54324 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088Ab0BSEbS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 23:31:18 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NiKWJ-0005Mp-La
	for git@vger.kernel.org; Fri, 19 Feb 2010 05:31:15 +0100
Received: from 210.181.13.12 ([210.181.13.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 05:31:15 +0100
Received: from goweol by 210.181.13.12 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 05:31:15 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 210.181.13.12
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ko; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
X-Stationery: 0.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140405>

Hello,

'git add' does NOT add files in ignored path.

When the .gitignore file contains:
     tmp/
If I do:
     git add tmp/test.txt
Nothing happens.

If I removed 'tmp/' from the .gitignore, git add works
fine.

Because I have backup copies of GIT, I tested serveral versions.
The version below works as expected.
     git version 1.6.6.243.gff6d2

And below does NOT work.
     git version 1.7.0.rc1.7.gc0da5
     git version 1.7.0.31.g1df487

Thanks,
namsh
