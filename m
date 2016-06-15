From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: patch series starting with [JGIT PATCH 1/5] Remove dead/unused reset method from CountingOutputStream
Date: Sat, 28 Mar 2009 00:53:24 +0100
Message-ID: <200903280053.25070.robin.rosenberg.lists@dewire.com>
References: <1238030515-31768-1-git-send-email-spearce@spearce.org> <200903270911.54571.robin.rosenberg.lists@dewire.com> <20090327145550.GN23521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Marek Zawirski <marek.zawirski@gmail.com>,
	Daniel Cheng <j16sdiz+freenet@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 28 00:56:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnLuA-0007Kl-6a
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 00:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759276AbZC0Xxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 19:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764371AbZC0Xxe
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 19:53:34 -0400
Received: from mail.dewire.com ([83.140.172.130]:6258 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765132AbZC0Xxd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 19:53:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A8CB21484DA5;
	Sat, 28 Mar 2009 00:53:26 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eEawAaRhUyGo; Sat, 28 Mar 2009 00:53:25 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id DF634800784;
	Sat, 28 Mar 2009 00:53:25 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-14-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <20090327145550.GN23521@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114927>

fredag 27 mars 2009 15:55:50 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> > Seems fine. While verifying this I got this error.
> > 
> > jgit push sftp://me@calhost/home/me/tmp/cb/.git master:master
> > 
> > Counting objects:       20464
> > Compressing objects:    100% (20464/20464)
> > Writing objects:        100% (20464/20464)
> > fatal: Can't write /home/me/tmp/cb/.git/objects/../HEAD: Failure
> > fatal: sftp://me@localhost/home/me/tmp/cb/.git: cannot create HEAD
> 
> I can't reproduce this error with sftp://.
> 
> At first, it failed to push because my target directory didn't exist.
Same here.

> After I made the target directory, I also had to create below it
> "refs", "objects", "objects/pack" in order to get the push to
> succeed, and then it went through clean.

hm, I git init'd the repo on the server, that's cheating I suppose.

-- robin
