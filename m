From: Tero Roponen <teanropo@jyu.fi>
Subject: git-clone tries to cd to a remote repository
Date: Mon, 14 May 2007 18:41:25 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0705141836350.26948@jalava.cc.jyu.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Mon May 14 20:31:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnfKc-0001x0-He
	for gcvg-git@gmane.org; Mon, 14 May 2007 20:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756183AbXENSbc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 14:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757294AbXENSbc
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 14:31:32 -0400
Received: from posti5.jyu.fi ([130.234.4.34]:55269 "EHLO posti5.jyu.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756183AbXENSbc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 14:31:32 -0400
X-Greylist: delayed 10202 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 May 2007 14:31:31 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by posti5.jyu.fi (8.13.6/8.13.6) with ESMTP id l4EFfQFZ013529;
	Mon, 14 May 2007 18:41:26 +0300
X-Virus-Scanned: amavisd-new at cc.jyu.fi
Received: from posti5.jyu.fi ([127.0.0.1])
	by localhost (posti5.jyu.fi [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cZHIl3SHLzYh; Mon, 14 May 2007 18:41:25 +0300 (EEST)
Received: from jalava.cc.jyu.fi (jalava.cc.jyu.fi [130.234.4.50])
	by posti5.jyu.fi (8.13.6/8.13.6) with ESMTP id l4EFfPrK013525;
	Mon, 14 May 2007 18:41:25 +0300
X-X-Sender: teanropo@jalava.cc.jyu.fi
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47283>

Hi,

the latest git seems to output a warning every time I
try to clone a repository that is not local:

$ git --version
git version 1.5.2.rc3.27.g43d151

$ git clone git://git.kernel.org/pub/scm/git/git.git
/usr/local/bin/git-clone: line 23: cd: git://git.kernel.org/pub/scm/git/git.git: No such file or directory
Initialized empty Git repository in /home/terrop/repositories/git/.git/
remote: Generating pack...
...

I think the output should be redirected to /dev/null,
but I'm not a shell/git guru...

-- 
Tero Roponen
