From: Thomas Spura <tomspur@fedoraproject.org>
Subject: wrong expectation from "git log -p"
Date: Tue, 2 Jun 2009 00:34:53 +0000 (UTC)
Message-ID: <pan.2009.06.02.00.34.36@fedoraproject.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 02:36:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBHzu-0008El-AY
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 02:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757843AbZFBAfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 20:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757533AbZFBAfI
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 20:35:08 -0400
Received: from main.gmane.org ([80.91.229.2]:53764 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757798AbZFBAfG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 20:35:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MBHy4-00076u-Fb
	for git@vger.kernel.org; Tue, 02 Jun 2009 00:35:04 +0000
Received: from p5b20f074.dip.t-dialin.net ([91.32.240.116])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Jun 2009 00:35:04 +0000
Received: from tomspur by p5b20f074.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Jun 2009 00:35:04 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p5b20f074.dip.t-dialin.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120491>

If running "git log -p parse-options.*", the last commit is 
df217ed6430efe444a09fffdafd39720ae3f9864
There are the changes this commit makes towards parse-options.*.

I was expecting to see the full commit with all changes and not only 
towards the 2 files - only including the two files.

Is my expactation wrong or is this a bug?

	Thomas
