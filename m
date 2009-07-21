From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH v2] FindBugs: don't use new String(String) in RefDatabase
Date: Tue, 21 Jul 2009 21:47:12 +0200
Message-ID: <200907212147.12878.robin.rosenberg.lists@dewire.com>
References: <49C20D4E.5020203@gmail.com> <200907211650.36831.robin.rosenberg.lists@dewire.com> <20090721150337.GP11191@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Yann Simon <yann.simon.fr@gmail.com>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 21 21:47:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTLJ7-0004CM-Ot
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 21:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755793AbZGUTrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 15:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755145AbZGUTrQ
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 15:47:16 -0400
Received: from mail.dewire.com ([83.140.172.130]:6926 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754035AbZGUTrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 15:47:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id CF0E61481DB3;
	Tue, 21 Jul 2009 21:47:15 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id alVOJNKLXM0W; Tue, 21 Jul 2009 21:47:15 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id 503F51481DA3;
	Tue, 21 Jul 2009 21:47:15 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <20090721150337.GP11191@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123687>

tisdag 21 juli 2009 17:03:37 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> > Shawn, any references for the ability of JIT's abilities to stack allocate in this context? For
> > me learning, will commit anyway.
> 
> See [1] for example.  I read a presentation from a HotSpot engineer
> at Sun a year or two ago that talked about it as a feature in the
> Sun Java 6 runtime, but I can't track that down now.
>
...
> 
> [1] http://www.ibm.com/developerworks/java/library/j-jtp09275.html?ca=dgr-lnxw01JavaUrbanLegends
> [2] http://java.sun.com/javase/6/webnotes/6u14.html
> 

Thanks. HotSpot rules.

-- robin
