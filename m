From: Quy Tonthat <qtonthat@gmail.com>
Subject: Re: [PATCH] git-remote exclude
Date: Thu, 18 Jan 2007 01:13:12 +1100
Message-ID: <45AE2EF8.50403@gmail.com>
References: <45AA44D6.6080605@gmail.com> <Pine.LNX.4.63.0701151118400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 15:13:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7BXz-0004ji-Qf
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 15:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbXAQONt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 09:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbXAQONt
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 09:13:49 -0500
Received: from pecan-mail.exetel.com.au ([220.233.0.8]:40755 "EHLO
	pecan.exetel.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932293AbXAQONs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 09:13:48 -0500
Received: from [220.233.69.95] (helo=[192.168.64.35])
	by pecan.exetel.com.au with esmtp (Exim 4.63)
	(envelope-from <qtonthat@gmail.com>)
	id 1H7BXs-00030R-TE; Thu, 18 Jan 2007 01:13:45 +1100
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701151118400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37005>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 15 Jan 2007, Quy Tonthat wrote:
> 
>> "git-remote exclude" can be used to prevent one or more unwanted remote 
>> branches from being tracked. After, for example,
>>     $ git-remote origin exclude man html
>> "git-fetch origin" will no longer fetch origin/man and origin/html.
> 
> That is not what your patch does.
> 
> It rewrites the "remote.$name.fetch" entries so that those branches are 
> not _updated_, but they are _fetched_ nevertheless.

I meant to say "track", but somehow "fetch" got to my fingers. Old ages, perhaps.
You are right, "update" is _the_ word. Thanks.

> But then, I don't really see _why_ you would want such a solution.
> After all, you are more likely to be interested in _specific_ branches, rather 
> than all branches _except_ a few.

For different situations, there are different paths to choose to reach that
ultimate "After All" (Zen? NO!). I offered one (little) path and expect to see
more of bigger ones. That's the _why_ (and/or, the _why_ not).

Quy
