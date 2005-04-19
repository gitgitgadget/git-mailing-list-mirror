From: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: "True" git merge in git-pasky
Date: Wed, 20 Apr 2005 01:40:57 +0200
Message-ID: <20050419234057.GA14807@electric-eye.fr.zoreil.com>
References: <20050419035107.GB5554@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 01:39:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO2Ic-0004pC-NW
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 01:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVDSXm1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 19:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVDSXm1
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 19:42:27 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:60382 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261170AbVDSXmN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 19:42:13 -0400
Received: from electric-eye.fr.zoreil.com (localhost.localdomain [127.0.0.1])
	by fr.zoreil.com (8.13.1/8.12.1) with ESMTP id j3JNf2x2018292;
	Wed, 20 Apr 2005 01:41:02 +0200
Received: (from romieu@localhost)
	by electric-eye.fr.zoreil.com (8.13.1/8.13.1/Submit) id j3JNevqp018291;
	Wed, 20 Apr 2005 01:40:57 +0200
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050419035107.GB5554@pasky.ji.cz>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@ucw.cz> :
[...]
> Now you decided to do a little bit of parallel development and stick
> your patches not ready for 2.6.12 to a separate tree. That's fine, do
> 
> 	git fork experimental ~/linux-2.6.experimental
> 
> and get some coffee. (It takes about 8 minutes here, but I think git
> isn't at fault - it is probably all spent in
> 
> 	read-tree $(tree-id)
> 	checkout-cache -a
> 	update-cache --refresh

Tip of the day: cat the whole tree to /dev/null before the fork

--
Ueimor
