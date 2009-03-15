From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 3/3] Use a common skipObject method to avoid UNINTERESTING items
Date: Sun, 15 Mar 2009 01:25:56 +0100
Message-ID: <200903150125.56987.robin.rosenberg.lists@dewire.com>
References: <1236967912-15088-1-git-send-email-spearce@spearce.org> <1236967912-15088-2-git-send-email-spearce@spearce.org> <1236967912-15088-3-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Mar 15 01:27:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LieCX-0006fy-Pd
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 01:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624AbZCOA0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 20:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753248AbZCOA0H
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 20:26:07 -0400
Received: from mail.dewire.com ([83.140.172.130]:19885 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723AbZCOA0G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 20:26:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 2299F139A44D;
	Sun, 15 Mar 2009 01:25:58 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1KzbgAqgLRvy; Sun, 15 Mar 2009 01:25:58 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 6C8D280289B;
	Sun, 15 Mar 2009 01:25:58 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-12-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <1236967912-15088-3-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113270>

fredag 13 mars 2009 19:11:52 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> All cases are using the same logic to decide that we should skip
> this current object and not return it to the caller.  A common
> implementation makes the code easier to follow, especially as it
> reduces the ugly line wrap involved in the loop body.

Java conventions dictate that this method should be called shouldSkipObject. It
is a boolean method that actually does not itself skip any objects.

I can amend that for you.

-- robin
