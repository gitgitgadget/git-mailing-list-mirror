From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH v2 00/11] WindowCache rewrite... with tests
Date: Thu, 30 Apr 2009 01:46:30 +0200
Message-ID: <200904300146.31062.robin.rosenberg.lists@dewire.com>
References: <1241031288-23437-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Apr 30 01:46:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzJUC-0001pB-QM
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 01:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbZD2Xqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 19:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbZD2Xqg
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 19:46:36 -0400
Received: from mail.dewire.com ([83.140.172.130]:12519 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104AbZD2Xqf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 19:46:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9BFEF1023426;
	Thu, 30 Apr 2009 01:46:34 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xuuM5kY7wRlZ; Thu, 30 Apr 2009 01:46:32 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 0A8531023260;
	Thu, 30 Apr 2009 01:46:31 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1241031288-23437-1-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117980>

onsdag 29 april 2009 20:54:37 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> 9-11 is the rewrite of WindowCache, with new unit tests to get higher
> levels of coverage in this section of the code.  Actually doing
> better is really hard, as we'd need to cause thread race conditions
> deep within critical sections.  The only way I can think to do that
> is to add injection points where we can insert "evil other thread"
> logic during the unit test, and rely on the JIT to compile them
> out in normal application usage.  Ick.  Its also quite fragile.

Testing *is* hard. No news here. There are various techniques for 
injecting code using AOP (AspjectJ) that may be useful for testing,
since we could inject failures that way without the overhead of
injection points in normal execution. 

-- robin
