From: Brad King <brad.king@kitware.com>
Subject: Re: gitk: Turn short SHA1 names into links too
Date: Fri, 26 Sep 2008 08:15:58 -0400
Message-ID: <48DCD27E.6060704@kitware.com>
References: <alpine.LFD.1.10.0809251657080.3265@nehalem.linux-foundation.org>	 <alpine.LFD.1.10.0809251729440.3265@nehalem.linux-foundation.org>	 <BD7D0F18-32BD-4059-9190-A2C1B101B4C1@wincent.com> <237967ef0809260121w1c7cc516tceb3be2cbebb85bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 14:28:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjCQJ-0004gE-TZ
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 14:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbYIZM0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 08:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171AbYIZM0m
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 08:26:42 -0400
Received: from public.kitware.com ([66.194.253.19]:58457 "EHLO
	public.kitware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbYIZM0l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 08:26:41 -0400
X-Greylist: delayed 625 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Sep 2008 08:26:41 EDT
Received: from hythloth (hythloth.kitwarein.com [192.168.30.5])
	by public.kitware.com (Postfix) with ESMTP id 0C2AF202C;
	Fri, 26 Sep 2008 08:11:43 -0400 (EDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by hythloth (Postfix) with ESMTP id 234FB82F31;
	Fri, 26 Sep 2008 08:16:15 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
In-Reply-To: <237967ef0809260121w1c7cc516tceb3be2cbebb85bc@mail.gmail.com>
X-Enigmail-Version: 0.95.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96848>

Mikael Magnusson wrote:
> 2008/9/26 Wincent Colaiuta <win@wincent.com>:
>> It's a shame that tcl/tk regular expressions don't appear to support
>> anchoring matches against word boundaries (ie. "\b").
> 
> \y appears to achieve this;
> 
> % regexp {abc\y} 'abc'
> 1
> % regexp {abc\y} 'abcd'
> 0
> % regexp {\yabc\y} 'uabc,d'
> 0
> % regexp {\yabc\y} 'u+abc,d'
> 1
> 
> I have tcl/tk 8.5 so I cannot promise that isn't a new addition, I didn't
> look it up anywhere, but it's \y in some other implementations too, so I
> tried it.

It goes back at least as far as tcl/tk 8.2:

http://www.tcl.tk/man/tcl8.2.3/TclCmd/re_syntax.htm#M54

-Brad
