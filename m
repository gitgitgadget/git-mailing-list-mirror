From: =?utf-8?Q?Peter_M=C3=BCnster?= <pmlists@free.fr>
Subject: Re: feature request: git svn dommit --preserve-timestamps
Date: Sat, 11 Jun 2016 08:21:28 +0200
Message-ID: <878tycmejb.fsf@free.fr>
References: <87a8iy6s4e.fsf@free.fr> <20160607000902.GA4445@dcvr.yhbt.net>
	<87ziqx5z9h.fsf@free.fr> <20160611013948.GA5793@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Sat Jun 11 08:29:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBcPx-0005vi-2m
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jun 2016 08:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbcFKG3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jun 2016 02:29:04 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:16478 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbcFKG3D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2016 02:29:03 -0400
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Jun 2016 02:29:03 EDT
Received: from micropit.roche-blanche.homenet.org ([86.215.209.32])
	by mwinf5d23 with ME
	id 5JMU1t00Z0iVAr203JMUGf; Sat, 11 Jun 2016 08:21:29 +0200
X-ME-Helo: micropit.roche-blanche.homenet.org
X-ME-Auth: ZHJwbUB3YW5hZG9vLmZy
X-ME-Date: Sat, 11 Jun 2016 08:21:29 +0200
X-ME-IP: 86.215.209.32
Received: by micropit.roche-blanche.homenet.org (Postfix, from userid 1000)
	id 744A613554; Sat, 11 Jun 2016 08:21:28 +0200 (CEST)
In-Reply-To: <20160611013948.GA5793@dcvr.yhbt.net> (Eric Wong's message of
	"Sat, 11 Jun 2016 01:39:48 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297089>

On Sat, Jun 11 2016, Eric Wong wrote:

> The git log after dcommit is tied to the SVN log,
> so git-svn can only reflect changes which appear in SVN.

You mean, it's impossible, to keep the original timestamps??


> 	Sidenote: The convention is reply-to-all on lists like
> 	this one which do not require subscription to post.

Ok, thanks.


> Unfortunately, you would have to care about svn log as long as
> SVN exists in your workflow and you need to interact with SVN
> users.

In my case, all development happens on Git, SVN is only some sort of
copy. And when the original timestamps are lost, I've sometimes some
real problems in finding a specific commit that matches another event.


> git svn tries hard to work transparently and as close to the
> behavior of the upstream SVN repo as possible.

That's why I suggest an option, for use cases as mine. Those, who prefer
to keep the current behaviour just won't use it.

If someone could guide me through the code, I could modify it perhaps.

Thanks for your efforts,
-- 
           Peter
