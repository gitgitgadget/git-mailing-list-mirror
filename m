From: Enchanter <ensoul.magazine@gmail.com>
Subject: Re: packfile is unavailable/cannot be accessed
Date: Thu, 7 Apr 2011 00:01:28 +0000 (UTC)
Message-ID: <loom.20110407T015644-337@post.gmane.org>
References: <loom.20110406T020617-993@post.gmane.org> <20110406154208.GC1864@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 02:01:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7cfa-0001lh-7i
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 02:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755258Ab1DGABr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 20:01:47 -0400
Received: from lo.gmane.org ([80.91.229.12]:45791 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012Ab1DGABq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 20:01:46 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Q7cfP-0001gl-BL
	for git@vger.kernel.org; Thu, 07 Apr 2011 02:01:44 +0200
Received: from 210.215.158.240 ([210.215.158.240])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Apr 2011 02:01:43 +0200
Received: from ensoul.magazine by 210.215.158.240 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Apr 2011 02:01:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 210.215.158.240 (Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Ubuntu/11.04 Chromium/10.0.648.204 Chrome/10.0.648.204 Safari/534.16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171027>

Jeff King <peff <at> peff.net> writes:

> 
> Looking through the source code, the only way this message can be
> generated is if lseek fails on the packfile. It looks like the messages
> are coming from the remote end. Where is your remote located? Which
> operating system is it running on? Is the repo on an exotic filesystem
> that might not support seeking?
> 
> -Peff
> 

Jeff, thanks for you reply. 

1. the bare repository is on the windows server
2. One developer use ubuntu with git 1.7.4.1 (Has the error message)
3. Another developer use windows XP with git 1.7.4.msysgit.0 (there's no errors)
