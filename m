From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Errors cloning over http -- git-clone and cg-clone fail to fetch a reachable object...
Date: Mon, 7 Nov 2005 22:31:36 -0800
Message-ID: <20051108063136.GA3806@reactrix.com>
References: <46a038f90511061354k5378a92ckc427841f90ec8b4@mail.gmail.com> <46a038f90511061852h5cdf9539o34f69b4deb9f041a@mail.gmail.com> <20051107043737.GI3001@reactrix.com> <46a038f90511062050geee7e73qddcd52e3a2ec86df@mail.gmail.com> <20051107171446.GA4070@reactrix.com> <46a038f90511071837g474bdc44vf60dd0758511f24c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 08 07:33:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZN1u-00071z-7x
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 07:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965328AbVKHGbr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 01:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965315AbVKHGbr
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 01:31:47 -0500
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:61357 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S965261AbVKHGbm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 01:31:42 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jA86VanZ010081;
	Mon, 7 Nov 2005 22:31:36 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jA86VaOZ010079;
	Mon, 7 Nov 2005 22:31:36 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90511071837g474bdc44vf60dd0758511f24c@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11314>

On Tue, Nov 08, 2005 at 03:37:29PM +1300, Martin Langhoff wrote:

> It definitely looks like it's doing a few requests in parallel and
> getting them mixed up. BTW, this repo is public and sitting on a box
> that doubles up as kernel mirror -- feel free to hit it ;-)

Can you run git-http-fetch after the failure to attempt to pick up where
it left off?  It should fail right away, and hopefully contain less
confusing output from parallel requests.

Was there a request header for pack-9cbe...d3a5.pack earlier in the
output, and were there response headers for successful or failed
requests?

FWIW, I've tried cloning that repository a few times and haven't seen
the problem yet.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
