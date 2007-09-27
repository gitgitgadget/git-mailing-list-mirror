From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT] UTF-8 in author names in history views read as ISO-8859-1
Date: Thu, 27 Sep 2007 20:59:32 +0200
Message-ID: <200709272059.32934.robin.rosenberg.lists@dewire.com>
References: <fdel0j$na4$3@sea.gmane.org> <200709272053.41795.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: =?utf-8?q?Jos=C3=A9_Fonseca?= <j_r_fonseca@yahoo.co.uk>
X-From: git-owner@vger.kernel.org Thu Sep 27 20:57:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IayYU-0005T8-Kw
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 20:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756614AbXI0S51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 14:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758193AbXI0S50
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 14:57:26 -0400
Received: from [83.140.172.130] ([83.140.172.130]:19370 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756614AbXI0S5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 14:57:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 92B73802872;
	Thu, 27 Sep 2007 20:49:07 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12056-01; Thu, 27 Sep 2007 20:49:07 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 3A6D380264D;
	Thu, 27 Sep 2007 20:49:07 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <200709272053.41795.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59310>

torsdag 27 september 2007 skrev Robin Rosenberg:
> Encoding is largeley neglected. Actually conversions are made because one
> has to, but there is no consistency there. Git mostly neglect encodings and
> so does anything that attempt to be compatible with it. I have some patches
> towards improvement. A problem is that conversion to or from UTF-8 and back
> are not reversible, especially when the input is invalid for the conversion. This
> *will* happen when dealing with git repos that contain non-ascii comments or
> file names.

A confession. The only thing we do cater for is the encoding header in commits.

-- robin
