From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT] assertion failure when renaming file
Date: Tue, 17 Mar 2009 19:40:21 +0100
Message-ID: <200903171940.21617.robin.rosenberg.lists@dewire.com>
References: <gpnrcv$mla$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marcus Better <marcus@better.se>
X-From: git-owner@vger.kernel.org Tue Mar 17 19:42:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjeFE-0004Om-S7
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 19:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755570AbZCQSka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 14:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754670AbZCQSka
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 14:40:30 -0400
Received: from mail.dewire.com ([83.140.172.130]:16920 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754337AbZCQSk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 14:40:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 6ED81138AD5E;
	Tue, 17 Mar 2009 19:40:24 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1rUVopzrQHm5; Tue, 17 Mar 2009 19:40:23 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 70A99138AD53;
	Tue, 17 Mar 2009 19:40:23 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-12-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <gpnrcv$mla$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113515>

tisdag 17 mars 2009 10:43:52 skrev Marcus Better <marcus@better.se>:
> Hi,
Hej,

> I get this assertion failure from the Eclipse plugin 0.4.0.200903110025 whenever I try to rename an untracked file in Eclipse:

There  are some ways of corrupting a repo, i.e. the association between the Git provider and the project that results in wierd
behaviours. The ones I know of are related to renaming and moving projects tracked by EGit, which works minus-well.

Could you try with a fresh workspace (you can keep the workdir as-is)?

-- robin
