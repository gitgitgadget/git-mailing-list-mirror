From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] git-cvsimport-script: handling of tags
Date: Tue, 06 Sep 2005 16:19:32 -0700
Message-ID: <431E2404.6060804@zytor.com>
References: <431DD381.4050709@zytor.com> <431DE640.8050901@zytor.com>	 <431DFB04.5020701@zytor.com>	 <46a038f905090614216eca87eb@mail.gmail.com>	 <431E0B25.5000104@zytor.com> <46a038f9050906155962d33869@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Sep 07 01:21:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECmjG-00015g-RC
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 01:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbVIFXTs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 19:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbVIFXTs
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 19:19:48 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:62881 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1751021AbVIFXTr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2005 19:19:47 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j86NJWJv013042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 6 Sep 2005 16:19:33 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: martin.langhoff@gmail.com
In-Reply-To: <46a038f9050906155962d33869@mail.gmail.com>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8156>

Martin Langhoff wrote:
> 
>>My style has always be to use tags for merges; tag the origin branch as
>>well as before and after on the receiving branch.
> 
> Do you move the tags with cvs tag -F? If that's the case, the data you
> need to merge is lost... otherwise, you could hack an alternative
> merge detection based on your tagnames.
> 

No, there are three tags:

             before-merge-foo
             |  after-merge-foo
             |  |
branch 1 ---*--*----
               /
              /
branch 2 ---*-------
             |
             merge-point-foo

That's why I was a bit confused.  I thought most people did something 
similar.

	-hpa
