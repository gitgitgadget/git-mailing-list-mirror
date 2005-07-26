From: Jeff Garzik <jgarzik@pobox.com>
Subject: Why pack+unpack?
Date: Tue, 26 Jul 2005 00:39:45 -0400
Message-ID: <42E5BE91.2050901@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jul 26 06:41:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxHEQ-0003nu-Pr
	for gcvg-git@gmane.org; Tue, 26 Jul 2005 06:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVGZEjt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jul 2005 00:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVGZEjt
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jul 2005 00:39:49 -0400
Received: from mail.dvmed.net ([216.237.124.58]:61622 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261658AbVGZEjt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2005 00:39:49 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1DxHEJ-0002hu-Vs
	for git@vger.kernel.org; Tue, 26 Jul 2005 04:39:48 +0000
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Whenever I pull a local repository, such as

	cd /spare/repo/libata-dev
	git pull /spare/repo/linux-2.6/.git

git will pack, then unpack, the objects being pulled.  AFAICT this is 
just a complete waste of time.  Why does this occur?

Packing 1394 objects
Unpacking 1394 objects
  100% (1394/1394) done

It doesn't seem to make any sense to perform work, then immediately undo 
that work, just for a local pull.

	Jeff
