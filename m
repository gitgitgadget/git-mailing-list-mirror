From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Removing command dispatcher (was Re: [ANNOUNCE] git-pasky-0.6.2 &&
 heads-up on upcoming changes)
Date: Thu, 21 Apr 2005 14:15:51 -0400
Message-ID: <4267EDD7.1070103@dwheeler.com>
References: <20050420205633.GC19112@pasky.ji.cz> <20050420211919.GA20129@kroah.com> <20050420215117.GJ19112@pasky.ji.cz> <Pine.LNX.4.58.0504201503050.6467@ppc970.osdl.org> <pan.2005.04.21.02.48.19.802122@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Apr 21 20:13:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOgA2-0004vW-J8
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 20:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVDUSQN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 14:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVDUSQN
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 14:16:13 -0400
Received: from cujo.runbox.com ([193.71.199.138]:8866 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261607AbVDUSPy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 14:15:54 -0400
Received: from [10.9.9.110] (helo=snoopy.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DOgDO-0006JV-3b
	for git@vger.kernel.org; Thu, 21 Apr 2005 20:15:50 +0200
Received: from [129.246.254.211] (helo=[129.246.80.140])
	by snoopy.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DOgDN-0001z8-R2
	for git@vger.kernel.org; Thu, 21 Apr 2005 20:15:50 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <pan.2005.04.21.02.48.19.802122@smurf.noris.de>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Matthias Urlichs wrote:

>Linus Torvalds wrote:
>
>  
>
>>I realize that there is probably a law that there has to be a space, but I 
>>actually personally use tab-completion all the time
>>    
>>
It's very unusual, but I can't think of any crisis it causes.

One minor annoyance: Windows doesn't support #! magic headers,
and a very few-and-probably-ignorable old Unix systems don't either.
There, commands written in an interpreter like perl, python, or shell can't
be kicked off just by a #! reference at the top (standard Windows' shell is
incompatible anyway, so it's just as well in the case of shell).

I don't see this as a roadblock, though.  On those systems, you could
create trivial stubs that just invoke the interpreter (e.g., perl) and the
real program. In the Windows case, you can use Windows' miserable
excuse for a command processor to do that very easily.
E.g., if "cg-update" is a Perl script, then you can create a file 
"cg-update.bat":
perl  \path\to\cg-update %*

(That requires Windows NT4 or better. MS-DOS didn't have %*, so you needed:
perl  \path\to\cg-update %1 %2 %3 %4 %5 %6 %7 %8 %9
It's hard to imagine an MS-DOS git user though.)

--- David A. Wheeler

