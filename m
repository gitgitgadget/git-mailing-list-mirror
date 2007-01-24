From: Pazu <pazu@pazu.com.br>
Subject: git-rm'ing all dead files
Date: Wed, 24 Jan 2007 16:17:07 +0000 (UTC)
Message-ID: <loom.20070124T171435-429@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 24 17:17:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9koa-0007nT-2Q
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 17:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbXAXQRc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 11:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbXAXQRc
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 11:17:32 -0500
Received: from main.gmane.org ([80.91.229.2]:34365 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975AbXAXQRb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 11:17:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H9koG-0000cL-P7
	for git@vger.kernel.org; Wed, 24 Jan 2007 17:17:17 +0100
Received: from C925635D.poa.virtua.com.br ([C925635D.poa.virtua.com.br])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 17:17:16 +0100
Received: from pazu by C925635D.poa.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 17:17:16 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 201.37.99.93 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-US; rv:1.8.1.1) Gecko/20061204 Firefox/2.0.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37648>

I couldn't find an easy way to remove all "dead" files from the index, i.e.,
call git-rm on all files that are missing from the working copy.

Here's the scenario: I moved/added/removed a lot of files using a GUI tool; now
I need to reflect those changes in git. Using git-commit -a isn't the best
choice because there are local modifications I don't want to commit. I can use
"git add ." to automatically stage all new files, but how to the same for
removed files?

-- Pazu
