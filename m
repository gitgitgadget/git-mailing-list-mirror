From: Michael Gebetsroither <gebi@sbox.tugraz.at>
Subject: [BUG] git-gui loose object warning every hour
Date: Fri, 20 Jun 2008 02:21:53 +0200
Organization: www.grml.org
Message-ID: <g3et71$j8k$1@ger.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 02:23:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9UPH-00064X-NG
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 02:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923AbYFTAWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 20:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753221AbYFTAWK
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 20:22:10 -0400
Received: from main.gmane.org ([80.91.229.2]:50469 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351AbYFTAWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 20:22:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K9UOB-0001Rs-2o
	for git@vger.kernel.org; Fri, 20 Jun 2008 00:22:03 +0000
Received: from 84.119.25.105 ([84.119.25.105])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 00:22:03 +0000
Received: from gebi by 84.119.25.105 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 00:22:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 84.119.25.105
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85579>

hi,

New git-gui does not honor gc.auto=0 setting for his loose object
warning.

The loose object warning from git-gui poped up 3 times in the last 4
hours (i've gc'ed the repo every time).

I've already set gc.auto=0 so i do _NOT_ want git to do anything
automatically.

On every new git release there are new automatism that i've to disable.
Is there a way to just disable all this automatism in all git tools
globaly?

cu,
michael
-- 
It's already too late!
