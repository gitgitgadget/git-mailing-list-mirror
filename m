From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: timestamps not git-cloned
Date: Fri, 28 Nov 2008 13:58:24 +0100
Message-ID: <200811281358.24592.robin.rosenberg.lists@dewire.com>
References: <87ej0wwptn.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Nov 28 13:59:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L62wp-0001R6-2J
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 13:59:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837AbYK1M6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 07:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754776AbYK1M6a
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 07:58:30 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:55126 "EHLO
	pne-smtpout1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754806AbYK1M63 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Nov 2008 07:58:29 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout1-sn2.hy.skanova.net (7.3.129)
        id 48A144C501C6EF9E; Fri, 28 Nov 2008 13:58:25 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-10-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <87ej0wwptn.fsf@jidanni.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101873>

fredag 28 november 2008 03:24:04 skrev jidanni@jidanni.org:
> Gentlemen, it's my first git-clone,
> $ git-clone git://git.debian.org/git/pkg-fso/files.git
> and I'm disappointed to find the timestamps of the files created are
> all now and not the date of last edit. At least mention something
> about this on the git-clone man page.

I recommend every new Git user to scan the FAQ. It's not just clone,
it's in everything git does in the file system. There is a very good 
reason git behaves this way in general, although clone could be
exception, but then we would have a ton of questions about that
inconsistency.

-- robin
