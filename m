From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re:
Date: Wed, 01 Feb 2006 20:18:50 -0800
Message-ID: <43E1882A.307@zytor.com>
References: <24768.1138840762@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 05:19:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4VwW-00082d-5U
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 05:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161068AbWBBES4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 23:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161076AbWBBES4
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 23:18:56 -0500
Received: from terminus.zytor.com ([192.83.249.54]:36281 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161068AbWBBESz
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 23:18:55 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k124Iobd024110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 1 Feb 2006 20:18:52 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <24768.1138840762@lotus.CS.Berkeley.EDU>
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15481>

Jason Riedy wrote:
> I guess our home directories recently were changed from symlinks
> to autmounts.  Solaris 8's mkdir(2) returns ENOSYS when applied
> to these, breaking safe_create_leading_directories.  I don't
> know if ENOSYS is available everywhere, or if this odd behavior
> is appropriate everywhere.
> 
> This works for me, but should I wrap mkdir for bizarre behavior
> by adding a compat/gitmkdir.c?

Wow, Solaris really can be braindamaged sometimes...

	-hpa
