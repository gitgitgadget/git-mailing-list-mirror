From: Levente Kovacs <leventelist@gmail.com>
Subject: gitolite description
Date: Wed, 24 Nov 2010 23:23:59 +0100
Organization: logonex.eu
Message-ID: <20101124232359.38034ff1@jive.levalinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 24 23:24:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLNlD-0004Ph-KC
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 23:24:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754828Ab0KXWYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 17:24:13 -0500
Received: from lo.gmane.org ([80.91.229.12]:59515 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752791Ab0KXWYM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 17:24:12 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PLNl4-0004LJ-Rc
	for git@vger.kernel.org; Wed, 24 Nov 2010 23:24:10 +0100
Received: from fxip-006cc.externet.hu ([92.52.216.204])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 23:24:10 +0100
Received: from leventelist by fxip-006cc.externet.hu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 23:24:10 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: fxip-006cc.externet.hu
X-Newsreader: Claws Mail 3.7.6 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162091>

Hi list,


I have a gitolite and gitweb environment. Each time I set up a repository, I
have to ssh to my server and edit the description of the newly created
repository.

Is there any way to remotely edit the description?

I tried to edit it locally, and then push it, but it didn't help.

I add my repository like this:

git remote add origin gitolite:new_repo.git
git push origin master:master

my gitweb interface is available here:

http://git.logonex.eu/

Note the "Unnamed repository; edit this..." strings.

Thanks,
Levente

-- 
Levente Kovacs
http://levente.logonex.eu
