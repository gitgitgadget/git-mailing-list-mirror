From: Ryan Anderson <ryan@michonline.com>
Subject: Re: git-send-mail in sh
Date: Fri, 25 Nov 2005 11:33:58 -0500
Message-ID: <20051125163358.GF16995@mythryan2.michonline.com>
References: <4386DD45.6030308@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 25 17:36:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfgXQ-0003DF-El
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 17:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161124AbVKYQeD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 11:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161126AbVKYQeD
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 11:34:03 -0500
Received: from mail.autoweb.net ([198.172.237.26]:4054 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1161124AbVKYQeB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2005 11:34:01 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1EfgWM-0008KH-QL; Fri, 25 Nov 2005 11:34:00 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1EfgWM-0005qL-00; Fri, 25 Nov 2005 11:33:58 -0500
Received: from ryan by mythical with local (Exim 4.54)
	id 1EfgWM-0006Yq-BP; Fri, 25 Nov 2005 11:33:58 -0500
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <4386DD45.6030308@op5.se>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12741>

On Fri, Nov 25, 2005 at 10:45:41AM +0100, Andreas Ericsson wrote:
> Finally giving up on git-send-email (I won't install the 6 perl-modules 
> it requires and I don't know perl enough to remove the need for them), I 
> hacked up a replacement in sh. It's more aptly named as well. ;)

Scanning the list, 2 are related to option handling (one of which is
builtin), one isn't used (Data::Dumper), and two are related to sending
valid emails. The email address verification is ridiculously hard to get
correct, so using pre-written code for that seemed justified.

> It's worse than the perl version because;
> 1. It doesn't thread the patch-series (which I personally prefer anyway 
> since it's easier to follow a thread on a particular patch that way).

You can use --no-chain-reply-to in git-send-email.perl, and put a 0/N
message in, and all subsequent replies get attached to that instead of
in order, if you want.  This keeps everything in one thread, but all as
responses to the first email, so the people that want everything in one
thread can get that behavior.


-- 

Ryan Anderson
  sometimes Pug Majere
