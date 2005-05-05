From: David Lang <david.lang@digitalinsight.com>
Subject: read-only git repositories
Date: Thu, 5 May 2005 02:51:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0505050231300.15451@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.21.0505041854040.30848-100000@iabervon.org>
 <200505050709.43307.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Thu May 05 11:46:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTcvg-0004H2-6W
	for gcvg-git@gmane.org; Thu, 05 May 2005 11:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVEEJwS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 05:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVEEJwS
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 05:52:18 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:5259 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S262003AbVEEJwP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2005 05:52:15 -0400
Received: from atlims01.diginsite.com by warden2.diginsite.com
          via smtpd (for vger.kernel.org [12.107.209.244]) with SMTP; Thu, 5 May 2005 02:47:08 -0700
Received: by atlexc02.diginsite.com with Internet Mail Service (5.5.2653.19)
	id <KC1C0L8C>; Thu, 5 May 2005 05:51:53 -0400
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id K18GZ5D5; Thu, 5 May 2005 02:51:50 -0700
To: git@vger.kernel.org
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <200505050709.43307.alan@chandlerfamily.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

given that git already treats everything in the object storage as being 
fixed it occured to me that there may be value in makeing it so that git 
can make use of more then one pool of storage.

possible uses of this would be to have a bunch of data on read-only media 
(say the 3G+ kernel history on a DVD), having a pruned local object store 
with automated fetching from elsewhere if the object isn't found locally, 
or marking the object store that you plan on sharing with the world as 
read-only (with your changed object going into a secondary store) so that 
you don't pollute it accidently (this could also cut down on the storage 
requirements)

there are probably other uses and it seems like a fairly small 
modification to add a hook to use if the object isn't found initially that 
I thought I'd mention it to the group.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
