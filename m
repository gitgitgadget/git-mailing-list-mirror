From: Sam Vilain <sam@vilain.net>
Subject: [wishlist] git branch -d -r remotename
Date: Sun, 18 Mar 2007 21:36:04 +1200
Message-ID: <45FD0804.6010401@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 10:36:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSrop-0001Gk-Af
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 10:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211AbXCRJgg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 05:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753216AbXCRJgf
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 05:36:35 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:57969 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211AbXCRJgf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 05:36:35 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 102B813A384; Sun, 18 Mar 2007 21:36:32 +1200 (NZST)
Received: from [192.168.1.4] (203-110-28-85.nzwireless.co.nz [203.110.28.85])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 8E89913A342
	for <git@vger.kernel.org>; Sun, 18 Mar 2007 21:36:29 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42483>

I'm finding myself wanting to delete all local branch heads that are
already present on a remote.

You wouldn't want it to be too eager about it, and certainly you
wouldn't want to use it against any server that isn't considered
completely "upstream" of the repository you're doing it on, otherwise if
both ends run it and then "git remote prune" the refs will go away.

I think either "git remote prune" or "git branch -d" would be a good
place for that.

Thoughts?

Sam.
