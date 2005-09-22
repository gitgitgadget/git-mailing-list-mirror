From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: StGIT cannot import properly from stdin
Date: Thu, 22 Sep 2005 17:06:40 +0200
Message-ID: <4332C880.1060906@drzeus.cx>
References: <433107C7.60901@drzeus.cx>	<b0943d9e05092101033dd5d366@mail.gmail.com>	<433290A5.5070008@drzeus.cx> <tnxhdcd2tfn.fsf@arm.com>	<4332BA3E.2080607@drzeus.cx> <tnxr7bh188q.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 17:07:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EISep-0006hT-Mp
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 17:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbVIVPGl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 11:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbVIVPGl
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 11:06:41 -0400
Received: from [85.8.12.41] ([85.8.12.41]:11395 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1030390AbVIVPGk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 11:06:40 -0400
Received: from [192.168.128.82] (alcatraz.cendio.se [::ffff:193.12.253.67])
  (AUTH: PLAIN drzeus, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by smtp.drzeus.cx with esmtp; Thu, 22 Sep 2005 17:06:39 +0200
  id 00062717.4332C87F.00002B4B
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <tnxr7bh188q.fsf@arm.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9125>

Catalin Marinas wrote:

>It looks like a problem with Python since it re-opens sys.stdin once
>it receives EOF.
>
>  
>

Bummer. I checked with the local Python guru here and he suggested
changing the for loop to an infinite while and f.readline().

>I was referring to the 'cache the input to memory' variant, which is a
>bit more complicated. Caching to a file is simple but do you need to
>read patches from the terminal directly?
>
>  
>

I don't explicitly need it, but it keeps things simple for me. I can
copy and paste the patch from my mailer without having to bother with
saving it to a temporary file.
