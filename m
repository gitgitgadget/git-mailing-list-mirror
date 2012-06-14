From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: How do I specify a revision for "git blame" by date?
Date: Thu, 14 Jun 2012 12:19:08 +0200
Message-ID: <m2sjdynqlf.fsf@igel.home>
References: <4fda029d.g99uVull9jgguc/Y%perryh@pluto.rain.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: perryh@pluto.rain.com
X-From: git-owner@vger.kernel.org Thu Jun 14 12:19:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf793-0000FD-VF
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 12:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413Ab2FNKTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 06:19:14 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:45285 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755177Ab2FNKTN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 06:19:13 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3WCgmj0Mw3z3hhbf;
	Thu, 14 Jun 2012 12:19:32 +0200 (CEST)
Received: from igel.home (ppp-88-217-114-244.dynamic.mnet-online.de [88.217.114.244])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3WCgmF1SPKz4KK6v;
	Thu, 14 Jun 2012 12:19:09 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id AC5C9CA2A5; Thu, 14 Jun 2012 12:19:08 +0200 (CEST)
X-Yow: Here I am in the POSTERIOR OLFACTORY LOBULE but I don't see CARL SAGAN
 anywhere!!
In-Reply-To: <4fda029d.g99uVull9jgguc/Y%perryh@pluto.rain.com>
	(perryh@pluto.rain.com's message of "Thu, 14 Jun 2012 08:26:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199997>

perryh@pluto.rain.com writes:

> How do I get "git blame" to operate "as of" a particular date in
> the past, without having to manually look up the corresponding
> SHA1 using "git rev-list"?  For example, I can get a report as of
> 2011-12-29 by doing something like:
>
>   $ git rev-list --all --date-order --format="%h %ai" .
>   ...
>   7c69106 2012-01-03 ...
>   b4227af 2011-12-27 ...
>   ...
>
>   $ git blame <file> b4227af

You can use any rev-list option, so --until=2011-12-27 should work.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
