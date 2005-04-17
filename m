From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: Parseable commit header
Date: Sun, 17 Apr 2005 12:49:24 -0400
Message-ID: <42629394.1090804@dwheeler.com>
References: <20050417062236.GA3261@scotty.home>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 18:44:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNCs2-0002jJ-6I
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 18:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVDQQrb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 12:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVDQQrb
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 12:47:31 -0400
Received: from cujo.runbox.com ([193.71.199.138]:17822 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261356AbVDQQr3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 12:47:29 -0400
Received: from [10.9.9.16] (helo=lassie.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DNCvh-0002il-5p; Sun, 17 Apr 2005 18:47:29 +0200
Received: from [70.17.101.238] (helo=[192.168.2.73])
	by lassie.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DNCvg-0005Vs-4W; Sun, 17 Apr 2005 18:47:29 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
In-Reply-To: <20050417062236.GA3261@scotty.home>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Stefan-W. Hahn wrote:
> Hi,
> 
> after playing a while with git-pasky it is a crap to interpret the date of
> commit logs. Though it was a good idea to put the date in a parseable format
> (seconds since), but the format of the commit itself is not good parseable.

> Should be:
...
> Committer-Dater: 1113684324 +0200

I'm probably coming in late to the game, but exactly
why is seconds-since-epoch format used instead of a format
more easily understood by humans?  Yes, I know tools
can easily convert that, but you're already using an ASCII format;
why not just record it in a format that's easily eyeballed like ISO's
yyyymmddThhmmss [timezone]? E.G.:
  20050417T171520 +0200
or some such?  I'm SURE that people will mention things
like "the patch I posted on April 17, 2005", and having the
patch format record times that way, directly, would be convenient
to the poor slobs^H^H^H^H^H developers who come later.
Yes, a tool can handle the conversion, but choosing formats
so a tool is unneeded for simple stuff is often better....!

--- David A. Wheeler
