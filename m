From: Jack Nagel <Jack.Nagel.1@ndsu.edu>
Subject: Re: Can't build git on Lion?
Date: Thu, 28 Jul 2011 12:19:01 +0000 (UTC)
Message-ID: <loom.20110728T141556-724@post.gmane.org>
References: <CAF5DW8+efO0jcynyhg3GCZc5JByHwQzudqtrJXF87YazYjF2mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 14:25:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmPeU-00019B-8q
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 14:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318Ab1G1MZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 08:25:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:36821 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754161Ab1G1MZG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 08:25:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QmPeC-00011U-Jb
	for git@vger.kernel.org; Thu, 28 Jul 2011 14:25:04 +0200
Received: from 12.52.103.158 ([12.52.103.158])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 14:25:04 +0200
Received: from Jack.Nagel.1 by 12.52.103.158 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 14:25:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 12.52.103.158 (Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178065>

> There's no /System/Library/Perl/5.10.0 directory, but there is a 5.10
> directory.  Symlinking that to 5.10.0 gives me :

I've seen this issue pop up serveral times in the last few days in various 
places; the solution is to install (or re-install) XCode as the installation 
does not persist correctly across upgrades. Versions prior to 4.1 are 
incompatible with Lion; also, after you download it from the App Store, make 
sure that you run the "XCode Installer" app that is placed in your 
Applications folder.
