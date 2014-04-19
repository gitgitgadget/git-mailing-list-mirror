From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [ANNOUNCE] WinGit - native x86/x64 Git for Windows
Date: Sat, 19 Apr 2014 22:56:57 +0200
Message-ID: <5352E319.2010808@gmail.com>
References: <rfujmbew27f1gaa6dbk706li.1397911737867@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 22:57:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbcKA-0007cs-6h
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 22:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbaDSU5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 16:57:18 -0400
Received: from plane.gmane.org ([80.91.229.3]:45174 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751236AbaDSU5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2014 16:57:16 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WbcK0-0007Od-U8
	for git@vger.kernel.org; Sat, 19 Apr 2014 22:57:12 +0200
Received: from p57a24b51.dip0.t-ipconnect.de ([87.162.75.81])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 Apr 2014 22:57:12 +0200
Received: from sschuberth by p57a24b51.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 Apr 2014 22:57:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p57a24b51.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <rfujmbew27f1gaa6dbk706li.1397911737867@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246540>

On 19.04.2014 15:35, Marat Radchenko wrote:

> But in practice, msysgit is:
>   1) outdated msys that was patched in multiple ways without
>    sending patches upstream

It's not true that we are not sending patches upstream to MSYS, see [1]. 
It's just that most of them don't get included due to a lack of time 
from the MSYS maintainers, see e.g. [2].

>   2) heavily patched git, again not upstreamed

"Heavily" is relative, in fact it's not that much that I would give up 
hope on getting everything upstream. We once had put large efforts in 
bringing our stuff to upstream Git, just to over and over again being 
pulled into fussy discussions, costing way more time than developing the 
patches themselves. So at some time most of us just decided to spend 
their time more efficiently by bringing Git for Windows forward.

> To be honest, msys isn't a great tool. After all, it's just outdated
> and heavily patched cygwin. There exists msys2 project (much less outdated and much less patched cygwin).

I agree that MSYS is not at all that great (anymore). It simply does not 
seem to be well maintained. But neither do I trust MSYS2 (yet), which 
looks to me like a spare time project by one or two guys, both newcomers 
not part of the original MSYS team. However, if MSYS2 turns out to be 
maintained better than MSYS in the future, I'm open to base 
mingwGitDevEnv on MSYS2.

> 1) It makes sense to purge msysgit and start over. See mingwGitDevEnv [2] (by msysgit developer).

You would have been very welcomed to contribute 64-bit support to 
mingwGitDevEnv (which I'm the maintainer of). I saddens me that we blow 
out our energy on forks (without even getting in touch first) instead of 
pulling together.

[1] http://sourceforge.net/p/mingw/bugs/search/?q=msysgit
[2] http://sourceforge.net/p/mingw/bugs/1823/

-- 
Sebastian Schuberth
