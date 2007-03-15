From: Rocco Rutte <pdmef@gmx.net>
Subject: Re: mercurial to git
Date: Thu, 15 Mar 2007 15:19:37 +0000
Organization: Berlin University of Technology
Message-ID: <20070315151936.GA31087@peter.daprodeges.fqdn.th-h.de>
References: <20070306210629.GA42331@peter.daprodeges.fqdn.th-h.de> <20070306215459.GI18370@thunk.org> <20070306230802.GA17226@filer.fsl.cs.sunysb.edu> <20070307001105.GJ18370@thunk.org> <20070314111257.GA4526@peter.daprodeges.fqdn.th-h.de> <20070315002505.GA31770@thunk.org> <20070315101913.GA9831@peter.daprodeges.fqdn.th-h.de> <20070315141227.GA18416@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 15 16:19:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRrkE-00005V-IR
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 16:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422891AbXCOPTm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 11:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422892AbXCOPTm
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 11:19:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:39773 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422891AbXCOPTl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 11:19:41 -0400
Received: (qmail invoked by alias); 15 Mar 2007 15:19:39 -0000
X-Provags-ID: V01U2FsdGVkX18uK9kypvcun6KwhINcjgppTd+eTddcKHWUEcZx7w
	LYUeNJNS4uKKrg
Received: from peter.daprodeges.fqdn.th-h.de (peter [192.168.0.5])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by peter.daprodeges.fqdn.th-h.de (Postfix) with ESMTP id AE93320F0D
	for <git@vger.kernel.org>; Thu, 15 Mar 2007 15:19:38 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070315141227.GA18416@thunk.org>
X-GnuPG-Key: http://user.cs.tu-berlin.de/~pdmef/rrutte.gpg
X-Blog: http://user.cs.tu-berlin.de/~pdmef/horst.cgi?o
X-System: peter.daprodeges.fqdn.th-h.de (FreeBSD 6.2-STABLE i386)
User-Agent: Mutt/1.5.14 (2007-03-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42286>

Hi,

* Theodore Tso [07-03-15 10:12:27 -0400] wrote:
>On Thu, Mar 15, 2007 at 10:19:13AM +0000, Rocco Rutte wrote:
>> I failed to send a response to the list and it went Theodore privately 
>> only, sorry. I merged hg2git into fast-export.git at repo.or.cz and 
>> named it 'hg-fast-export' to match with the other importers there. It 
>> now can parse Signed-off-by lines and supports author maps (as 
>> git-cvsimport and git-svnimport do, same syntax).

>BTW, there are a number of places where the old name (hg2git) is still
>being used for filenames, et.al, because $PFX is still being set to
>hg2git.

I know and intend to leave it that way as the filenames are shorter.

>The date seems to be correctly generated using

>	hg-fast-export.sh -s -A ../e2fsprogs.authors -r ../e2fsprogs
>	hg-fast-export.sh -s -r ../e2fsprogs
>	hg-fast-export.sh -r ../e2fsprogs

>It seems to be this combination of options:

>	hg-fast-export.sh -A ../e2fsprogs.authors -r ../e2fsprogs

>Where all of the dates end up being Jan 1, 1970.

Hmm. Strange, I cannot reproduce this. Can you mail me your authors file 
along with version information privately please?

   bye, Rocco
-- 
:wq!
