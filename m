From: Thomas Matysik <thomas@matysik.co.nz>
Subject: Re: [PATCH 1/2] Add expat and expat-devel dependencies (for http-push)
 to RPM spec.
Date: Mon, 14 Nov 2005 13:29:17 +1300
Message-ID: <4377DA5D.9090002@matysik.co.nz>
References: <4376C797.3050600@matysik.co.nz> <Pine.LNX.4.64.0511130942490.3263@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 01:30:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbSEI-0000Hw-QY
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 01:29:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVKNA3b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 19:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbVKNA3b
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 19:29:31 -0500
Received: from [202.37.90.137] ([202.37.90.137]:59085 "EHLO xena.matysik.co.nz")
	by vger.kernel.org with ESMTP id S1750808AbVKNA3a (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2005 19:29:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by xena.matysik.co.nz (Postfix) with ESMTP id 19BDD189C69;
	Mon, 14 Nov 2005 13:29:16 +1300 (NZDT)
Received: from xena.matysik.co.nz ([127.0.0.1])
 by localhost (xena.matysik.co.nz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 06953-10; Mon, 14 Nov 2005 13:29:15 +1300 (NZDT)
Received: from [202.37.90.142] (joxer.matysik.co.nz [202.37.90.142])
	by xena.matysik.co.nz (Postfix) with ESMTP id 31759189C30;
	Mon, 14 Nov 2005 13:29:15 +1300 (NZDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511130942490.3263@g5.osdl.org>
X-Enigmail-Version: 0.92.0.0
X-Virus-Scanned: by amavisd-new at matysik.co.nz
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11757>

Linus Torvalds wrote:
> 
> Quite frankly, I'd really prefer to see the git-core-http as a separate 
> package.
> 
> I think it's ludicrous that people want to split out gitk (because it 
> wants tcl/tk), but that we then add all of these really obscure 
> dependencies for the http part. 

Well, splitting out http occurred to me, but personally I don't have a
problem with installing expat (I'd need it eventually anyway) and I
figured anyone who did have a problem would say something.  ;-)

The reason for this patch is that the RPM currently fails to build
without expat-dev.

The reason for wanting to split out gitk is that, for a machine where I
will never run gitk, I think the following dependency list is ludicrous:

 fontconfig
 freetype
 tcl
 tk
 xorg-x11-Mesa-libGL
 xorg-x11-libs
