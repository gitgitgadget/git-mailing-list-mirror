From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 00/28] Teach guilt import-commit how create legal patch
 names, and more
Date: Fri, 21 Mar 2014 16:39:17 -0400
Message-ID: <20140321203917.GP1852@meili.valhalla.31bits.net>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 21:47:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR6Li-00008D-Is
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 21:47:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbaCUUqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 16:46:54 -0400
Received: from josefsipek.net ([64.9.206.49]:1660 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbaCUUqx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 16:46:53 -0400
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Mar 2014 16:46:53 EDT
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 4DA6D554D8;
	Fri, 21 Mar 2014 16:39:03 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1395387126-13681-1-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244735>

On Fri, Mar 21, 2014 at 08:31:38AM +0100, Per Cederqvist wrote:
> I recently found myself sitting on a train with a computer in front of
> me.  I tried to use "guilt import-commit", which seemed to work, but
> when I tried to "guilt push" the commits I had just imported I got
> some errors.  It turned out that "guilt import-commit" had generated
> invalid patch names.
> 
> I decided to fix the issue, and write a test case that demonstrated
> the problem.
> 
> One thing led to another, and here I am, a few late nights at a hotel
> and a return trip on the train later, submitting a patch series in 28
> parts.  Sorry about the number of patches, but this is what happens
> when you uncover a bug while writing a test case for the bug you
> uncovered while writing a test case for your original problem.

No problem.  I prefer large number of patches instead of a big wad that's
much harder to follow.

> The patch series consists of:
...
>  - Changed behavior: "guilt push" when there is nothing more to push
>    now uses exit status 1.  This makes it possible to write shell
>    loops such as "while guilt push; do make test||break; done".  Also,
>    "guilt pop" when no patches are applied also uses exit status 1.
>    (This aligns "guilt push" and "guilt pop" with how "hg qpush" and
>    "hg qpop" has worked for several years.)

Sounds fine.

>  - Changed behavior: by default, guilt no longer changes branch when
>    you push a patch.  You need to do "git config guilt.reusebranch
>    false" to re-enable that.  This patch sets the default value of
>    guilt.reusebranch to true; it should in my opinion change to false
>    a year or two after the next release.

Probably a fair thing to do.  I should really make a release soon :/

I'm sending this off before I go through all the patches so you know that
I've seen this and plan to comment/pull.  It'll probably take a bit to go
through all 28 :)

Thanks,

Jeff.

-- 
Ready; T=0.01/0.01 08:47:23
