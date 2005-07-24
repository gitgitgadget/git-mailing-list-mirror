From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Problems Importing a CVS tree into FAUmachine
Date: Sun, 24 Jul 2005 22:56:01 +0200
Message-ID: <20050724205601.GD2117@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jul 24 23:01:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwnaZ-00060M-El
	for gcvg-git@gmane.org; Sun, 24 Jul 2005 23:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVGXVAZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jul 2005 17:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVGXVAZ
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jul 2005 17:00:25 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:40602 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261265AbVGXVAX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2005 17:00:23 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.11/8.12.11) with ESMTP id j6OKu20g018297
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 24 Jul 2005 20:56:02 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.11/8.12.11) id j6OKu18S018295;
	Sun, 24 Jul 2005 22:56:01 +0200 (CEST)
To: Matthias Urlichs <smurf@smurf.noris.de>, GIT <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello Matthias,
I have problems importing the FAUmachine CVS tree into git. I tried the
following with git HEAD and cvsps 2.1:

	git-cvsimport-script -d /var/lib/cvsd/cvsroots -C /var/lib/cvsd/gitroots/FAUmachine FAUmachine
	<Output of rlog and 'treated as before'>
	Committing initial tree e30105bb454c40a143689b37c11340f1a8f084b4

	Unknown: error

If I symlink HEAD afterwards manual to .git/refs/heads/origin I can see that
every until April 28 is imported (which is a very big amount). If I try
the above statement for the mutt cvs repository, it works perfectly for
me.

Any help is highly appreciated.

To make it easy reproducable I put the tar.gz on my webpage. But beware
of the size (202 Mbyte)!

http://wwwcip.informatik.uni-erlangen.de/~sithglan/FAUmachine.tgz (202M)

Thanks,
	Thomas
