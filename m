From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: Git svn rebase/dcommit break (index) if not run from directory
 containing ./.git
Date: Thu, 27 May 2010 10:13:36 +0200
Message-ID: <op.vdcugytd1e62zd@merlin.emma.line.org>
References: <4BCF2E27.1010906@gmx.de> <20100526185157.GB24211@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 8bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu May 27 10:13:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHYDs-0001cB-4p
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 10:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932787Ab0E0INn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 04:13:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:38776 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751978Ab0E0INl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 04:13:41 -0400
Received: (qmail invoked by alias); 27 May 2010 08:13:39 -0000
Received: from g230107007.adsl.alicedsl.de (EHLO mandree.no-ip.org) [92.230.107.7]
  by mail.gmx.net (mp058) with SMTP; 27 May 2010 10:13:39 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1++2OV1bhe+5DG2+gcvmRurh2OH1330tZtz6QWVGF
	9ew+voe0crQqEv
Received: from merlin.emma.line.org (localhost [127.0.0.1])
	by merlin.emma.line.org (Postfix) with ESMTP id 501F99440F;
	Thu, 27 May 2010 10:13:37 +0200 (CEST)
In-Reply-To: <20100526185157.GB24211@dcvr.yhbt.net>
User-Agent: Opera Mail/10.53 (Linux)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147832>

Am 26.05.2010, 20:51 Uhr, schrieb Eric Wong:

> Matthias Andree <matthias.andree@gmx.de> wrote:
>> [resending this with new Subject since there wasn't a reply in 33 days,
>> cc:ing Eric]
>>
>> === Reproduce ===
>>
>> 1. Use a git-svn checkout that has at least one subdirectory
>>
>> 2. cd to that subdirectory
>>
>> 3. run git svn rebase. It concludes successfully, then:
>>
>> 4. git diff-index HEAD -> output like the one shown above.
>>
>> This is on Cygwin 1.7.5 w/ Windows 7 32-bit professional German.
>
> Hi Matthias,
>
> I can't reproduce this on a GNU/Linux system, so I'm guessing this
> is a weird Cygwin/Windows issue, and I don't know Windows.

Do you deem it possible to have the workaround applied in code, i. e.  
change to the top-level directory up front?

If not, any hints as to debugging facilities and procedures beyond  
GIT_TRACE?

-- 
Matthias Andree
