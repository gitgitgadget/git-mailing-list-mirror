From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Subject: git 1.2.4 and linux-2.6 tree problem
Date: Fri, 14 Jul 2006 16:20:05 +0200
Organization: tuxland
Message-ID: <200607141620.05350.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jul 14 16:20:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1OWZ-0007Ve-Ss
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 16:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161108AbWGNOUI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 10:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbWGNOUH
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 10:20:07 -0400
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:17168 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1161108AbWGNOUG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 10:20:06 -0400
Received: from [192.168.1.3] (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by tuxland.pl (Postfix) with ESMTP id 078666EF7A
	for <git@vger.kernel.org>; Fri, 14 Jul 2006 16:20:04 +0200 (CEST)
Received: from [192.168.1.3] ([192.168.1.3])
	by tuxland.pl (AISK)
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
Content-Disposition: inline
X-Virus-Scanned: AISK at tuxland.pl
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23889>

Hello,

	I get repeatable errors when I follow steps from "Kernel Hackers' Guide to 
git" (http://linux.yyz.us/git-howto.html). The thing is when I try to pull 
Linus tree with:

git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git  
linux-2.6

After downloading approx. 60MB I get these errors:

fatal: packfile '/home/me/linux/linux-2.6/.git/objects/pack/tmp-lfnDg8' SHA1 
mismatch
error: git-clone-pack: unable to read from git-index-pack
error: git-index-pack died with error code 128
clone-pack from 
'git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git' 
failed.

The git version is 1.2.4 (marked as stable in gentoo). Any ideas?

Regards,

	Mariusz
