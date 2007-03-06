From: Rocco Rutte <pdmef@gmx.net>
Subject: Re: mercurial to git
Date: Tue, 6 Mar 2007 22:47:47 +0000
Organization: Berlin University of Technology
Message-ID: <20070306224747.GB42331@peter.daprodeges.fqdn.th-h.de>
References: <20070306210629.GA42331@peter.daprodeges.fqdn.th-h.de> <20070306215459.GI18370@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 23:48:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOiRw-0004Vn-DD
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 23:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030420AbXCFWrv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 17:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030428AbXCFWrv
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 17:47:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:48012 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030420AbXCFWru (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 17:47:50 -0500
Received: (qmail invoked by alias); 06 Mar 2007 22:47:49 -0000
Received: from cable-62-117-25-74.cust.blue-cable.de (EHLO peter.daprodeges.fqdn.th-h.de) [62.117.25.74]
  by mail.gmx.net (mp036) with SMTP; 06 Mar 2007 23:47:49 +0100
X-Authenticated: #1642131
X-Provags-ID: V01U2FsdGVkX1/wc8t4OPjwTwLZcSTxw2iadlBG9EwvEDV3Sr4CML
	xYeKyi9Wu7YY12
Received: from peter.daprodeges.fqdn.th-h.de (peter [192.168.0.5])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by peter.daprodeges.fqdn.th-h.de (Postfix) with ESMTP id 89E2720F0D
	for <git@vger.kernel.org>; Tue,  6 Mar 2007 22:47:48 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070306215459.GI18370@thunk.org>
X-GnuPG-Key: http://user.cs.tu-berlin.de/~pdmef/rrutte.gpg
X-Blog: http://user.cs.tu-berlin.de/~pdmef/horst.cgi?o
X-System: peter.daprodeges.fqdn.th-h.de (FreeBSD 6.2-STABLE i386)
User-Agent: Mutt/1.5.14-pdmef (2007-02-28)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41605>

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

I started getting/looking at hg a few days ago, mainly at the source 
only so that I likely miss some things...

Hmm. I'll need to further read the hg source to see how they do it. I 
now switched to defaulting to use the hg changes for normal changesets 
and the full manifest for merges. That's a huge boost already. Your 
approach sounds even better... so that I'll use it. :)

   bye, Rocco
-- 
:wq!
