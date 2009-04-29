From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git svn errors out with git-cat-file "usage" message
Date: Wed, 29 Apr 2009 22:25:53 +0200
Message-ID: <49F8B7D1.2090903@drmicha.warpmail.net>
References: <46a038f90904290811p33332bd5h1d397734907ba9c2@mail.gmail.com> <32541b130904291150k75a0433fnb29ea59f654a17f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mihai Sucan <mihai.sucan@gmail.com>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 22:26:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzGM2-0001iq-Mz
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 22:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759936AbZD2U0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 16:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756958AbZD2U0A
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 16:26:00 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42866 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754055AbZD2UZ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 16:25:59 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 3F67A336735;
	Wed, 29 Apr 2009 16:25:59 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 29 Apr 2009 16:25:59 -0400
X-Sasl-enc: Xc6Ye0vpYGkflossz4xp0DxUNqQMR+Ct8R4++/1/mCfA 1241036758
Received: from localhost.localdomain (p5DCC1814.dip0.t-ipconnect.de [93.204.24.20])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2DB2F2D15B;
	Wed, 29 Apr 2009 16:25:58 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090427 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <32541b130904291150k75a0433fnb29ea59f654a17f7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117941>

Avery Pennarun venit, vidit, dixit 29.04.2009 20:50:
> On Wed, Apr 29, 2009 at 11:11 AM, Martin Langhoff
> <martin.langhoff@gmail.com> wrote:
>> Steps to repro, and error message:
>>
>> $  git svn clone -T trunk --ignore-paths releases
>> http://paintweb.googlecode.com/svn paintweb.git
>> r3 = 30548c9192aefcde23337f70542ab59e193a1b9e (trunk)
>> usage: git-cat-file [-t|-s|-e|-p|<type>] <sha1>
>> fatal: unable to run 'git-svn'
>> $ git version
>> git version 1.6.2.4.10.g2254d <== this is maint as of right now
>>
>> The same problem exists with master as of right now (v1.6.3-rc3-12-gb79376c)
> 
> I just tried this (commit 2254d) and was unable to reproduce; it
> worked fine for me (Debian etch).
> 
>   git svn clone -T trunk --ignore-paths releases
> http://paintweb.googlecode.com/svn paintweb.git
>   ...
>   r6 = 8561205fe08e0bcefb592710f4e34db91f3099df (trunk)
>   Checked out HEAD:
>     http://paintweb.googlecode.com/svn/trunk r6
> 
> Maybe you can try 'git bisect' to narrow it down.

Works here as well, with git version 1.6.3.rc3 and svn, Version 1.5.4
(r33841) on Fedora 10.

Given the versions that fail for Martin and work for Avery and me I
would think it's not a git issue but rather a matter of the svn version
resp. the svn perl bindingds.

Michael
