From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 0/5] RevWalk fixes for UNINTERESTING
Date: Fri, 13 Mar 2009 21:00:26 +0100
Message-ID: <200903132100.26527.robin.rosenberg.lists@dewire.com>
References: <1236910062-18476-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 13 21:02:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiDa1-0000fu-F5
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 21:02:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbZCMUAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 16:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752286AbZCMUAg
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 16:00:36 -0400
Received: from mail.dewire.com ([83.140.172.130]:15138 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549AbZCMUAf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 16:00:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 927E6139A475;
	Fri, 13 Mar 2009 21:00:28 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a8mRlFYQD2sd; Fri, 13 Mar 2009 21:00:28 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id EA650139A474;
	Fri, 13 Mar 2009 21:00:27 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-12-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <1236910062-18476-1-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113219>

fredag 13 mars 2009 03:07:37 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> Today I uncovered some ugly cases with "jgit rev-list B ^A", where
> some commits reachable from A were still being output, even though
> we asked that they be excluded.

How about a test suite to prove this is better than before?

-- robin
