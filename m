From: Enchanter <ensoul.magazine@gmail.com>
Subject: packfile is unavailable/cannot be accessed
Date: Wed, 6 Apr 2011 00:09:59 +0000 (UTC)
Message-ID: <loom.20110406T020617-993@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 06 02:15:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7GOv-0007Fn-Nk
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 02:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804Ab1DFAPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 20:15:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:34953 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752518Ab1DFAPH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 20:15:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Q7GOm-0007Ai-6q
	for git@vger.kernel.org; Wed, 06 Apr 2011 02:15:04 +0200
Received: from 210.215.158.240 ([210.215.158.240])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 02:15:04 +0200
Received: from ensoul.magazine by 210.215.158.240 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 02:15:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 210.215.158.240 (Mozilla/5.0 (Windows NT 5.1; rv:2.0) Gecko/20100101 Firefox/4.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170944>

Today I found these errors when I try to pull from remote:

$ git fetch origin
error: end of packfile
./objects/pack/pack-0bb4b0fb14801efb46a7cb9aab64add08620c0b1.pack
 is unavailable error: packfile
./objects/pack/pack-0bb4b0fb14801efb46a7cb9aab64add08620c0b1.pack
 cannot be accessed 
error: refs/heads/newGPMC does not point to a valid object!
error: end of packfile
./objects/pack/pack-bbb57cb715f61347809673448e9ab12084277090.pack
 is unavailable
error: packfile
./objects/pack/pack-bbb57cb715f61347809673448e9ab12084277090.pack
 cannot be accessed
error: end of packfile
./objects/pack/pack-bbb57cb715f61347809673448e9ab12084277090.pack
 is unavailable
error: packfile
./objects/pack/pack-bbb57cb715f61347809673448e9ab12084277090.pack
 cannot be accessed
fatal: failed to read object 8682d5d2ce5bbab82c9020a986d473aa2a97feb8:
 Illegal seek
fatal: The remote end hung up unexpectedly

Can anyone give me a hit on how to solve this problem? 

Thanks
