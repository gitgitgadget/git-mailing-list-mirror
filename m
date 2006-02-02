From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 0/2] Make merge recursive faster in some cases
Date: Thu, 2 Feb 2006 12:38:48 +0100
Message-ID: <20060202113848.GA8103@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Feb 02 12:39:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4cno-0008WC-4m
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 12:39:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWBBLiy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 06:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWBBLiy
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 06:38:54 -0500
Received: from [85.8.31.11] ([85.8.31.11]:63397 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1750803AbWBBLix (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2006 06:38:53 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id B6FE14114; Thu,  2 Feb 2006 12:52:18 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1F4cnY-0007Wv-00; Thu, 02 Feb 2006 12:38:48 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15502>

The first patch teaches git-merge-recursive how to use the bases that
are supplied by the merge driver program in some cases. To be more
precise: if git-merge-recursive is supplied with a single base then
that one will be used, otherwise git-merge-recursive will compute the
bases on its own.

The second patch makes the commit graph construction more efficient.

- Fredrik
