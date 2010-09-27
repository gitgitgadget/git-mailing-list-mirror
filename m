From: Stephen Bash <bash@genarts.com>
Subject: Re: git push on tracking branches
Date: Mon, 27 Sep 2010 12:14:01 -0400 (EDT)
Message-ID: <29138507.371458.1285604041100.JavaMail.root@mail.hq.genarts.com>
References: <20100927160548.GA10256@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 27 18:14:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0GLI-0007wB-6q
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 18:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759714Ab0I0QOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 12:14:09 -0400
Received: from hq.genarts.com ([173.9.65.1]:22926 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756905Ab0I0QOI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 12:14:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 4802F1E26BCB;
	Mon, 27 Sep 2010 12:14:07 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TwrvStcOG-62; Mon, 27 Sep 2010 12:14:01 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 2F2911E26BCA;
	Mon, 27 Sep 2010 12:14:01 -0400 (EDT)
In-Reply-To: <20100927160548.GA10256@sigill.intra.peff.net>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157347>

----- Original Message -----
> From: "Jeff King" <peff@peff.net>
> To: "Stephen Bash" <bash@genarts.com>
> Cc: "Git Mailing List" <git@vger.kernel.org>
> Sent: Monday, September 27, 2010 12:05:48 PM
> Subject: Re: git push on tracking branches
> On Mon, Sep 27, 2010 at 12:00:41PM -0400, Stephen Bash wrote:
>
> > Now, your local branch sf will automatically push to and pull from
> > origin/serverfix."
> 
> That has never been the case by default. Push has always defaulted to
> pushing all matching branches (so of course if you use the same name,
> it
> will end up pushing to the tracking branch). However, you can do:
> 
> git config --global push.default tracking
> 
> to explicitly change the default to push the current branch to its
> upstream. See the entry for "push.default" in "git help config".

Thanks for the clarification!

Stephen
