From: Robert Shearman <rob@codeweavers.com>
Subject: Regression: git-commit no longer works from within subdirectories
Date: Thu, 03 Aug 2006 19:06:20 +0100
Organization: CodeWeavers
Message-ID: <44D23B1C.80704@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 03 20:07:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8haz-00070j-6p
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 20:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWHCSGy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 14:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWHCSGx
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 14:06:53 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:39096 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751376AbWHCSGx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 14:06:53 -0400
Received: from host86-139-253-196.range86-139.btcentralplus.com ([86.139.253.196] helo=[172.16.0.10])
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1G8hau-0000KH-54
	for git@vger.kernel.org; Thu, 03 Aug 2006 13:06:52 -0500
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060725)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24740>

Hi,

In the latest master branch git-commit no longer works from within 
subdirectories. Instead, you have to go to the top-level directory of 
the git tree to do the commit.

It fails with a confusing message when you are in a subdirectory:
rob@saturn:~/wine-git/dlls/msi$ git commit action.c
usage: git-read-tree (<sha> | [[-m [--aggressive] | --reset | 
--prefix=<prefix>] [-u | -i]] <sha1> [<sha2> [<sha3>]])

I'm not sure whether the previous behaviour was intentional, but I got 
used to it. Either way, I don't think users upgrading from 1.4.1 would 
appreciate a user-facing change like this in a 0.0.1 incremental release.

Can this be changed back to the previous behaviour?

Thanks,

-- 
Rob Shearman
