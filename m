From: Duncan Mac Leod <duncan@excelsior-online.org>
Subject: git repack throws -> error: unrecognized: ??
Date: Sat, 24 Dec 2005 03:11:21 +0100
Organization: EXCELSIOR developers Team
Message-ID: <43ACAE49.4000902@excelsior-online.org>
Reply-To: duncan@excelsior-online.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Dec 24 03:14:55 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Epyvn-0000HP-Dg
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 03:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbVLXCO3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Dec 2005 21:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030603AbVLXCO3
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Dec 2005 21:14:29 -0500
Received: from rocksdale.excelsior-online.org ([213.202.239.5]:37893 "EHLO
	rocksdale.excelsior-online.org") by vger.kernel.org with ESMTP
	id S1030228AbVLXCO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2005 21:14:28 -0500
Received: from [192.168.2.2] (p549546CF.dip.t-dialin.net [84.149.70.207])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rocksdale.excelsior-online.org (Postfix) with ESMTP id A86BF28356
	for <git@vger.kernel.org>; Sat, 24 Dec 2005 03:37:04 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051205)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14004>

Hi!

I have done the following operations on my git repository...

duncan@firebird /var/git $ GIT_DIR=/var/git/myproject.git git fsck-objects
duncan@firebird /var/git $ GIT_DIR=/var/git/myproject.git git prune
duncan@firebird /var/git $ GIT_DIR=/var/git/myproject.git git count-objects
42 objects, 616 kilobytes
duncan@firebird /var/git $ GIT_DIR=/var/git/myproject.git git repack
Packing 42 objects
Pack pack-d715ebdf63391b054d9f058d59d3d3a4f6f2a12c created.
error: unrecognized:

The last one throws 'error: unrecognized:' - what does this mean?

Under which circumstances is this error message fired?

Did my git repository get corrupted?

...and 'HAPPY HOLIDAYS' to all of you!

Duncan
