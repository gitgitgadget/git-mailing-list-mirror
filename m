From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Problem merging
Date: Sun, 27 Nov 2005 13:24:44 -0800
Message-ID: <438A241C.5010007@zytor.com>
References: <20051123025001.15527.qmail@web31812.mail.mud.yahoo.com> <7v4q6483ms.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0511231546330.8191@wbgn013.biozentrum.uni-wuerzburg.de> <D8B7EF65-9D0C-4706-B248-4B7C118C16BF@hawaga.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 27 22:25:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgU1E-0006Ou-F5
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 22:25:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVK0VZF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 16:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVK0VZE
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 16:25:04 -0500
Received: from terminus.zytor.com ([192.83.249.54]:14282 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751150AbVK0VZD
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2005 16:25:03 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jARLOiTi021133
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 27 Nov 2005 13:24:46 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Ben Clifford <benc@hawaga.org.uk>
In-Reply-To: <D8B7EF65-9D0C-4706-B248-4B7C118C16BF@hawaga.org.uk>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_DUL 
	autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12828>

Ben Clifford wrote:
> On 24 Nov 2005, at 00:49, Johannes Schindelin wrote:
> 
>>
>> I think nobody is. Since there are infinitely many files having the  same
>> SHA1 (pigeon-hole principle),
> 
> hmm... pigeon-hole principle is just that there exists two files that  
> have the same SHA-1 as each other... doesn't say anything about *all*  
> SHA-1s, though?
> 

There are an infinite number of possible files (specifically, 
aleph-null.)  There are a finite number of possible SHA-1's 
(specifically, 1461501637330902918203684832716283019655932542976.) 
Therefore the pidgeon-hole principle tells you there must be at least 
one SHA-1 value that hashes an infinite number of files (aleph-null, again.)

Given that SHA-1 is believed to be uniformly distributed, it's quite 
likely *ALL* SHA-1's hash an infinite number of files, but the 
pigeon-hole principle can't tell you that.

	-hpa
