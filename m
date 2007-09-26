From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Add --no-rename to git-apply
Date: Thu, 27 Sep 2007 00:31:08 +0200
Message-ID: <200709270031.09739.robin.rosenberg@dewire.com>
References: <11908420041596-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Sep 27 00:29:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IafNa-0005l7-4C
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 00:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759587AbXIZW3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 18:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758492AbXIZW3G
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 18:29:06 -0400
Received: from [83.140.172.130] ([83.140.172.130]:8617 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751530AbXIZW3F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 18:29:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 6D9228028BC;
	Thu, 27 Sep 2007 00:20:47 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 01140-05; Thu, 27 Sep 2007 00:20:47 +0200 (CEST)
Received: from [10.9.0.6] (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id 2F5D580286A;
	Thu, 27 Sep 2007 00:20:47 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <11908420041596-git-send-email-robin.rosenberg@dewire.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59254>

onsdag 26 september 2007 skrev Robin Rosenberg:
> With this option git-apply can apply a patch with a rename
> onto the original file(s).

The reason (off the record) is that I use it for exporting to another
more expen$ive SCM, that does rename tracking so I need to keep
the file with the original name until telling the other SCM to rename
the file. It may be useful for others doing similar things.

-- robin
