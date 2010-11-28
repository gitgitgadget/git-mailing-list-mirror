From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: Inexplicably deteriorating performance of Git repositories on Windows
Date: Sun, 28 Nov 2010 23:18:05 +0100
Message-ID: <897B500F-7EDE-4A9D-9196-39075A8046B3@dewire.com>
References: <AANLkTimTh7ka21inpovM=qqdWs6j2OcPXVsFh_CMiZ7N@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 28 23:41:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMpw5-0005TV-VC
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 23:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680Ab0K1Wl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Nov 2010 17:41:28 -0500
Received: from mail.dewire.com ([83.140.172.130]:25920 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201Ab0K1Wl1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Nov 2010 17:41:27 -0500
X-Greylist: delayed 1399 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Nov 2010 17:41:27 EST
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id BD9688003BB;
	Sun, 28 Nov 2010 23:18:07 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0TrH8-yKj3ne; Sun, 28 Nov 2010 23:18:07 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 31CFA8003A7;
	Sun, 28 Nov 2010 23:18:07 +0100 (CET)
In-Reply-To: <AANLkTimTh7ka21inpovM=qqdWs6j2OcPXVsFh_CMiZ7N@mail.gmail.com>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162365>


23 nov 2010 kl. 20:08 skrev Dun Peal:

> Hey,
> 
> We have a bunch of Windows users, unfortunately, and they're using the
> latest msysGit release (Git-1.7.3.1-preview20101002).
> 
> An interesting issue we've noticed is that the Time To Complete of
> their common operations start deteriorating inexplicably, and
> severely, some time after the clone.
> 
> For instance, immediately after a clone, `git status` takes about
> 5-6s. Which is slow compared to Linux (consistent 1-2s), but still
> usable (it's a BIG repo).
> 
> However, after a reboot (of all things), `git status` latency
> skyrockets to 14-15s, making the repo unusable.
> 
> Any idea what's going on?  We just recently switched from SVN, and
> those users are getting really frustrated. BTW, the only real
> alternative I'm aware of, Cygwin's git, is even slower.
> 

Is the file system badly fragmented? The worst kind is when the MFT is fragmented,
which may give you very bad performance and the defrag that comes with Windows does
not fix MFT fragmentation.

Is NTFS compression enabled? I doubt its helpfulness with Git.

-- robin
