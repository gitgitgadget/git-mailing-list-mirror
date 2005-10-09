From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Seeing various mode changes on cygwin
Date: Sat, 08 Oct 2005 20:43:22 -0700
Message-ID: <434891DA.7070905@zytor.com>
References: <20051008180023.GC28875@diku.dk>	<7vfyrbrgdw.fsf@assigned-by-dhcp.cox.net>	<20051008213612.GA5794@steel.home> <7vzmpjoa32.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 09 05:44:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOS6Q-0006Hb-Hk
	for gcvg-git@gmane.org; Sun, 09 Oct 2005 05:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVJIDne (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Oct 2005 23:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVJIDne
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Oct 2005 23:43:34 -0400
Received: from terminus.zytor.com ([192.83.249.54]:37357 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932210AbVJIDnd
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 8 Oct 2005 23:43:33 -0400
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j993hLLC024907
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 8 Oct 2005 20:43:22 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmpjoa32.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_DUL 
	autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9859>

Junio C Hamano wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
>>These are not real attributes, cygwin emulates them from the names,
>>like .exe will always be 0755, for example.
> 
> Ouch.  Is this true in general, or only on FAT-derived
> filesystems?
> 
> We may need to worry about this on the core side after all.
> Some people need to mount FAT even on Linux systems, 
> 

At least on Cygwin/NTFS, you can do chmod just fine.

	-hpa
