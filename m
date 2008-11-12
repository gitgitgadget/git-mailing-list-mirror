From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: fixing duplicated history
Date: Wed, 12 Nov 2008 23:52:57 +0100
Message-ID: <200811122352.57476.robin.rosenberg.lists@dewire.com>
References: <20081112222346.GA24013@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: me@felipebalbi.com
X-From: git-owner@vger.kernel.org Wed Nov 12 23:54:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0ObQ-0004oC-Rt
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 23:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336AbYKLWxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 17:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752572AbYKLWxF
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 17:53:05 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:36328 "EHLO
	pne-smtpout2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752160AbYKLWxE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Nov 2008 17:53:04 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout2-sn2.hy.skanova.net (7.3.129)
        id 4873CA9501F74BF2; Wed, 12 Nov 2008 23:52:58 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-7-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <20081112222346.GA24013@frodo>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100830>

onsdag 12 november 2008 23:23:51 skrev Felipe Balbi:
> Hi,
> 
> I have a git tree which history is completely messed up with duplicated
> entries. By reading git man pages I saw that it might be possible to
> delete those duplicated entries with git reflog delete, am I reading it
> right ?
No. The reflog is not the history, except your very local log of what
the heads pointed to. You do not see the reflog unless you ask for it,
and nobody else can see it (i.e. *your* reflog).

What looks like duplicate entries may commit that have been cherry
picked into one or more branches that have been merged thereafter. If
you look carefully they have different id's.

-- robin
