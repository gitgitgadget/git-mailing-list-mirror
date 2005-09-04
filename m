From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Moved files and merges
Date: Sat, 03 Sep 2005 21:14:21 -0700
Message-ID: <431A749D.9090607@zytor.com>
References: <4318E754.9000703@zytor.com> <46a038f90509021720417a9b59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 04 06:18:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBlwD-00064c-12
	for gcvg-git@gmane.org; Sun, 04 Sep 2005 06:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbVIDEO3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Sep 2005 00:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbVIDEO3
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Sep 2005 00:14:29 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:60565 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1750926AbVIDEO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2005 00:14:29 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j844ELJv008155
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Sep 2005 21:14:22 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: martin.langhoff@gmail.com
In-Reply-To: <46a038f90509021720417a9b59@mail.gmail.com>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8049>

Martin Langhoff wrote:
> 
> Probably should be hacked into cg-merge. When the merge reports a file
> is missing, what happens? Does it leave a .rej file or anything?
> 

The error message is:

MERGE ERROR: nfsmount/mount.c: Not handling case 
3225ecdf8d172cda2a6ea5276af0d3edc566a0e7 ->  -> 
c02da9e576a525a2a49da930107ed3936a45b6e1
MERGE ERROR: nfsmount/sunrpc.c: Not handling case 
037e33e84ebcee4e097a009439c1bab7143ef92d ->  -> 
e2fe5f8b728b5235010ed317e759222179dcd45c

         Conflicts during merge. Do cg-commit after resolving them.

	-hpa
