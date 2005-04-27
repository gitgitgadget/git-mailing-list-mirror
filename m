From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: A shortcoming of the git repo format
Date: Wed, 27 Apr 2005 13:40:36 -0700
Message-ID: <426FF8C4.8080809@zytor.com>
References: <426F2671.1080105@zytor.com> <Pine.LNX.4.58.0504270820370.18901@ppc970.osdl.org> <426FD3EE.5000404@zytor.com> <Pine.LNX.4.58.0504271154470.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 22:36:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQtGE-0006L7-IA
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 22:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVD0UlI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 16:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbVD0UlI
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 16:41:08 -0400
Received: from terminus.zytor.com ([209.128.68.124]:19133 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262003AbVD0Ukx
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 16:40:53 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3RKeg7d011697
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Apr 2005 13:40:42 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504271154470.18901@ppc970.osdl.org>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> No, that's definitely _not_ the point.
> 
> I repeat: git does not do any free-form parsin AT ALL. The links are in 
> well-defined places, and you do not ever search for them. And that's 
> really very very important.
> 

I know that.  However, is that going to be true for all versions of the 
repository format over all time?  If so, the repository format is brittle.

 > > Currently there is no  such delimiter for that.
 >
 > There absolutely is.
 >
 > For a "commit", the format is...

My point was that with a syntactic delimiter, one can write a tool that 
doesn't necessarily know everything about every tag, including future 
tags which may not have been invented when the tool was written.

One can simply say "we don't do that"; finding an unknown tag is always 
a fatal error.  That means the format is more brittle, but brittle does 
mean it breaks as opposed to getting deformed in some, potentially 
undesirable way.

	-hpa
