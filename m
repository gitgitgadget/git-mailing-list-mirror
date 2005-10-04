From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: First cut at git port to Cygwin
Date: Tue, 04 Oct 2005 08:03:55 -0700
Message-ID: <434299DB.7020805@zytor.com>
References: <433B3B10.5050407@zytor.com> <81b0412b0510040531m441ca759k6d1f3fbf0cd248ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 04 17:07:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMoLC-00083B-Ls
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 17:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbVJDPEK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 11:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbVJDPEJ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 11:04:09 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:20887 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S932524AbVJDPEI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2005 11:04:08 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j94F3xJv027309
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Oct 2005 08:04:00 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0510040531m441ca759k6d1f3fbf0cd248ce@mail.gmail.com>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9681>

Alex Riesen wrote:
> 
> I noticed that rename(2) in my copy of cygwin (1.5.18-1) does not remove the
> target and returns an error (probably EPERM, but I have reasons not to trust
> strerror on that thing).
> The repository was on FAT.
> Taking "rename(2)" from cygwin's libiberty solved this (they unlink if link(2)
> returns EEXIST).
> 
> PS: Does broken rename(2) qualify a system "not worthy to support"?

I just tried this with Cygwin 1.5.18-1 and didn't have any such 
problems.  I tried it on NTFS, FAT and Samba, using WinXP.

	-hpa
