From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Is 'merge' in your path?
Date: Wed, 29 Mar 2006 11:01:03 +0100
Message-ID: <tnxmzf9sh7k.fsf@arm.com>
References: <CFF307C98FEABE47A452B27C06B85BB6046AA9@hdsmsx411.amr.corp.intel.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Andreas Ericsson" <ae@op5.se>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 29 12:01:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOXUX-0001Rg-Do
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 12:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWC2KB1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 05:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWC2KB1
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 05:01:27 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:8845 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1751107AbWC2KB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Mar 2006 05:01:26 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.255.63])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id k2TA15uc016500;
	Wed, 29 Mar 2006 11:01:05 +0100 (BST)
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Wed, 29 Mar 2006 11:01:04 +0100
To: "Brown, Len" <len.brown@intel.com>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6046AA9@hdsmsx411.amr.corp.intel.com> (Len
 Brown's message of "Wed, 29 Mar 2006 04:06:40 -0500")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 29 Mar 2006 10:01:05.0040 (UTC) FILETIME=[B149E100:01C65317]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18164>

"Brown, Len" <len.brown@intel.com> wrote:
>>What does "which merge" tell you? If it turns up blank, you know the 
>>problem. The merge program is usually found in the rcs package.
>
> blank indeed.  I guess I don't have rcs on this laptop.

Actually, I think git could use diff3 directly and not rely on "merge"
from rcs which seems to be equivalent to "diff3 -m -E" (it might even
call diff3, I'm not sure).

Are there any features in "merge" and not available in "diff3"?

-- 
Catalin
