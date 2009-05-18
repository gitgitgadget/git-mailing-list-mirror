From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: git svn rebase problem
Date: Mon, 18 May 2009 10:38:30 +0200
Message-ID: <op.ut4aagco1e62zd@merlin.emma.line.org>
References: <4A0DDCC5.4010001@dlasys.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "David H. Lynch J.r" <ml@dlasys.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 10:38:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5yMt-0007LG-ED
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 10:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbZERIie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 04:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbZERIid
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 04:38:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:59873 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750768AbZERIic (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 04:38:32 -0400
Received: (qmail invoked by alias); 18 May 2009 08:38:32 -0000
Received: from unknown (EHLO mandree.no-ip.org) [85.183.215.232]
  by mail.gmx.net (mp070) with SMTP; 18 May 2009 10:38:32 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1/yP31cB57yf9YYAvYaOd4W7nbZAnnvOXctyRF0AV
	95qowu67ol0U9G
Received: from merlin.emma.line.org (localhost [127.0.0.1])
	by merlin.emma.line.org (Postfix) with ESMTP id D9A9594AC6;
	Mon, 18 May 2009 10:38:30 +0200 (CEST)
In-Reply-To: <4A0DDCC5.4010001@dlasys.net>
User-Agent: Opera Mail/9.64 (Linux)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119431>

Am 15.05.2009, 23:21 Uhr, schrieb David H. Lynch J.r <ml@dlasys.net>:

> For some time I am using git svn to manage a local copy of a remote svn
> repository.
>
> The svn repository has no branches.
>
> A few days ago I did an
> git svn rebase
>
> The rebase took a while and after it completed reported
> fatal: bad object HEAD
>
> git status reports
> root@hp-dhlii:/usr/src/pico/git# git status
> # Not currently on any branch.
> fatal: bad object HEAD
>
> and git fsck reports
> root@hp-dhlii:/usr/src/pico/git# git fsck
> dangling blob eb3afb4aa3aaf0003bac601a5db4fd76aafa2a87
> dangling commit 5c496db25007c17c325f294bb8324097c9bc407d
>
> How can I recover without downloading the entire repository again which
> could take days?

Have you been working on a branch other than the one that git-svn created  
for you? If so, you may have to "git checkout" the original branch before  
being able to "git svn rebase".

Branches and git-svn don't mix.

-- 
Matthias Andree
