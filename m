From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 22:36:37 +0200
Organization: Dewire
Message-ID: <200609282236.37513.robin.rosenberg.lists@dewire.com>
References: <20060928165509.77413.qmail@web51001.mail.yahoo.com> <Pine.LNX.4.64.0609281003070.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Matthew L Foster <mfoster167@yahoo.com>,
	Rogan Dawes <discard@dawes.za.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 22:36:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT2cN-0003uH-TS
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 22:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWI1UgY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 16:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWI1UgY
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 16:36:24 -0400
Received: from [83.140.172.130] ([83.140.172.130]:3167 "EHLO torino.dewire.com")
	by vger.kernel.org with ESMTP id S1750739AbWI1UgX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 16:36:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id 15BF5802895;
	Thu, 28 Sep 2006 22:33:34 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27889-10; Thu, 28 Sep 2006 22:33:33 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by torino.dewire.com (Postfix) with ESMTP id B7A46802676;
	Thu, 28 Sep 2006 22:33:31 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.9.4
In-Reply-To: <Pine.LNX.4.64.0609281003070.3952@g5.osdl.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28047>

torsdag 28 september 2006 19:11 skrev Linus Torvalds:
> The time that git records is purely a random number. It's a random number
> that _humans_ can choose to care about or not, and it's a random number
> that git itself uses only in the sense of "ok, I've got two equal choices,
> let's toss a coin to select which one I'll look at next", BUT IT IS A
> RANDOM NUMBER.

I'd think of it as comment, about as (un)reliable as the author field or the 
descriptive free-form comment people enter when they commit. It's not even 
necessarily the local system time if GIT_AUTHOR_DATE has been set.

-- robin
