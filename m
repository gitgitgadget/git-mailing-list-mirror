From: <oldb0t@ro.ru>
Subject: Re: Git stops forever while cloning remote repo
Date: Fri, 13 Apr 2012 22:35:52 +0400
Message-ID: <1050185255.1334342152.89018696.94536@mperl102.rambler.ru>
References: <805073108.1332078446.170729064.12423@mcgi-wr-20.rambler.ru> <20120404210707.GA5054@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>, <git@vger.kernel.org>,
	<oldb0t@ro.ru>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 13 20:36:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIlLl-0002fu-DD
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 20:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755931Ab2DMSf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 14:35:56 -0400
Received: from mx-out-wr-2.rambler.ru ([81.19.92.41]:37972 "EHLO
	mx-out-wr-2.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404Ab2DMSfz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 14:35:55 -0400
Received: from mperl102.rambler.ru (mperl102.rambler.ru [10.32.5.102])
	by mx-out-wr-2.rambler.ru (Postfix) with ESMTP id AFD5E7E2DD9;
	Fri, 13 Apr 2012 22:35:53 +0400 (MSK)
Received: from mperl102.rambler.ru (localhost [127.0.0.1])
	by mperl102.rambler.ru (Postfix) with ESMTP id 945CB4B33012;
	Fri, 13 Apr 2012 22:35:53 +0400 (MSK)
Received: from [93.74.202.53] by mperl102.rambler.ru with HTTP (mailimap); Fri, 13 Apr 2012 22:35:52 +0400
Content-Disposition: inline
X-Mailer: Ramail 3u, (chameleon), http://mail.rambler.ru
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195430>

* Jeff King <peff@peff.net> [Wed, 4 Apr 2012 17:07:07 -0400]:
> I tried to reproduce this here, but it works fine for me. Have you 
tried> cloning from git://github.com/angband/angband.git instead? If 
that works
> better, that would give us a data point about where the problem is.
I retried it a few days later, and all worked fine. Sorry for silence, 
just didn't have access to this mailbox at the moment.

> One solution is to create static "bundles" that are
> resumable, but not every service (nor most, really) does that[1].
> However, you can try Tomas's bundler service, which will generate a
> resumable bundle for you:
>   https://bundler.caurea.org/
Thanks a lot. Should be a good workaround for this kind of problem. I'll 
try it next time on similar occassion.
