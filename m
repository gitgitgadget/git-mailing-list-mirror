From: "Neal Kreitzinger" <neal@rsss.com>
Subject: concurrent pulls on the same non-bare repo master branch
Date: Wed, 5 Jan 2011 14:38:17 -0600
Message-ID: <ig2ksm$ghf$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 05 21:40:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Paa9V-00022Z-VF
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 21:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826Ab1AEUkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 15:40:06 -0500
Received: from lo.gmane.org ([80.91.229.12]:42144 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817Ab1AEUkE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 15:40:04 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Paa9M-0001tw-1C
	for git@vger.kernel.org; Wed, 05 Jan 2011 21:40:04 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 21:40:04 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 21:40:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164592>

If two or more users concurrently perform a git-pull of the master branch on 
the same non-bare repo can this cause corruption?  I'm not sure if git is 
serializing this or if it is possible for concurrent pulls to step on each 
other.

v/r,
Neal 
