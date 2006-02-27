From: "Nicolas Vilz 'niv'" <niv@iaglans.de>
Subject: git-svn and huge data and modifying the git-svn-HEAD branch 
     directly
Date: Mon, 27 Feb 2006 18:59:50 +0100 (CET)
Message-ID: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Feb 27 19:00:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDmfX-0004Ix-5I
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 19:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbWB0SAT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 13:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbWB0SAS
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 13:00:18 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:26375 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S1751519AbWB0SAR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 13:00:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 6AFD93FA9
	for <git@vger.kernel.org>; Mon, 27 Feb 2006 18:59:59 +0100 (CET)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 21479-10 for <git@vger.kernel.org>;
	Mon, 27 Feb 2006 18:59:54 +0100 (CET)
Received: from mail.geht-ab-wie-schnitzel.de (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 3A6463F7F
	for <git@vger.kernel.org>; Mon, 27 Feb 2006 18:59:49 +0100 (CET)
Received: from 84.163.87.135
        (SquirrelMail authenticated user niv@geht-ab-wie-schnitzel.de)
        by mail.geht-ab-wie-schnitzel.de with HTTP;
        Mon, 27 Feb 2006 18:59:50 +0100 (CET)
To: git@vger.kernel.org
User-Agent: SquirrelMail/1.4.5
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16869>

hi everyone,

as i mentioned, i do experimental work with git and svn... and i
experienced some problems with git when pulling much data from svn.

Actually that happens after i commit a revision with many and big files.
After that i cannot do a git-svn fetch anymore because git-svn
complains...

fatal: Ref refs/heads/svn-git-HEAD is at
504721bf4b2702d3e56cef69950f42a43568e846 but expected
504721bf4b2702d3e56cef69950f42a43568e846

now i am a little confused about that... oh, i actually modified the
svn-git directly instead of a private working branch... perhaps that was
not intended.

now i am still on rev 2 on this branch but i updated it to rev 5 on the
svn-side...

any hints?

Sincerly
Nicolas
