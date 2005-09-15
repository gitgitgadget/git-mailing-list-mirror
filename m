From: "H. Peter Anvin" <hpa@zytor.com>
Subject: git-daemon --inetd
Date: Wed, 14 Sep 2005 23:04:47 -0700
Message-ID: <43290EFF.3070604@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 15 08:05:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFmrm-0008OR-Or
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 08:05:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbVIOGEu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 02:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVIOGEu
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 02:04:50 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:37605 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S932527AbVIOGEt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 02:04:49 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j8F64lJv024644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 Sep 2005 23:04:48 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8589>

Some people have asked why we haven't enabled git-daemon on kernel.org. 
  The reason is that git-daemon --inetd is broken; there is a patch in 
the current repository which claims to fix it, but there isn't a release 
version yet.

On that note, though, it would be very nice if there was a way to run 
git-daemon in a chroot, or otherwise restrict it to a specific 
subhierarchy of the filesystem.

	-hpa
