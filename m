From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: [PATCH v2 0/6] Extensions of core.ignorecase=true support
Date: Wed, 06 Oct 2010 16:46:50 -0600
Message-ID: <4CACFC5A.5050706@workspacewhiz.com>
References: <20101003043221.1960.73178.stgit@SlamDunk>	<AANLkTinZzM=HeT_J-tF5F9DBdvts3i+nboPkPy-uc8V5@mail.gmail.com>	<201010032012.01678.j6t@kdbg.org> <AANLkTi=tHaCki5yWQW_iQ21Y8ee5G2rNBzX8Pf-nZYAp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 00:46:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3clE-0006tx-HV
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759994Ab0JFWqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 18:46:53 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:51940 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759433Ab0JFWqx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 18:46:53 -0400
Received: (qmail 1522 invoked by uid 399); 6 Oct 2010 16:46:51 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@69.98.152.38)
  by hsmail.qwknetllc.com with ESMTPAM; 6 Oct 2010 16:46:51 -0600
X-Originating-IP: 69.98.152.38
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.9) Gecko/20100915 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <AANLkTi=tHaCki5yWQW_iQ21Y8ee5G2rNBzX8Pf-nZYAp@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158337>

  ----- Original Message -----
From: Robert Buck
Date: 10/6/2010 4:04 PM
> Let's say I want to have .gitignore be case insensitive with respect
> to matches so I can simplify the file by not having [D][d]ebug sorts
> of messes. But let's say I also want to support files whose names only
> differ by case (just like Unix supports). Can your current patch
> series support this? Does the current patch series break this?
>
> Could you share how this would or would not work, and if not, how you
> might accomplish this?
With this patch series, you are either on a case sensitive file system 
(core.ignorecase = false) or a case insensitive file system 
(core.ignorecase = true).

There is no specific configuration for .gitignore case insensitivity.  
It only pays attention to core.ignorecase.

This is something that could be added, but I don't fully understand the 
need.  On case sensitive file systems, the case of the resultant 
filename is guaranteed.  If you have both a Debug/ and debug/ directory, 
I would expect two entries in the .gitignore.

?

Josh
