From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCH] tests: make all test files executable
Date: Thu, 01 Oct 2009 21:59:20 -0400
Message-ID: <4AC55E78.7010109@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 04:03:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtXUL-0000EN-0w
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 04:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755014AbZJBB7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 21:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754997AbZJBB7d
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 21:59:33 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:34648 "EHLO
	mailchk-m03.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754931AbZJBB73 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Oct 2009 21:59:29 -0400
Received: from karakura.local (CPE000e0c6492b0-CM001692fb78dc.cpe.net.cable.rogers.com [99.236.79.58])
	(authenticated bits=0)
	by mailchk-m03.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n921xKJ7024443
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 1 Oct 2009 21:59:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.4pre) Gecko/20090915 Thunderbird/3.0b4
X-UUID: bee31b63-b658-41a3-a0b4-c688afd2d1e8
X-Miltered: at mailchk-m03 with ID 4AC55E79.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m03
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m03.uwaterloo.ca [129.97.128.141]); Thu, 01 Oct 2009 21:59:25 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129420>

For consistency with the rest of the test files.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---

On 2009-10-01, at 4:13 AM, Jakub Narebski wrote:
>> diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
>> index d0ff21d..0688a57 100644
>> --- a/t/t9501-gitweb-standalone-http-status.sh
>> +++ b/t/t9501-gitweb-standalone-http-status.sh
> 
> BTW. the rest of test scripts are executable, but not this one? Why?
> (But correcting this should be done, if needed, in separate commit).

I noticed one other test script that was not set to be executable.


 0 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 t/t5531-deep-submodule-push.sh
 mode change 100644 => 100755 t/t9501-gitweb-standalone-http-status.sh

diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
old mode 100644
new mode 100755
diff --git a/t/t9501-gitweb-standalone-http-status.sh
b/t/t9501-gitweb-standalone-http-status.sh
old mode 100644
new mode 100755
-- 
1.6.5.rc2
