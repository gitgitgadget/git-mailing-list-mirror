From: Jeff Garzik <jgarzik@pobox.com>
Subject: RFC: GIT networked storage
Date: Thu, 03 Nov 2005 23:42:11 -0500
Message-ID: <436AE6A3.4040103@pobox.com>
References: <7vwtjp2h59.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Fri Nov 04 05:43:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXtPF-0000hA-Dn
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 05:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbVKDEmU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 23:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161039AbVKDEmU
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 23:42:20 -0500
Received: from mail.dvmed.net ([216.237.124.58]:53685 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161021AbVKDEmT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2005 23:42:19 -0500
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1EXtP3-0001wS-Cg; Fri, 04 Nov 2005 04:42:17 +0000
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vwtjp2h59.fsf@assigned-by-dhcp.cox.net>
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11121>


Here's an experiment I've been dying to try.

The current "tracker-less" BitTorrent[1] employs a distributed hash 
table[2] called Kademlia, where the total content is spread across a 
bunch of computers on the network.  I kinda prefer TANGLE[3] to Kademlia.

Anyway, I was thinking that it would be a neat experiment to add simple 
TANGLE-like peer-to-peer code, to enable git to query "the git network 
hash table" for content.

Comments, or any pre-code-creation objections?
How easy is it to add a new storage backend to git?

To restrict unlimited uploading, I'm thinking that I'll want the system 
to fall back to {www,git,rsync}.kernel.org as the original source of 
content.  [though the code will obviously be generic, and not hardcode 
*.kernel.org policy]

Thanks,

	Jeff



[1] http://www.bittorrent.com/trackerless.html
[2] http://www.etse.urv.es/~cpairot/dhts.html
[3] http://www.nicemice.net/amc/research/tangle/
