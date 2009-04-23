From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: Git-SVN on Cygwin: svn+ssh good, https awkward
Date: Thu, 23 Apr 2009 20:16:00 +0200
Message-ID: <op.usuqcyp81e62zd@balu.cs.uni-paderborn.de>
References: <op.usulh7a71e62zd@balu.cs.uni-paderborn.de>
 <loom.20090423T175124-165@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: "Eric Blake" <ebb9@byu.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 20:18:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx3UR-0003MN-7u
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 20:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831AbZDWSQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 14:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756320AbZDWSQE
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 14:16:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:58871 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755463AbZDWSQD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 14:16:03 -0400
Received: (qmail invoked by alias); 23 Apr 2009 18:16:01 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu.cs.uni-paderborn.de) [131.234.21.37]
  by mail.gmx.net (mp001) with SMTP; 23 Apr 2009 20:16:01 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX18VQ+RTdBgVT4/Jeo960NpBnujzs25YAOuV+h1dGJ
	y+/LEAEVBGQ1py
In-Reply-To: <loom.20090423T175124-165@post.gmane.org>
User-Agent: Opera Mail/9.64 (Win32)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117355>

Am 23.04.2009, 19:58 Uhr, schrieb Eric Blake <ebb9@byu.net>:

>> Can we use unique tempfile names (timestamps, counter, random number
>> generator) instead of the hardcoded "tempfile.tmp"? This is probably a
>> good idea anyways to evade symlink attacks.
>
> Although newer cygwin may fix your particular problem, this is not a bad
> suggestion for msysgit, so I suspect someone may be bothered enough by  
> this to write a patch.  I, however, will not be the one doing it.

Hi Eric,

thanks for the hints and pointers to Cygwin 1.7 beta, however I'd suggest  
to make such changes upstream (i. e. in git.git) for the benefit of  
everybody else.

It also looks to me as though minor changes in the actual baseline Git  
code may be sufficient to get git-svn working on Cygwin 1.5 (stable)  
already. I'd prefer such a minor intrusion to hacking away on forks. :-)

Otherwise I'd start looking at how git-svn handles https:// and svn+ssh://  
methods differently from each other next week or so.

Looking forward to further insights.

-- 
Matthias Andree
