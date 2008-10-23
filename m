From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT RFC PATCH 3/3] Rate limit warnings spewed by RepositoryTestCase.recursiveDelete
Date: Fri, 24 Oct 2008 01:10:21 +0200
Message-ID: <200810240110.21755.robin.rosenberg@dewire.com>
References: <20081022083420.GC17940@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Oct 24 01:12:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt9Lc-0006wf-Dy
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 01:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbYJWXKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 19:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755535AbYJWXKe
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 19:10:34 -0400
Received: from mail.dewire.com ([83.140.172.130]:18780 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757821AbYJWXKb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 19:10:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 513E6147EAE9;
	Fri, 24 Oct 2008 01:10:29 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5UHf+JM+kC2K; Fri, 24 Oct 2008 01:10:28 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id BC20B802E07;
	Fri, 24 Oct 2008 01:10:28 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20081022083420.GC17940@diku.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98992>

onsdagen den 22 oktober 2008 10.34.20 skrev Jonas Fonseca:
> On Windows XP / NTFS / NetBeans 6.1 / Java 5 a lot of warnings are
> printed. In most cases the path is in fact deleted and it seems to just
> be a timing bug or something Windows or NTFS specific. Also, many of the
> warnings are for the same paths and therefore a bit redundant.
> Furthermore, when a lot of warnings are printed it gives the feeling of
> slowing down the tests. By rate limiting the warnings the problem is
> still made visible for developers to notice.

The problem is actually flaws in the unit tests and in the supporting RepositoryTestCase.
I think I'll fix that instead.

-- robin
