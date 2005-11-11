From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Fri, 11 Nov 2005 09:46:59 -0800
Message-ID: <4374D913.503@zytor.com>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net> <43737EC7.6090109@zytor.com> <Pine.LNX.4.63.0511111516170.7575@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750947AbVKKRrQ@vger.kernel.org Fri Nov 11 18:49:26 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750947AbVKKRrQ@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eaczz-0006zD-Mi
	for glk-linux-kernel-3@gmane.org; Fri, 11 Nov 2005 18:47:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbVKKRrQ (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 11 Nov 2005 12:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbVKKRrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 12:47:16 -0500
Received: from terminus.zytor.com ([192.83.249.54]:53451 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750947AbVKKRrP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 12:47:15 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jABHl0KR002571
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Nov 2005 09:47:01 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511111516170.7575@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11622>

Johannes Schindelin wrote:
> 
> Two reasons against renaming:
> 
> - we call it fsck-objects for a reason. We are working on a file system, 
>   which just so happens to be implemented in user space, not kernel space.
>   If lost+found has to find a new name, so does fsck-objects.
> 

I'm sorry, but that is bull.  The problem here isn't the conventional 
naming, it's that you're implementing your filesystem on top of another 
filesystem, and you're running into a layering conflict.

> - lost+found has a special meaning, granted. So, a backup would not be 
>   made of it. So what? I *don't* want it backup'ed. I want to repair what
>   was wrong with it. When I repaired it, the result is stored somewhere
>   else. To backup lost+found would make as much sense as to backup /tmp.
> 

The default should ALWAYS be no data loss.

	-hpa
