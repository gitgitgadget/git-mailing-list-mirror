From: Rocco Rutte <pdmef@gmx.net>
Subject: Re: mercurial to git
Date: Thu, 15 Mar 2007 10:19:13 +0000
Organization: Berlin University of Technology
Message-ID: <20070315101913.GA9831@peter.daprodeges.fqdn.th-h.de>
References: <20070306210629.GA42331@peter.daprodeges.fqdn.th-h.de> <20070306215459.GI18370@thunk.org> <20070306230802.GA17226@filer.fsl.cs.sunysb.edu> <20070307001105.GJ18370@thunk.org> <20070314111257.GA4526@peter.daprodeges.fqdn.th-h.de> <20070315002505.GA31770@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 15 11:19:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRn3J-0006xC-UI
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 11:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbXCOKTS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 06:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbXCOKTS
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 06:19:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:49630 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751785AbXCOKTR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 06:19:17 -0400
Received: (qmail invoked by alias); 15 Mar 2007 10:19:16 -0000
X-Provags-ID: V01U2FsdGVkX1/+lhIv04z+ipRS0UJoqNs8xgCnuclX7ugR20HsBp
	GK7qf16ONRkQ1N
Received: from peter.daprodeges.fqdn.th-h.de (peter [192.168.0.5])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by peter.daprodeges.fqdn.th-h.de (Postfix) with ESMTP id 19EE120F0D
	for <git@vger.kernel.org>; Thu, 15 Mar 2007 10:19:15 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070315002505.GA31770@thunk.org>
X-GnuPG-Key: http://user.cs.tu-berlin.de/~pdmef/rrutte.gpg
X-Blog: http://user.cs.tu-berlin.de/~pdmef/horst.cgi?o
X-System: peter.daprodeges.fqdn.th-h.de (FreeBSD 6.2-STABLE i386)
User-Agent: Mutt/1.5.14 (2007-03-07)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42276>

Hi,

* Theodore Tso [07-03-14 20:25:07 -0400] wrote:
>On Wed, Mar 14, 2007 at 11:12:57AM +0000, Rocco Rutte wrote:

I failed to send a response to the list and it went Theodore privately 
only, sorry. I merged hg2git into fast-export.git at repo.or.cz and 
named it 'hg-fast-export' to match with the other importers there. It 
now can parse Signed-off-by lines and supports author maps (as 
git-cvsimport and git-svnimport do, same syntax).

>> I tried the import on the e2fsprogs repo and the files come out 
>> identical, authors/comitters look okay to me, too.

>Very cool!  It looks like some of the git author dates are only
>getting set if the -s flag is set.  Was that intentional?

For which changesets exactly? The script only attempts to write out the 
'author' command if -s (for parsing signed-off-by) is given. But for 
both commands the time information written out are identical and are 
exactly what hg gives us. So the bug must be elsewhere.

   bye, Rocco
-- 
:wq!
