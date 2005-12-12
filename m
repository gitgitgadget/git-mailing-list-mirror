From: Don Zickus <dzickus@gmail.com>
Subject: branching and supporting a tagged kernel version
Date: Mon, 12 Dec 2005 16:31:08 -0500
Message-ID: <68948ca0512121331x13bfb691t62224d02ced04a27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Dec 12 22:34:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElvGR-0007GO-MU
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 22:31:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVLLVbM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 16:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbVLLVbM
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 16:31:12 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:6423 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932184AbVLLVbK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 16:31:10 -0500
Received: by wproxy.gmail.com with SMTP id i23so1625475wra
        for <git@vger.kernel.org>; Mon, 12 Dec 2005 13:31:09 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VjvCcqj+9KMyHtBbAt4BAe20ILKq8VKkWDhqrw8FJ2MIAyTHc+HHt02bXGOEQ5raF6Lbhe5ahiXp68FR/HeDd0HtkX02T70HyHomN1OAzgoEJn4pB2mXta9l/8i0zaExY1NZWlL+DrVr9hbdWed6ysDGJKLxs7WfZbIrHWtLjv0=
Received: by 10.65.135.6 with SMTP id m6mr84398qbn;
        Mon, 12 Dec 2005 13:31:08 -0800 (PST)
Received: by 10.65.240.20 with HTTP; Mon, 12 Dec 2005 13:31:08 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13543>

Hello,

I was trying to see if I can use git for a particular way of
supporting a kernel and was hoping for some feedback if this approach
would work.

Basically I wanted to branch off of 2.6.14 and support personal
patches.  However over time I would like to be able to merge in
hand-pick commits from upstream.

So my questions (for now) are:

1) what is the easiest way to branch off on a tagged version (in this
case 2.6.14)?  I didn't quite understand what <starting point>
referred to in the git-branch docs.

2) is there a way to get a list of commits from upstream that are not
in my branch and then selectively apply them?  Yes, I understand the
potential merge mess...

Thanks,
Don
