From: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
Subject: git-new-workdir for filesystems without links (e.g. FAT32)?
Date: Sun, 6 Feb 2011 14:20:34 +0000 (UTC)
Message-ID: <loom.20110206T151206-851@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 15:25:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm5YH-0001Nc-4g
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 15:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724Ab1BFOZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 09:25:13 -0500
Received: from lo.gmane.org ([80.91.229.12]:46332 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752704Ab1BFOZM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 09:25:12 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Pm5Y6-0001JB-NS
	for git@vger.kernel.org; Sun, 06 Feb 2011 15:25:10 +0100
Received: from avt242.neoplus.adsl.tpnet.pl ([83.27.53.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 15:25:10 +0100
Received: from piotr.krukowiecki.news by avt242.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 15:25:10 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.27.53.242 (Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/534.13 (KHTML, like Gecko) Chrome/9.0.597.84 Safari/534.13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166147>

Hi, 

git-new-workdir requires soft links to work, so obviously it will fail if file 
system does not support them. Is there any other way for having multiple working 
dirs with one repository?

Since git-new-workdir just uses soft links it should be possible to implement it 
natively in git. Maybe there some patches for this?

I need it because I'm using FAT32 on my dual-boot computer to share data between 
windows and linux. 


Thanks,

-- 
Piotr Krukowiecki
