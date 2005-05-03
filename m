From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Careful object writing..
Date: Tue, 03 May 2005 15:40:25 -0700
Message-ID: <4277FDD9.6030502@zytor.com>
References: <Pine.LNX.4.58.0505031204030.26698@ppc970.osdl.org> <20050503200034.GA16104@delft.aura.cs.cmu.edu> <Pine.LNX.4.58.0505031531270.26698@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jan Harkes <jaharkes@cs.cmu.edu>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 00:37:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT60O-0004F6-Bt
	for gcvg-git@gmane.org; Wed, 04 May 2005 00:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVECWmJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 18:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVECWlf
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 18:41:35 -0400
Received: from terminus.zytor.com ([209.128.68.124]:56294 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261865AbVECWkt
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 May 2005 18:40:49 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j43MeV7M008645
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 May 2005 15:40:32 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505031531270.26698@ppc970.osdl.org>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-3.4 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 3 May 2005, Jan Harkes wrote:
> 
>>I tried to pull in the latest version of your tree, but it doesn't look
>>like this commit has propagated to rsync.kernel.org yet.
> 
> 
> Hmm.. It's still not there a few hours later. I wonder what the mirroring
> rules are. Or maybe mirroring is just broken right now. Peter?
> 
> One change introduced by me is that the new objects changed from 0664
> (-rw-rw-r--) to (0444) -r--r--r-- due to the object writing rules. Maybe
> the mirroring decides that such objects shouldn't be mirrored, since they
> are "private"?
> 
> Or maybe it's just that Peter has shut down mirroring in preparation for 
> the imminent memory upgrade on master.kernel.org. 
> 

No, I had stopped the cron job to fix a script bug and forgot to turn it 
back on.  It's pushing now.

	-hpa

