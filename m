From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: A shortcoming of the git repo format
Date: Wed, 27 Apr 2005 18:56:59 -0700
Message-ID: <427042EB.8030501@zytor.com>
References: <Pine.LNX.4.21.0504272143260.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 03:52:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQyCV-0006nl-EG
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 03:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVD1B5Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 21:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbVD1B5Z
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 21:57:25 -0400
Received: from terminus.zytor.com ([209.128.68.124]:32643 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261694AbVD1B5W
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 21:57:22 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3S1v544006116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Apr 2005 18:57:05 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504272143260.30848-100000@iabervon.org>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow wrote:
> On Wed, 27 Apr 2005, H. Peter Anvin wrote:
>  
>>There are a fair number of tools one may want that deal with reachability.
>  
> Do you agree that installing a new libgit.so when you want to apply such a
> tool to a new tag is sufficient? If the library is shared, and everything
> for parsing the objects (to the point of getting struct object filled
> out) is in the library, and you want to have some tool able to validate or
> use any new tag that you want reachability-only tools to process, not
> having a standard header proto-format for future tags isn't a problem,
> since you'll get upgrades to the parser portion of all of your tools
> together.
> 

Only if language bindings are created for this library.

	-hpa
