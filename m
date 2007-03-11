From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git-upload-pack: the timeout gets corrupted?!
Date: Sun, 11 Mar 2007 10:18:33 -0700
Message-ID: <45F439E9.1080204@zytor.com>
References: <45F35F38.1080206@zytor.com> <7vy7m4wcfb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 18:19:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQRhF-00080x-3i
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 18:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933854AbXCKRSp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 13:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933856AbXCKRSp
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 13:18:45 -0400
Received: from terminus.zytor.com ([192.83.249.54]:57030 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933854AbXCKRSo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 13:18:44 -0400
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l2BHIX1l026168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 11 Mar 2007 10:18:35 -0700
User-Agent: Thunderbird 1.5.0.9 (X11/20070212)
In-Reply-To: <7vy7m4wcfb.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV 0.88.7/2807/Sun Mar 11 01:57:00 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=2.3 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_96_XX,PLING_QUERY,RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL
	autolearn=no version=3.1.8
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.1.8 (2007-02-13) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41944>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>> ...  Going in with gdb, it appears the "timeout"
>> variable gets overwritten:
>>
>> (gdb) p timeout
>> $1 = 608471321
>>
>> ... which should have been 600.
> 
> I do not see offhand what can cause this.  The only new code
> since 1.4.4 series is "shallow clone" stuff,...

Well, we changed servers from an x86-64 box to an i386 box, so we're 
definitely running different binaries.

	-hpa
