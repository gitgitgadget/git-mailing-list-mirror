From: barkalow@iabervon.org
Subject: [PATCH 0/2] Support pack files in http-pull
Date: Sun, 31 Jul 2005 16:09:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0507311600040.23721@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 31 22:09:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzK87-0000IA-2q
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 22:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVGaUJ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 16:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVGaUJS
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 16:09:18 -0400
Received: from iabervon.org ([66.92.72.58]:30216 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261974AbVGaUGm (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2005 16:06:42 -0400
Received: (qmail 24055 invoked by uid 1000); 31 Jul 2005 16:09:36 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Jul 2005 16:09:36 -0400
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This series adds support for downloading pack files when appropriate in 
http-pull. When it finds that a needed object is not available, it 
downloads info/packs (into memory), identifies any pack files it doesn't 
have from there, downloads indices of any of these that it doesn't have, 
and downloads the pack containing the object. If other packs are also 
needed, it downloads them when it reaches them.

 	-Daniel
*This .sig left intentionally blank*
