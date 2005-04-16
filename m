From: David Lang <david.lang@digitalinsight.com>
Subject: SHA1 hash safety
Date: Sat, 16 Apr 2005 05:24:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0504160519330.21837@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Sat Apr 16 14:21:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMmIL-0000I0-EB
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 14:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVDPMYo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 08:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVDPMYo
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 08:24:44 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:8441 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S261720AbVDPMYa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 08:24:30 -0400
Received: from sacims01.digitalinsight.com by warden3.diginsite.com
          via smtpd (for vger.kernel.org [12.107.209.244]) with SMTP; Sat, 16 Apr 2005 05:24:30 -0700
Received: by sacexc01.diginsite.com with Internet Mail Service (5.5.2657.72)
	id <24ZWYT88>; Sat, 16 Apr 2005 05:24:26 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id 29YX1LMY; Sat, 16 Apr 2005 05:24:23 -0700
To: git@vger.kernel.org
X-X-Sender: dlang@dlang.diginsite.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

this issue was raised a few days ago in the context of someone tampering 
with the files and it was decided that the extra checks were good enough 
to prevent this (at least for now), but what about accidental collisions?

if I am understanding things right the objects get saved in the filesystem 
in filenames that are the SHA1 hash. of two legitimate files have the same 
hash I  don't see any way for both of them to exist.

yes the risk of any two files having the same has is low, but in the 
earlier thread someone chimed in and said that they had two files on their 
system that had the same hash..

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
