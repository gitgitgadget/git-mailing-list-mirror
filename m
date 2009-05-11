From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH] Fix data corruption in DirCacheIterator when EmptyTreeIterator is used
Date: Mon, 11 May 2009 20:59:57 +0200
Message-ID: <200905112059.58212.robin.rosenberg.lists@dewire.com>
References: <1242064348-13197-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Mark Struberg <struberg@yahoo.de>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 11 21:00:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3ajY-0001tk-DW
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 21:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbZEKTAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 15:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753245AbZEKTAG
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 15:00:06 -0400
Received: from mail.dewire.com ([83.140.172.130]:22919 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752271AbZEKTAF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 15:00:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 711C91444173;
	Mon, 11 May 2009 21:00:00 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fzVDcBUVc1Cd; Mon, 11 May 2009 20:59:59 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.10])
	by dewire.com (Postfix) with ESMTP id BF25C144416E;
	Mon, 11 May 2009 20:59:59 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1242064348-13197-1-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Shouldn't we update some unit tests too? The dircache must be reliable.

-- robin
