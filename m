From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add -k kill keyword expansion option to git-cvsimport
Date: Mon, 15 Aug 2005 01:18:23 -0700
Message-ID: <7vacjj3968.fsf@assigned-by-dhcp.cox.net>
References: <46a038f9050814235140877be7@mail.gmail.com>
	<7vk6in65dp.fsf@assigned-by-dhcp.cox.net>
	<46a038f90508150037f128d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 10:19:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4aAu-0008AM-BS
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 10:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbVHOISZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 04:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbVHOISZ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 04:18:25 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:45458 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932096AbVHOISZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 04:18:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050815081824.XZFF17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 Aug 2005 04:18:24 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Martin Langhoff <martin.langhoff@gmail.com> writes:

>> ..., in which case instead of a -k option that does not allow
>> anything but -ko, making it take an optional single letter
>> o/k/b/v might might more sense.  A single -k defaulting to -ko
>> is fine by me if you did so, because I think that is the most
>> useful and usual mode of operation while converting to GIT
>> repository.

> Anyway, this script has so far followed cvs's own default... which is
> -kv, and I am generally unwilling to break backwards compatibility.

I realize what I wrote was prone to be misunderstood.  What I
meant about "single -k defaulting to -ko" was this:

    cvsimport without -k<any> => cvs default
    cvsimport -k == cvsimport -ko => use cvs -ko
    cvsimoprt -kv => use cvs -kv
