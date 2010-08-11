From: "Neal Kreitzinger" <neal@rsss.com>
Subject: repo permissions repair: restore --shared=group permissions
Date: Wed, 11 Aug 2010 18:24:18 -0500
Message-ID: <i3vbho$f5j$5@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 12 01:26:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjKgM-0007ya-Km
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 01:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756891Ab0HKXZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 19:25:57 -0400
Received: from lo.gmane.org ([80.91.229.12]:37611 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363Ab0HKXZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 19:25:57 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OjKgF-0007xQ-3Q
	for git@vger.kernel.org; Thu, 12 Aug 2010 01:25:55 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 01:25:55 +0200
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 01:25:55 +0200
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153312>

Hi,

chmod -R 755 was inadvertantly run on all of our git repos (bare and 
non-bare).  These repos were originally created as --shared=group.  When I 
run git init --shared=group it does not complain, but it also does not 
correct the permissions.  Please advise on the best way restore the 
permissions to --shared=group.  Thanks!

v/r,
Neal 
