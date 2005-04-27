From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: A shortcoming of the git repo format
Date: Wed, 27 Apr 2005 16:56:27 -0700
Message-ID: <427026AB.4070809@zytor.com>
References: <Pine.LNX.4.21.0504271939100.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 01:52:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQwJQ-00052l-Ek
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 01:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVD0X4u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 19:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVD0X4u
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 19:56:50 -0400
Received: from terminus.zytor.com ([209.128.68.124]:17793 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262107AbVD0X4s
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 19:56:48 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3RNuW6u004679
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Apr 2005 16:56:32 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504271939100.30848-100000@iabervon.org>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow wrote:
> 
> If you find an object with an unknown tag, you can't do much with it
> anyway, even if it has a format that matches generic rules. Sure, you
> could trace reachability through it, but that's only helpful for a couple
> of generic programs (fsck and pull), and those programs ought to
> additionally have some clue about what's going on if they're going to act
> appropriately.
> 
> On the other hand, it is probably true that programs should be able to
> deal abstractly with new tags if built with a libgit that supports them,
> but that's something that we can arrange a bit later.
> 
> 	-Daniel

There are a fair number of tools one may want that deal with reachability.

	-hpa

