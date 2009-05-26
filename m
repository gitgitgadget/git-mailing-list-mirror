From: "Neal Kreitzinger" <neal@rsss.com>
Subject: git log missing last line of output
Date: Tue, 26 May 2009 17:57:07 -0500
Message-ID: <gvhrtf$vpr$1@ger.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 00:57:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M95Zy-0007Gz-Q4
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 00:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759042AbZEZWx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 18:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758913AbZEZWxy
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 18:53:54 -0400
Received: from main.gmane.org ([80.91.229.2]:53446 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758814AbZEZWxv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 18:53:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M95Wl-0005P4-Av
	for git@vger.kernel.org; Tue, 26 May 2009 22:53:47 +0000
Received: from 216-60-24-100.rsss.biz ([216.60.24.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 May 2009 22:53:47 +0000
Received: from neal by 216-60-24-100.rsss.biz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 May 2009 22:53:47 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 216-60-24-100.rsss.biz
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120015>

Git log is not displaying the last line of output (for a plain "$ git log" 
the last line of output should be the title line of the initial commit). 
(I'm using git 1.5.5.6 on rhel 5.3.)  This missing last line also occurs 
with "git log --since" in which the last line of output should be the title 
line of the first commit after the specified date, but it is missing in this 
scenario also.  I've searched the release notes for 1.5.6 thru 1.6.3.1 and 
did not find this mentioned.  Does this also happen in newer versions of git 
after 1.5.5.6?

v/r,
Neal 
