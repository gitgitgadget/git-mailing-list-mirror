From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [BUG] bugs in clean, status, bisect, and send-email
Date: Thu, 25 Feb 2010 08:07:49 +0100
Message-ID: <201002250807.49470.chriscool@tuxfamily.org>
References: <ca433831002241928hef29dadu39f93bc1a8460331@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 08:08:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkXpV-0002qD-8A
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 08:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab0BYHH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 02:07:59 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:48576 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752640Ab0BYHH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 02:07:58 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C75D7818047;
	Thu, 25 Feb 2010 08:07:52 +0100 (CET)
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E07208180B0;
	Thu, 25 Feb 2010 08:07:49 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31-17-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <ca433831002241928hef29dadu39f93bc1a8460331@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141030>

On Thursday 25 February 2010 04:28:41 Mark Lodato wrote:
> I noticed the following four bugs but don't have time to investigate
> further, let alone make test cases or fix them.  If someone else wants
> to tackle these, great.  If not, I'll try to research them more when I
> get free time, which won't be for a while.

Thanks for the report!

> 4. git-bisect fails if a pathspec is given that matches no commits
> 
> It says there are -1 revisions left.  I have no idea what it does
> after that.  The following example uses git.git.
> 
> $ git bisect start v1.7.0 v1.6.6 -- 'foobar'
> Bisecting: -1 revisions left to test after this (roughly 0 steps)
> [f2a37151d4624906e34a9bcafb2ad79d0e8cb7ec] Fix memory leak in helper
> method for disconnect

I will have a look at this one, but I will be away until Monday, so don't 
expect anything from me before.

Thanks,
Christian.
