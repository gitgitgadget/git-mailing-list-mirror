From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] git-cvsimport-script: handling of tags
Date: Tue, 06 Sep 2005 19:48:50 -0700
Message-ID: <431E5512.7090900@zytor.com>
References: <431DD381.4050709@zytor.com> <46a038f905090619444f94292e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Sep 07 04:49:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECpzy-0001yG-Ll
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 04:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbVIGCtN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 22:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVIGCtN
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 22:49:13 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:37539 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1750829AbVIGCtL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2005 22:49:11 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j872mvJv015243
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 6 Sep 2005 19:48:58 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: martin.langhoff@gmail.com
In-Reply-To: <46a038f905090619444f94292e@mail.gmail.com>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8163>

Martin Langhoff wrote:
> On 9/7/05, H. Peter Anvin <hpa@zytor.com> wrote:
> 
>>This patch changes git-cvsimport-script so that it creates tag objects
>>instead of refs to commits, and adds an option, -u, to convert
>>underscores in branch and tag names to dots (since CVS doesn't allow
>>dots in branches and tags.)
> 
> 
> looks good. Will it add proper tag objects for tags already imported
> and for tags added to the project post-initial-git-import?
> 

No and yes, respectively.

I incorrectly stated it renamed both branches and tags.  It currently 
only renames tags.  I'm trying to get branch renaming to work, but it 
seems to be a lot more work to get right.

	-hpa
