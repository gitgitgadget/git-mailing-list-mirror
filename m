From: "Neal Kreitzinger" <neal@rsss.com>
Subject: concurrent fetches to update same mirror
Date: Wed, 5 Jan 2011 14:33:36 -0600
Message-ID: <ig2kjt$f2u$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 05 21:34:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Paa3u-0006mj-M0
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 21:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766Ab1AEUeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 15:34:24 -0500
Received: from lo.gmane.org ([80.91.229.12]:37883 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752762Ab1AEUeX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 15:34:23 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Paa3p-0006kW-W8
	for git@vger.kernel.org; Wed, 05 Jan 2011 21:34:22 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 21:34:21 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 21:34:21 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164590>

If two or more different users perform a git-fetch on the same mirror 
(--mirror) repo concurrently, could that cause corruption?  I tried a manual 
test using the git protocol over separate machines and they both thought 
they needed to do the full updates and they both appeared to work.  I'm not 
sure if git is serializing this, or if it is possible for concurrent fetches 
to step on each other.

v/r,
Neal 
