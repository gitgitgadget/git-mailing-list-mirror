From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: What to expect after 0.99.8
Date: Tue, 04 Oct 2005 07:51:29 -0700
Message-ID: <434296F1.5030006@zytor.com>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0510031522590.23242@iabervon.org> <7vmzlqnwmw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0510031709360.23242@iabervon.org> <7v1x32l0gz.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0510031606550.31407@g5.osdl.org> <20051004071210.GA18716@localdomain> <Pine.LNX.4.63.0510040321170.23242@iabervon.org> <pan.2005.10.04.14.18.59.102722@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 04 16:53:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMo9Y-0003lg-3K
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 16:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbVJDOwV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 10:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbVJDOwV
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 10:52:21 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:16535 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S932509AbVJDOwU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2005 10:52:20 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j94EpWJv027194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Oct 2005 07:51:33 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.10.04.14.18.59.102722@smurf.noris.de>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9680>

Matthias Urlichs wrote:
> Hi, Daniel Barkalow wrote:
> 
>>I'd guess that UNIX sockets have a
>>similar capacity (although I'm not going to look it up tonight).
> 
> You can set TCP options to change the buffer sizes.
> 
> I would however assume that *nobody* sets both the send and receive
> buffers such that their cumulative size is <4k, so 99 object IDs
> at 41 bytes definitely should be OK.
> 

For TCP, I think we should simply get our own (or set) packet buffer 
size and conform to it.  Problem solved...

	-hpa
