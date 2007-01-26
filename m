From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: cvsimport/cvsps: wrong revisions in branch
Date: Sat, 27 Jan 2007 00:12:49 +0100
Organization: Dewire
Message-ID: <200701270012.50157.robin.rosenberg.lists@dewire.com>
References: <20070125142242.1402.qmail@b4b5deb4d44aa3.315fe32.mid.smarden.org> <46a038f90701251806k719dd35p7b13fe049b9cf25c@mail.gmail.com> <45B99D9C.40908@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Sat Jan 27 00:12:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAaFB-0000yD-JQ
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 00:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbXAZXMW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 18:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752176AbXAZXMV
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 18:12:21 -0500
Received: from [83.140.172.130] ([83.140.172.130]:15483 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751743AbXAZXMV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 18:12:21 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 250B38027E5;
	Sat, 27 Jan 2007 00:07:44 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04557-06; Sat, 27 Jan 2007 00:07:43 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id CA990802657;
	Sat, 27 Jan 2007 00:07:41 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <45B99D9C.40908@fs.ei.tum.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37895>

fredag 26 januari 2007 07:20 skrev Simon 'corecode' Schubert:
> whichever importer you try, it *will* fail to create pure tags equivalent
> to the CVS tag.  it is not possible.  of course you can do trickery and
> create branches to simulate crooked tags.

Well, you could create a standalone tag not on any branch at all, I guess, 
just create a tree and a commit and tag corresponding to the tagged files. At 
least you wouldn't be lying about the history of the tag by implicating it 
was made through some magic merge.

-- robin
