From: Rocco Rutte <pdmef@gmx.net>
Subject: Re: mercurial to git
Date: Thu, 8 Mar 2007 09:01:07 +0000
Organization: Berlin University of Technology
Message-ID: <20070308090107.GB2881@peter.daprodeges.fqdn.th-h.de>
References: <20070306210629.GA42331@peter.daprodeges.fqdn.th-h.de> <20070306215459.GI18370@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 10:01:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPEVP-0004bQ-TW
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 10:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbXCHJBO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 04:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbXCHJBN
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 04:01:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:43047 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030357AbXCHJBL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 04:01:11 -0500
Received: (qmail invoked by alias); 08 Mar 2007 09:01:10 -0000
Received: from unknown (EHLO peter.daprodeges.fqdn.th-h.de) [62.117.31.238]
  by mail.gmx.net (mp047) with SMTP; 08 Mar 2007 10:01:10 +0100
X-Authenticated: #1642131
X-Provags-ID: V01U2FsdGVkX19tFxlELfdtL2qO9i+HBForKqa9dBNJZHimRwiXaJ
	hpJw7BXcAWs+NL
Received: from peter.daprodeges.fqdn.th-h.de (peter [192.168.0.5])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by peter.daprodeges.fqdn.th-h.de (Postfix) with ESMTP id C6AE020F0D
	for <git@vger.kernel.org>; Thu,  8 Mar 2007 09:01:08 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070306215459.GI18370@thunk.org>
X-GnuPG-Key: http://user.cs.tu-berlin.de/~pdmef/rrutte.gpg
X-Blog: http://user.cs.tu-berlin.de/~pdmef/horst.cgi?o
X-System: peter.daprodeges.fqdn.th-h.de (FreeBSD 6.2-STABLE i386)
User-Agent: Mutt/1.5.14 (2007-03-06)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41720>

Hi,

* Theodore Tso [07-03-06 16:54:59 -0500] wrote:

>Hmm.... the way I was planning on handling the performance bottleneck
>was to use "hg manifest --debug <rev>" and diffing the hashes against
>its parents.  Using "hg manifest" only hits .hg/00manifest.[di] and
>.hg/00changelog.[di] files, so it's highly efficient.  With the
>--debug option to hg manifest (not needed on some earlier versions of
>hg, but it seems to be needed on the latest development version of
>hg), it outputs the mode and SHA1 hash of the files, so it becomes
>easy to see which files were changed relative to the revision's
>parent(s).

>Once we know which files we need to feed to git-fast-import, it's just
>a matter of using "hg cat -r <rev> <pathname>" to feed the individual
>changed file to git-fast-import.

I've done that now and the repositories come out as before in about 10 
minutes. Also I sanitized the tags handling and will push out the 
changed version somewhere soon.

   bye, Rocco
-- 
:wq!
